//
//  PSTabBar.m
//  UITabBar的不规则显示
//
//  Created by Ryan_Man on 16/6/22.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSTabBar.h"
@interface IrregularBtn:UIButton

@end

@implementation IrregularBtn
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
//    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
//
//    [bezierPath addArcWithCenter:CGPointMake(32, 26) radius:27 startAngle:M_PI endAngle:0 clockwise:YES];
//    [bezierPath setLineWidth:2.0];
//    
//    [[UIColor blackColor]setStroke];
//    
//    [bezierPath stroke];
}

@end


@interface PSTabBar ()
{
    NSMutableArray * _tabBarItems;
    
}
@property (nonatomic,weak)IrregularBtn * irregularBtn;
@end
@implementation PSTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.backgroundColor = [UIColor whiteColor];
        _tabBarItems = [@[] mutableCopy];
        
        [self setupIrregularButton];
        
    }
    return self;
}

- (void)setupIrregularButton
{
    // 添加中间不规则按钮
    IrregularBtn * irBtn = [IrregularBtn new];
    [irBtn setImage:[UIImage imageNamed:@"mai@2x_92"] forState:UIControlStateNormal];
    [irBtn addTarget:self action:@selector(clickEvent:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:irBtn];
    
    self.irregularBtn = irBtn;
}
- (void)clickEvent:(UIButton*)sender
{
    if (_block)_block();
}

#pragma mark -布局子控件-
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"---子控件 %@----",self.subviews);
    [self adjustNewSubViewFrame];
    [self removeLayerLine];
    [self getAllTabBarButtons];
    
}

- (void)adjustNewSubViewFrame
{
    // 调整新加入控件的frame
    self.irregularBtn.size = CGSizeMake(64, 64); // 大小自己调整
    self.irregularBtn.centerX = self.width * 0.5;
    self.irregularBtn.y = self.height - self.irregularBtn.height - 5; //高度具体调整
    setBoundsWithView(self.irregularBtn, self.irregularBtn.width / 2 );
    
}
- (void)removeLayerLine
{
    // 简单粗暴先干掉系统的边界线
    for (UIView * view in self.subviews)
    {
        if (IsKindOfClass(view, UIImageView))
        {
            [view removeFromSuperview];
            break; // 必须跳出循环，否则循环过程中删除 会导致数量错失
        }
    }
}
- (void)getAllTabBarButtons
{
    for (UIView *tabBarButton in self.subviews)
    {
        // 如果不是UITabBarButton， 直接跳过
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        [_tabBarItems  addObject:tabBarButton];
    }
    UIView * view = (UIView*)_tabBarItems [2];
    view.hidden = YES;
    
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //画线
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath setLineWidth:5];
    [[UIColor blackColor]setStroke];
    
    //前半段
    [bezierPath moveToPoint:CGPointMake(0, 0.3)];
    [bezierPath addLineToPoint:CGPointMake(self.width/2 - 32, 0.3)];
    
    //后半段
    [bezierPath moveToPoint:CGPointMake(self.width/2 - 32, 0.3)];
    [bezierPath addLineToPoint:CGPointMake(self.width, 0.3)];

    [bezierPath stroke];
}


@end
