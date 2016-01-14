//
//  ViewController.h
//  CustomColorWheel
//
//  Created by 肖建明 on 16/1/13.
//  Copyright © 2016年 XJM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTWColorPickerWheel.h"
#import "BTWColorPickerBrightnessSlider.h"


@interface ViewController : UIViewController<WheelPickerColorChangle,brightnessSliderDelete>

@property (weak, nonatomic) IBOutlet BTWColorPickerWheel *wheelColorPicker;
@property (weak, nonatomic) IBOutlet BTWColorPickerBrightnessSlider *brigrnessSlideView;
@property (weak, nonatomic) IBOutlet UIView *selectColorView;
@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;
@property (weak, nonatomic) IBOutlet UIButton *threeButton;
@property (weak, nonatomic) IBOutlet UIButton *fourButton;
@property (weak, nonatomic) IBOutlet UIButton *fiveButton;

@end

