//
//  MySetViewController.h
//  Marry1.0
//
//  Created by Ibokan on 14-10-8.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SetMyStoryViewController.h"
#import "MainTarBarViewController.h"
#import "WeddingProcessController.h"
#import "UMFeedback.h"
@interface MySetViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,WBHttpRequestDelegate>
{
    NSArray *iconArr;
    NSArray *textArr;
    UIImageView *portraitImageView;
    NSString *userName;
    NSString *avatarImageURL;
    UILabel *userNameLabel2;
    
    UITableView *setTableView;
}
@end
