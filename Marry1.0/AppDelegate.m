//
//  AppDelegate.m
//  Marry1.0
//
//  Created by apple on 14-9-28.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTarBarViewController.h"
#import "SendMessageToWeiboViewController.h"
#import "ProvideMessageForWeiboViewController.h"
#import "WeiboApi.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
@implementation AppDelegate
@synthesize viewDelegate;
@synthesize wbtoken;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize invitationCardMainController;
@synthesize invitationCardMenuController;

- (id)init
{
    if(self = [super init])
    {
       
        self.viewDelegate = [[AGViewDelegate alloc] init];
    }
    return self;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    
    [ShareSDK registerApp:@"api20"];
    
    
    //添加新浪微博应用
    [ShareSDK connectSinaWeiboWithAppKey:@"1189674826"
                               appSecret:@"620657bf8369a78b840afca902820bd3"
                             redirectUri:@"http://www.sharesdk.cn"];
    
    //添加腾讯微博应用
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                redirectUri:@"http://www.sharesdk.cn"
                                   wbApiCls:[WeiboApi class]];
    
   
    
    
    self.viewController = [[SendMessageToWeiboViewController alloc] init] ;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
   
    
    //婚饰
    HunShiViewController *hunShi = [[HunShiViewController alloc] init];
    AppNavigationController *hunShiNav = [[AppNavigationController alloc] initWithRootViewController:hunShi];
    
    //婚典
    HunDianViewController *hunDian = [[HunDianViewController alloc] init];
    AppNavigationController *hunDianNav = [[AppNavigationController alloc] initWithRootViewController:hunDian];
    
    //请帖
    self.invitationCardMenuController = [[InvitationCardMenuController alloc] init];
    self.invitationCardMainController = [[InvitationCardMainController alloc] init];
    self.sideMenuViewController = [[TWTSideMenuViewController alloc] initWithMenuViewController:self.invitationCardMenuController mainViewController:[[AppNavigationController alloc] initWithRootViewController:self.invitationCardMainController]];
    self.sideMenuViewController.shadowColor = [UIColor blackColor];
    self.sideMenuViewController.edgeOffset = (UIOffset) { .horizontal = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 18.0f : 0.0f };
    self.sideMenuViewController.zoomScale = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 0.7634f : 0.85f;
    self.sideMenuViewController.delegate = self;
    
    
    
    //故事
    AppNavigationController *stroyNav = [[AppNavigationController alloc] initWithRootViewController:[[StoryViewController alloc] init]];
    
    //设置
    AppNavigationController *mySetNav = [[AppNavigationController alloc] initWithRootViewController:[[MySetViewController alloc] init]];
    //main控制器
    MainTarBarViewController *main = [MainTarBarViewController sharedTarBarController];
    main.viewControllers = @[hunShiNav,hunDianNav,self.sideMenuViewController,stroyNav,mySetNav];
    self.window.rootViewController = main;
    
   //[self updateApp] ;
   
    
    [UMFeedback setLogEnabled:YES];
    [UMFeedback checkWithAppkey:@"543aa155fd98c59dcb0167aa"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(umCheck:) name:UMFBCheckFinishedNotification object:nil];
    
   
    return YES;
}
- (void)umCheck:(NSNotification *)notification {
    UIAlertView *alertView;
    if (notification.userInfo) {
        NSArray *newReplies = [notification.userInfo objectForKey:@"newReplies"];
        NSLog(@"newReplies = %@", newReplies);
        //NSString *title = [NSString stringWithFormat:@"有%d条新回复", [newReplies count]];
        NSMutableString *content = [NSMutableString string];
        for (NSUInteger i = 0; i < [newReplies count]; i++) {
            //NSString *dateTime = [[newReplies objectAtIndex:i] objectForKey:@"datetime"];
            NSString *_content = [[newReplies objectAtIndex:i] objectForKey:@"content"];
            //[content appendString:[NSString stringWithFormat:@"%d .......%@.......\r\n", i + 1, dateTime]];
            [content appendString:_content];
            [content appendString:@"\r\n\r\n"];
        }
        
        alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即更新", nil];
        
        if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0f) {
            ((UILabel *) [[alertView subviews] objectAtIndex:1]).textAlignment = NSTextAlignmentLeft;
        }
        
        
        
        
    }
    //else {
//        alertView = [[UIAlertView alloc] initWithTitle:@"没有新回复" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//    }
    [alertView show];
}
#pragma mark 检查更新
-(void)updateApp
{
   
    dispatch_async(dispatch_get_main_queue(), ^{
        //get请求
        //创建URL
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=917596366"]];
        //通过url创建网络请求
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
        //连接数据库
        NSURLResponse *respone =nil;
        NSError *error = nil;
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&respone error:&error];
        
        //json解析
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dictt =  [[dict objectForKey:@"results"] lastObject];
        NSLog(@"%@",[dictt objectForKey:@"version"]);
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"检测到%@版本，是否更新?",[dictt objectForKey:@"version"]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
     
        
    });
   
}
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex ==1)
    {
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
        
            NSLog(@"查看feedback");
            //[self.viewController webFeedback:nil];
       
    }
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {
        ProvideMessageForWeiboViewController *controller = [[ProvideMessageForWeiboViewController alloc] init];
        [self.viewController presentViewController:controller animated:YES completion:nil];
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = @"发送结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode, response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
//        NSString *title = @"认证结果";
//        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        
//        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
//        
//        [alert show];
      
        
        
        NSDictionary*params=[NSDictionary dictionaryWithObjectsAndKeys:[(WBAuthorizeResponse *)response userID],@"uid",nil];
        [WBHttpRequest requestWithAccessToken:[(WBAuthorizeResponse *)response accessToken] url:@"https://api.weibo.com/2/users/show.json" httpMethod:@"GET" params:params delegate:self withTag:@"991"];
    }
}
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSDictionary*dict = [result objectFromJSONString];
    
   //NSLog(@"%@",result);
    @try {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"weiboNotifi" object:self userInfo:@{@"avatar_hd": [dict objectForKey:@"avatar_hd"],@"name":[dict objectForKey:@"name"]}];

    }
    @catch (NSException *exception) {
        NSString *title = nil;
        UIAlertView *alert = nil;
        
        title = @"提示";
        alert = [[UIAlertView alloc] initWithTitle:title
                                           message:@"取消登录"
                                          delegate:nil
                                 cancelButtonTitle:@"确定"
                                 otherButtonTitles:nil];
        [alert show];

    }
    @finally {
        
    }
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = @"请求异常";
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",error]
                                      delegate:nil
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil];
    [alert show];
    
}
#pragma mark - TWTSideMenuViewControllerDelegate

- (UIStatusBarStyle)sideMenuViewController:(TWTSideMenuViewController *)sideMenuViewController statusBarStyleForViewController:(UIViewController *)viewController
{
    if (viewController == self.invitationCardMenuController) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

- (void)sideMenuViewControllerWillOpenMenu:(TWTSideMenuViewController *)sender {
    NSLog(@"willOpenMenu");
}

- (void)sideMenuViewControllerDidOpenMenu:(TWTSideMenuViewController *)sender {
    NSLog(@"didOpenMenu");
}

- (void)sideMenuViewControllerWillCloseMenu:(TWTSideMenuViewController *)sender {
    NSLog(@"willCloseMenu");
}

- (void)sideMenuViewControllerDidCloseMenu:(TWTSideMenuViewController *)sender {
	NSLog(@"didCloseMenu");
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Marry1_0" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Marry1_0.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
