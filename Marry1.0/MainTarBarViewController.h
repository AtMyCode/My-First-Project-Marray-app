//
//  MainTarBarViewController.h
//  Marry1.0
//
//  Created by apple on 14-9-28.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTarBarViewController : UITabBarController
{
    
    NSMutableArray *selectedImageArr;//被选择后的背景
    NSMutableArray *imageArr;//存放按钮的背景图片
    NSMutableArray *btnArray;//按钮数组
    NSArray *textLabelArr;//存储标签的名字
    NSMutableArray *labelArr; //label数组
}
@property(retain,nonatomic)UIView *coustomTarBar;
+(MainTarBarViewController*)sharedTarBarController;
@end
