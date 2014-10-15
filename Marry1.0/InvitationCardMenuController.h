//
//  InvitationCardMenuController.h
//  Marry1.0
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWTSideMenuViewController.h"
#import "InvitationCardMainController.h"
#import "MyStoryViewController.h"
#import "AppNavigationController.h"

@interface InvitationCardMenuController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *weddingArr;
    NSArray *weddingImagePathArr;
    UINavigationController *invitationCardMainNav;
}

@end
