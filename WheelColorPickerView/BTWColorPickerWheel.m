//
//  BTWColorPickerWheel.m
//  CustomColorWheel
//
//  Created by 肖建明 on 16/1/13.
//  Copyright © 2016年 XJM. All rights reserved.
//

#import "BTWColorPickerWheel.h"

@implementation BTWColorPickerWheel

@synthesize wheelImageView;
@synthesize wheelKnobView;
@synthesize currentColor;

-(void)setCurrentColor:(UIColor *)color
{
    NSLog(@"重写设置方法");
    CGFloat colorH,colorS;
    [color getHue:&colorH saturation:&colorS brightness:nil alpha:nil];
    double angleSAT = colorH * 2.0 * M_PI;  //弧度转角度
    double radius = self.wheelImageView.bounds.size.width * 0.5-5;  //-5是因为有一点边缘
    double colorRadius = radius*colorS;//s是百分比
    CGPoint center = CGPointMake(self.wheelImageView.bounds.size.width * 0.5,
                                 self.wheelImageView.bounds.size.height * 0.5);
    CGFloat x = center.x + cosf(angleSAT) * colorRadius;
    CGFloat y = center.y - sinf(angleSAT) * colorRadius;
    x = roundf(x - self.wheelKnobView.bounds.size.width * 0.5) + self.wheelKnobView.bounds.size.width * 0.5;//四舍五入
    y = roundf(y - self.wheelKnobView.bounds.size.height * 0.5) + self.wheelKnobView.bounds.size.height * 0.5;
    
    [UIView beginAnimations:nil context:nil];
    self.wheelKnobView.center = CGPointMake(x + self.wheelImageView.frame.origin.x, y + self.wheelImageView.frame.origin.y);   //根据HSV设置触摸点的显示位置
    [UIView commitAnimations];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initDate];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initDate];
    }
    return self;
}
-(void)initDate{
    //添加背景图ImageView
    wheelImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pickerColorWheel"]];
    [wheelKnobView setClipsToBounds:YES];
    wheelImageView.contentMode = UIViewContentModeScaleAspectFill;//设置拉伸填充
    wheelImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:wheelImageView];
    //添加触摸点ImageView
    wheelKnobView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"colorPickerKnob"]];
    self.wheelKnobView.center = self.wheelImageView.center;//初始化归中
    [self addSubview:wheelKnobView];
    self.userInteractionEnabled = YES;	//设置是否可以接收用户事件
}
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    //开始触摸事件
    CGPoint mousepoint = [touch locationInView:self];
    if (!CGRectContainsPoint(self.wheelImageView.frame, mousepoint)){
        return NO;
    }
    [self mapPointToColor:[touch locationInView:self.wheelImageView]];
    return YES;
}
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self mapPointToColor:[touch locationInView:self.wheelImageView]];//locationInView获取到视图的位置
    return YES;
}
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    //结束触摸事件
    [self continueTrackingWithTouch:touch withEvent:event];
}

- (void) mapPointToColor:(CGPoint) point
{
    CGPoint center = CGPointMake(self.wheelImageView.bounds.size.width * 0.5,
                                 self.wheelImageView.bounds.size.height * 0.5);
    double radius = self.wheelImageView.bounds.size.width * 0.5-5;  //-5是因为有一点边缘
    double dx = ABS(point.x - center.x);
    double dy = ABS(point.y - center.y);  //取绝对值
    double angle = atan(dy / dx);
    if (isnan(angle)){   //排除异常数据
        angle = 0.0;
    }
    double dist = sqrt(pow(dx, 2) + pow(dy, 2));
    double saturation = MIN(dist/radius, 1.0);
    if (point.x < center.x){
        angle = M_PI - angle;
    }
    if (point.y > center.y){
        angle = 2.0 * M_PI - angle;
    }
    float h = angle / (2.0 * M_PI);
    double angleSAT = h * 2.0 * M_PI;  //弧度转角度
    double colorRadius = radius*saturation;//s是百分比
    CGFloat x = center.x + cosf(angleSAT) * colorRadius;
    CGFloat y = center.y - sinf(angleSAT) * colorRadius;
    x = roundf(x - self.wheelKnobView.bounds.size.width * 0.5) + self.wheelKnobView.bounds.size.width * 0.5;//四舍五入
    y = roundf(y - self.wheelKnobView.bounds.size.height * 0.5) + self.wheelKnobView.bounds.size.height * 0.5;
    self.wheelKnobView.center = CGPointMake(x + self.wheelImageView.frame.origin.x, y + self.wheelImageView.frame.origin.y);   //根据HSV设置触摸点的显示位置
    
    currentColor =[UIColor colorWithHue:h saturation:saturation brightness:1.0 alpha:1.0];
    if(self.delege){
        [self.delege wheelColorChangle:self.currentColor];
    }
}

@end
