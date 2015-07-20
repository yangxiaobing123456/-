//
//  CommunityPickerView.m
//  Community
//
//  Created by SYZ on 13-12-10.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityPickerView.h"
#import "CommunityInfo.h"

@implementation CommunityPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        pickerView = [[UIPickerView alloc] initWithFrame:self.bounds];
		pickerView.delegate = self;
		pickerView.dataSource = self;
		pickerView.showsSelectionIndicator = YES;
		[self addSubview:pickerView];
    }
    return self;
}

- (void)setPickerArray:(NSArray *)pickerArray
{
    _pickerArray = pickerArray;
    [pickerView reloadAllComponents];
}

- (void)pickerViewdidSelectRow:(NSInteger)row
{
    [self pickerView:pickerView didSelectRow:row inComponent:0];
    [pickerView selectRow:row inComponent:0 animated:YES];
}

#pragma mark UIPickerViewDataSource methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return _pickerArray.count;
}

#pragma mark UIPickerViewDelegate methods
- (CGFloat)pickerView:(UIPickerView *)pView widthForComponent:(NSInteger)component
{
	return 300.0f;
}

- (NSString *)pickerView:(UIPickerView *)pView
			 titleForRow:(NSInteger)row
			forComponent:(NSInteger)component
{
    id object = [_pickerArray objectAtIndex:row];
    
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    } else if ([object isKindOfClass:[Community class]]) {
        Community *c = (Community *)object;
        return c.name;
    } else if ([object isKindOfClass:[Building class]]) {
        Building *b = (Building *)object;
        return b.name;
    } else if ([object isKindOfClass:[Unit class]]) {
        Unit *u = (Unit *)object;
        return u.name;
    } else if ([object isKindOfClass:[Room class]]) {
        Room *r = (Room *)object;
        return r.shortName;
    }
	return nil;
}

- (void)pickerView:(UIPickerView *)pView
	  didSelectRow:(NSInteger)row
	   inComponent:(NSInteger)component
{
    [_delegate pickerViewSelected:[_pickerArray objectAtIndex:row] row:row];
}

@end
