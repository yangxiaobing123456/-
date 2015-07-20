//
//  CommunityPickerView.h
//  Community
//
//  Created by SYZ on 13-12-10.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommunityPickerViewDelegate <NSObject>

@optional
- (void)pickerViewSelected:(id)object row:(int)row;

@end

@interface CommunityPickerView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIPickerView *pickerView;
}

@property (nonatomic, weak) id<CommunityPickerViewDelegate> delegate;
@property (nonatomic, strong) NSArray *pickerArray;

- (void)pickerViewdidSelectRow:(NSInteger)row;

@end
