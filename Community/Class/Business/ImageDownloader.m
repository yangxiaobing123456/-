//
//  ImageDownloader.m
//  Community
//
//  Created by SYZ on 13-11-28.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "ImageDownloader.h"
#import "GTMHTTPFetcher.h"
#import "FileUtil.h"
#import "ImageUtil.h"
#import "CKImageAdditions.h"

@interface ImageDownloadingTask()
{
@public
    NSData* _resultImageData;
}
@end

@implementation ImageDownloadingTask

@synthesize imageUrl = _imageUrl;
@synthesize resultImageData = _resultImageData;

-(void)setImageUrl:(NSString*)url
{
    _imageUrl = [url completeUrl];
}

@end

@interface ImageDownloadingInternalTask : NSObject
{
    NSMutableArray* tasks_;
    GTMHTTPFetcher* fetcher_;
}
@end

@implementation ImageDownloadingInternalTask

-(id)initWithTask:(ImageDownloadingTask*)task andCompetionHandler:(void(^)(BOOL succeeded))handler
{
    if(self = [self init])
    {
        tasks_ = [NSMutableArray new];
        [tasks_ addObject:task];
        
        fetcher_ = [GTMHTTPFetcher fetcherWithURLString:task.imageUrl];
        __block id __tasks = tasks_;
        __weak GTMHTTPFetcher *__fetcher = fetcher_;
        
        [fetcher_ beginFetchWithCompletionHandler:^(NSData* data,NSError* error)
         {
             [[NSURLCache sharedURLCache] removeAllCachedResponses];
             [[NSURLCache sharedURLCache] setDiskCapacity:0];
             [[NSURLCache sharedURLCache] setMemoryCapacity:0];
             
             if(error)
             {
                 DJLog(@"图片下载异常 = %d  , 信息 = %@", error.code , error.domain);
                 //下载失败
                 for (ImageDownloadingTask* task in __tasks)
                 {
                     task->_finished = YES;
                     task.completionHandler(NO,task);
                 }
                 handler(NO);
             }
             else
             {
                 //下载成功
                 
                 //判断是否是有效的图片数据
                 
                 ImageType imgType = [ImageUtil guessImageType:data];
                 if(imgType != UnknownImage)
                 {
                     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                                    {
                                        NSData* supportedData = data;
                                        if(imgType == WebpImage)
                                        {
                                            //对于webp，需要先解码
//                                            supportedData = [WebPUtil convertWebPDataToJpgOrPngData:data];
                                        }
                                        NSData* targetData = supportedData;
                                        
                                        //使用者要求转换图片尺寸
                                        if (task.imageTargetSize.width > 0 && task.imageTargetSize.height > 0)
                                        {
                                            UIImage *sourceImage = [UIImage imageWithData:supportedData];
                                            //UIImage *targetImage = [ImageUtil imageWithImage:sourceImage scaledToSizeWithSameAspectRatio:task.imageTargetSize backgroundColor:[UIColor clearColor]];
                                            UIImage* targetImage = [sourceImage imageWithSize:task.imageTargetSize contentMode:UIViewContentModeScaleAspectFit];
                                            
                                            if (CGImageGetAlphaInfo(targetImage.CGImage) == kCGImageAlphaNone)
                                            {
                                                targetData = UIImageJPEGRepresentation(targetImage, 0.8f);
                                            }
                                            else
                                            {
                                                targetData = UIImagePNGRepresentation(targetImage);
                                            }
                                        }
                                        [targetData writeToFile:task.targetFilePath atomically:YES];
                                        
                                        dispatch_sync(dispatch_get_main_queue(), ^(void)
                                                      {
                                                          for (ImageDownloadingTask* task in __tasks)
                                                          {
                                                              task->_resultImageData = targetData;
                                                              task->_finished = YES;
                                                              task.completionHandler(YES,task);
                                                          }
                                                          handler(YES);
                                                      });
                                    });
                 }
                 else
                 {
                     DJLog(@"图片格式不支持 = %@", data.bytes);
                     for (ImageDownloadingTask* task in __tasks)
                     {
                         task->_finished = YES;
                         task.completionHandler(NO,task);
                     }
                     handler(NO);
                 }
             }
         }];
        
        //更新下载数据
        __fetcher.receivedDataBlock = ^(NSData* dataRecvedSofar)
        {
            if(__fetcher.response.expectedContentLength == 0)
            {
                //do nothing
            }
            else
            {
                for (ImageDownloadingTask* task in __tasks)
                {
                    if(task.progressHandler)
                    {
                        task.progressHandler([dataRecvedSofar length] * 1.0 / __fetcher.response.expectedContentLength,task);
                    }
                }
            }
        };
        
        return self;
    }
    return nil;
}

-(NSString*)imageUrl
{
    return [(ImageDownloadingTask*)[tasks_ objectAtIndex:0] imageUrl];
}

-(void)addTask:(ImageDownloadingTask*)task
{
    if(![tasks_ containsObject:task])
        [tasks_ addObject:task];
}

-(void)removeTask:(ImageDownloadingTask*)task
{
    [tasks_ removeObject:task];
    if([tasks_ count] == 0)
    {
        //取消下载
        [fetcher_ stopFetching];
        fetcher_ = nil;
    }
}

-(int)tasksCount
{
    return [tasks_ count];
}

@end

@implementation ImageDownloader(private)

-(id) init
{
    self = [super init];
    if(self)
    {
        internalTasks_ = [NSMutableArray new];
    }
    return self;
}

-(ImageDownloadingInternalTask*) findInternalTaskByTask:(ImageDownloadingTask*)task
{
    for (ImageDownloadingInternalTask* iTask in internalTasks_)
    {
        if([[iTask imageUrl] caseInsensitiveCompare:[task imageUrl]] == NSOrderedSame)
        {
            return iTask;
        }
    }
    return nil;
}


@end


@implementation ImageDownloader

+ (ImageDownloader *)sharedInstance
{
    static ImageDownloader *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ImageDownloader alloc] init];
    });
    
    return sharedInstance;
}

-(void) download:(ImageDownloadingTask*)task
{
    if(!task.targetFilePath || [task.targetFilePath isEmptyOrBlank])
        @throw NSInvalidArgumentException;
    ImageDownloadingInternalTask* internalTask = [self findInternalTaskByTask:task];
    if(!internalTask)
    {
        //新任务
        internalTask = [[ImageDownloadingInternalTask alloc] initWithTask:task andCompetionHandler:^(BOOL succeeded)
                        {
                            //注意：这里不能直接使用internalTask变量，因为它在block之后被重新赋值
                            //如果在block中直接引用，其值将始终是nil
                            ImageDownloadingInternalTask* iTaskRefind = [self findInternalTaskByTask:task];
                            [internalTasks_ removeObject:iTaskRefind];
                        }];
        [internalTasks_ addObject:internalTask];
    }
    else
    {
        //已经存在同样的图片url处于下载进度中
        [internalTask addTask:task];
    }
}

-(void) cancelDownload:(ImageDownloadingTask*)task
{
    ImageDownloadingInternalTask* internalTask = [self findInternalTaskByTask:task];
    if(internalTask)
    {
        [internalTask removeTask:task];
        if([internalTask tasksCount] == 0)
        {
            [internalTasks_ removeObject:internalTask];
        }
    }
}

@end
