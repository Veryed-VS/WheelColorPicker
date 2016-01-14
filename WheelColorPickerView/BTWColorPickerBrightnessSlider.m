//
//  BTWColorPickerBrightnessSlider.m
//  CustomColorWheel
//
//  Created by 肖建明 on 16/1/13.
//  Copyright © 2016年 XJM. All rights reserved.
//

#import "BTWColorPickerBrightnessSlider.h"

@implementation BTWColorPickerBrightnessSlider
@synthesize value;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initData];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        [self initData];
    }
    return self;
}
-(void)initData{
    gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.bounds = self.bounds;
    gradientLayer.position = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    gradientLayer.cornerRadius = 5.0;
    gradientLayer.borderWidth = 1.0;
    gradientLayer.borderColor = [[UIColor grayColor] CGColor];  //设置描边
    [self.layer insertSublayer:gradientLayer atIndex:0];
    [self setKeyColor:[UIColor redColor]];
    
    sliderKnobView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"colorPickerKnob.png"]];
    sliderKnobView.center = CGPointMake(0, self.frame.size.height*0.5);
    [self addSubview:sliderKnobView];
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
}

- (void) setKeyColor:(UIColor *)c
{
    self.currentColor = c;
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue
                     forKey:kCATransactionDisableActions];
    gradientLayer.colors =  [NSArray arrayWithObjects:
                             (id)c.CGColor,
                             (id)[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.000].CGColor,
                             nil];  //这里设置颜色渐变
    [c getHue:&colorH saturation:&colorS brightness:&colorV alpha:nil];
    
    sliderKnobView.center = CGPointMake((1-colorV)*self.frame.size.width, self.frame.size.height/2.0f);
    
    [CATransaction commit];
}

- (void) mapPointToValue:(CGPoint)point
{
    if(point.x < 0 || point.x > self.frame.size.width){
        return;
    }
    colorV =  1 - (point.x / self.frame.size.width);
    sliderKnobView.center = CGPointMake(point.x, self.frame.size.height/2.0f);
    self.currentColor = [UIColor colorWithHue:colorH saturation:colorS brightness:colorV alpha:1.0f];
    if(self.deledate){
        [self.deledate brightnessSliderColor:self.currentColor];
    }
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self mapPointToValue:[touch locationInView:self]];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self mapPointToValue:[touch locationInView:self]];
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self continueTrackingWithTouch:touch withEvent:event];
}

@end
