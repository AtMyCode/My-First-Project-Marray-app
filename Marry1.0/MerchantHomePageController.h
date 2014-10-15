//
//  MerchantHomePageController.h
//  Marry1.0
//
//  Created by apple on 14-10-3.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTarBarViewController.h"
@interface MerchantHomePageController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *logoImageView;
    UILabel *nameLabel;
    UILabel *propertsNameLabel;
    UILabel *fans_label;
    UISegmentedControl *segmentedControl;
    UIScrollView *sliderScrollView;
    
    NSArray *merchantDetailArr;
    NSArray *hintArr;
}

@end
