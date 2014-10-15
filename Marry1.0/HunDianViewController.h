//
//  HunDianViewController.h
//  Marry1.0
//
//  Created by apple on 14-10-1.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HunDianZuoPingPageCostomCell.h"
#import "HDZuoPingDataProvide.h"
#import "MJRefresh.h"
#import "ZuoPingDetailViewController.h"
#import "MainTarBarViewController.h"
#import "HDZuoPingDetailDataProvider.h"
#import "HDMerchantsDataProvider.h"
#import "HunDianMerchantsPageCostomCell.h"
#import "MainTarBarViewController.h"
#import "MerchantHomeSubPageController.h"
@interface HunDianViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    //作品页面的
     NSMutableArray *zuoPingItemsImagePathArr;
    NSMutableArray *zuoPingTitleArr;
    NSMutableArray *zuoPingIDArr;
    NSMutableArray *zuoPingMIDArr;
    UIActivityIndicatorView *indicator;
    UISegmentedControl *segementTitleView;
    
    
    //商家页面的
    NSMutableArray *merchantsLogo_pathArr;
    NSMutableArray *merchantsNameArr;
    NSMutableArray *merchantsFans_countArr;
    NSMutableArray *merchantsOpu_count;//作品数目
    NSMutableArray *merchantsPropertiesNameArr;
    NSMutableArray *merchantsMID;
    
    
    UIActivityIndicatorView *merchantsPageIndicator;
}
@property(retain,nonatomic)UIScrollView* sliderScrollView;
@property(retain,nonatomic)UITableView *zuoPingTableView;
@property(retain,nonatomic)HDZuoPingDataProvide *zuoPingDataProvider;
@property(retain,nonatomic)UITableView *merchantsTableView;
@property(retain,nonatomic)HDMerchantsDataProvider *merchantsDataProvider;//商家数据提供者
@end
