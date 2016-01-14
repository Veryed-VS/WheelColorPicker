//
//  BTWColorPickerWheel.h
//  CustomColorWheel
//
//  Created by 肖建明 on 16/1/13.
//  Copyright © 2016年 XJM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WheelPickerColorChangle <NSObject>
@optional
-(void)wheelColorChangle:(UIColor *)color;
@end

@interface BTWColorPickerWheel : UIControl
{
    UIColor *currentColor;
}

@property (nonatomic,strong) UIColor *currentColor;

@property (nonatomic, retain) UIImageView *wheelImageView;   //色盘图片
@property (nonatomic, retain) UIImageView *wheelKnobView;    //指针图片

@property(weak,nonatomic) id<WheelPickerColorChangle> delege;

@end
