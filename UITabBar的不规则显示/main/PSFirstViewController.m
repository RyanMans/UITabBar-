//
//  PSFirstViewController.m
//  UITabBar的不规则显示
//
//  Created by Ryan_Man on 16/6/22.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSFirstViewController.h"
@interface draw:UIView

@end
@implementation draw

- (void)drawRect:(CGRect)rect
{
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(100, 100)];
//    [path setLineWidth:5.0];
//    [[UIColor blueColor] setStroke];
//    [path addLineToPoint:CGPointMake(200, 100)];
//    [path stroke];
    
    
    [bezierPath addArcWithCenter:self.center radius:100 startAngle:M_PI endAngle:0 clockwise:YES];
    [bezierPath setLineWidth:2.0];
    
    [[UIColor blackColor]setStroke];
    
    [bezierPath stroke];
}
@end


@interface PSFirstViewController ()
{
    draw * _dv;
}
@end

@implementation PSFirstViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dv = [[draw alloc]init];
    _dv.backgroundColor = [UIColor whiteColor];
    _dv.frame = self.view.bounds;
    [self.view addSubview:_dv];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
