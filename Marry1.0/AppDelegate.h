//
//  AppDelegate.h
//  Marry1.0
//
//  Created by apple on 14-9-28.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HunShiViewController.h"
#import "AppNavigationController.h"
#import "HunDianViewController.h"
#import "TWTSideMenuViewController.h"
#import "InvitationCardMainController.h"
#import "InvitationCardMenuController.h"
#import "StoryViewController.h"
#import "MySetViewController.h"
#import "LauchesViewController.h"
#import "AGViewDelegate.h"
#import "UMFeedback.h"
@class SendMessageToWeiboViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,TWTSideMenuViewControllerDelegate,WeiboSDKDelegate,WBHttpRequestDelegate,UIAlertViewDelegate>
{
    
        NSString* wbtoken;
    
}
@property (nonatomic,retain) AGViewDelegate *viewDelegate;
@property (strong, nonatomic) SendMessageToWeiboViewController *viewController;
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (nonatomic, strong) TWTSideMenuViewController *sideMenuViewController;
@property (nonatomic, strong) InvitationCardMenuController *invitationCardMenuController;
@property (nonatomic, strong) InvitationCardMainController *invitationCardMainController;
@property (strong, nonatomic) NSString *wbtoken;
-(void)updateApp;
@end
