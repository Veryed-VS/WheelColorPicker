//
//  BTWColorPickerBrightnessSlider.h
//  CustomColorWheel
//
//  Created by 肖建明 on 16/1/13.
//  Copyright © 2016年 XJM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol brightnessSliderDelete <NSObject>
@optional
-(void)brightnessSliderColor:(UIColor *)color;
@end

@interface BTWColorPickerBrightnessSlider : UIControl
{
    CAGradientLayer *gradientLayer;
    UIImageView *sliderKnobView;
    CGFloat colorH;
    CGFloat colorS;
    CGFloat colorV;
}
@property (nonatomic) CGFloat value;
- (void) setKeyColor:(UIColor *)c;

@property(weak,nonatomic) id<brightnessSliderDelete> deledate;
@property (nonatomic,strong) UIColor *currentColor;

@end
