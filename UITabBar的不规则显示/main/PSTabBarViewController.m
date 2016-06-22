//
//  PSTabBarViewController.m
//  UITabBar的不规则显示
//
//  Created by Ryan_Man on 16/6/22.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSTabBarViewController.h"
#import "PSNavigationVC.h"
#import "PSFirstViewController.h"
#import "PSSecondViewController.h"
#import "PSThirdViewController.h"
#import "PSFourViewController.h"
#import "PSFiveViewController.h"
#import "PSTabBar.h"
@interface PSTabBarViewController ()
@property (nonatomic,weak)PSFirstViewController * vc1;
@property (nonatomic,weak)PSSecondViewController * vc2;
@property (nonatomic,weak)PSThirdViewController * vc3;
@property (nonatomic,weak)PSFourViewController * vc4;
@property (nonatomic,weak)PSFiveViewController * vc5;
@end

@implementation PSTabBarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addAllChildVCs];
    
    [self addCustomTabBar];
    
}

- (void)addCustomTabBar
{
    // 创建自定义tabbar
    __weak typeof(self) ws = self;
    PSTabBar *customTabBar = [[PSTabBar alloc] init];
    customTabBar.block = ^()
    {
        ws.selectedIndex = 2;
    };
    [self setValue:customTabBar forKeyPath:@"tabBar"];
    
}

- (void)addAllChildVCs
{
    
    PSFirstViewController * vc1 = [[PSFirstViewController alloc] init];
    self.vc1 = vc1;
    //    [self addChildVC:self.vc1 withTitle:@"第一" image:nil selectImage:nil];
    [self addChildVC:self.vc1 withTitle:@"第一" withSystemItem:(UITabBarSystemItemContacts) tag:0];
    
    PSSecondViewController * vc2 = [[PSSecondViewController alloc] init];
    self.vc2 = vc2;
    //    [self addChildVC:self.vc2 withTitle:@"第二" image:nil selectImage:nil];
    [self addChildVC:self.vc2 withTitle:@"第二" withSystemItem:(UITabBarSystemItemBookmarks) tag:1];
    
    
    PSThirdViewController * vc3 = [[PSThirdViewController alloc] init];
    self.vc3 = vc3;
    //    [self addChildVC:self.vc3 withTitle:@"第三" image:nil selectImage:nil ];
    [self addChildVC:self.vc3 withTitle:@"第三" withSystemItem:(UITabBarSystemItemDownloads) tag:2];
    
    
    PSFourViewController * vc4 =  [[PSFourViewController alloc] init];
    self.vc4 = vc4;
    //    [self addChildVC:self.vc4 withTitle:@"第四" image:nil selectImage:nil];
    [self addChildVC:self.vc4 withTitle:@"第四" withSystemItem:(UITabBarSystemItemFavorites) tag:3];
    
    PSFiveViewController * vc5 = [[PSFiveViewController alloc] init];
    self.vc5 = vc5;
    //    [self addChildVC:self.vc5 withTitle:@"第五" image:nil selectImage:nil ];
    [self addChildVC:self.vc5 withTitle:@"第五" withSystemItem:(UITabBarSystemItemHistory) tag:4];
    
}

#pragma mark -添加一个子控制器-
-(void)addChildVC:(UIViewController*)chiledrenVC withTitle:(NSString*)title image:(NSString*)image selectImage :(NSString*)selectImage
{
    
    chiledrenVC.title = title;
    UIImage * img = [UIImage imageNamed:image ];
    UIImage * selectImg = [UIImage imageNamed:selectImage];
    
    if(IsiOS7Later)
    {
        img  =[img imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        selectImg = [selectImg imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        
    }
    chiledrenVC.tabBarItem.image = img;
    chiledrenVC.tabBarItem.selectedImage = selectImg;
    PSNavigationVC * navi = [[PSNavigationVC alloc] initWithRootViewController:chiledrenVC];
    [self addChildViewController:navi];
}
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    // 设置子控制器的文字和图片
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字样式
    NSMutableDictionary *textAttrs = [[NSMutableDictionary alloc] init];
    textAttrs[NSForegroundColorAttributeName] = RGB(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [[NSMutableDictionary alloc] init];
    selectTextAttrs[NSForegroundColorAttributeName] = RGB(245, 219, 178);
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    PSNavigationVC *nav = [[PSNavigationVC alloc] initWithRootViewController:childVc];
    
    // 添加到TabBarController控制器中
    [self addChildViewController:nav];
    
}

- (void)addChildVC:(UIViewController*)chiledrenVC withTitle:(NSString*)title withSystemItem:(UITabBarSystemItem)item tag:(NSInteger)tag
{
    chiledrenVC.title = title;
    chiledrenVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:item tag:tag];
    PSNavigationVC * navi = [[PSNavigationVC alloc] initWithRootViewController:chiledrenVC];
    
    NSLog(@"%ld",(long)chiledrenVC.tabBarItem.tag);
    
    
    [self addChildViewController:navi];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{   // 这里不需要调用super，因为父类没有实现这个代理方法
    // 调用了会报错，同时说明UITabBarController没有通过这个方法监听tabbar点击
//    [super tabBar:tabBar didSelectItem:item];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
