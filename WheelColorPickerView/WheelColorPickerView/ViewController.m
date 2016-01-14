//
//  ViewController.m
//  CustomColorWheel
//
//  Created by 肖建明 on 16/1/13.
//  Copyright © 2016年 XJM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wheelColorPicker.delege = self;
    self.brigrnessSlideView.deledate = self;
    [self.oneButton.layer setCornerRadius:25];
    [self.twoButton.layer setCornerRadius:25];
    [self.threeButton.layer setCornerRadius:25];
    [self.fourButton.layer setCornerRadius:25];
    [self.fiveButton.layer setCornerRadius:25];
}

-(void)wheelColorChangle:(UIColor *)color
{
    [self.brigrnessSlideView setKeyColor:color];
    self.selectColorView.backgroundColor = color;
}
-(void)brightnessSliderColor:(UIColor *)color
{
    self.selectColorView.backgroundColor = color;
}
- (IBAction)colorButtonClick:(UIButton *)sender {
    self.wheelColorPicker.currentColor = sender.backgroundColor;
    [self.brigrnessSlideView setKeyColor:sender.backgroundColor];
    [self.selectColorView setBackgroundColor:sender.backgroundColor];
}

@end
