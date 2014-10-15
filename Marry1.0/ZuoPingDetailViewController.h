//
//  ZuoPingDetailViewController.h
//  Marry1.0
//
//  Created by apple on 14-10-2.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTarBarViewController.h"
#import "ZuoPingDetailCoustomCell.h"
#import "MerchantHomePageController.h"

#import "AGPhotoBrowserView.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "HDMerchantsHomeDetailInfoProvider.h"
@interface ZuoPingDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,AGPhotoBrowserDelegate, AGPhotoBrowserDataSource>
{
    MainTarBarViewController *mainVC;
    NSMutableArray *imagesPathArr;
    //logo路径
    NSString *logoPathStringURL;
    //作品数目
    NSString * opu_countStr;
    
    UIActivityIndicatorView *indicatorView;
    
    //商家logo图片
    UIImageView *logoImageView;
    
    //进入箭头
    UIImageView *nextArrowImageView;
    
    //商家的名称
    UILabel *titleNameLabel;
    
    //作品数目
    UILabel *opusLabel;
}
@property(nonatomic,strong)AGPhotoBrowserView *browserView;
@property(nonatomic,copy)NSString* zuoPingMID;
@end
