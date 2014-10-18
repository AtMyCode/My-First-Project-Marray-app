//
//  ClickImageDisplayDetailViewController.h
//  Marry1.0
//
//  Created by Ibokan on 14-9-29.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTarBarViewController.h"
#import "UIImageView+WebCache.h"
#import "GuangGuangDataProvider.h"
#import "BuyViewController.h"
#import "HSBuyDataProvider.h"
@class AppDelegate;
@interface ClickImageDisplayDetailViewController : UIViewController
{
    MainTarBarViewController *mainTarBarViewController;
    AppDelegate *appDelegate;
    NSString *urlBuyString;
}
@property(retain,nonatomic)GuangGuangDataProvider *guangguangDataProvider;
@property(assign,nonatomic)int detailIndex;
@property(strong,nonatomic)NSString *productsDetailStr;
@property(assign,nonatomic)float  productsPrice;
@property(strong,nonatomic)UIImageView *imageView;
@property(assign,nonatomic)int  productsId;

@end
