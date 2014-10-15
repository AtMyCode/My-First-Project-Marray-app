//
//  SetMyStoryViewController.h
//  Marry1.0
//
//  Created by Ibokan on 14-10-11.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"
#import "JGActionSheet.h"
#import "MainTarBarViewController.h"
#import "StoryData.h"
#import "AppDelegate.h"
@interface SetMyStoryViewController : UIViewController<CustomIOS7AlertViewDelegate,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,JGActionSheetDelegate>
{
    CustomIOS7AlertView *storyAlertView;
    UITextField *writeTitleTextField;
    UIImageView *alertImageView;//创建故事里的图片
    
    UITableView *storyArertTableView;
   UITableView *storyTableView;
    
    NSMutableArray *imageArr;
    NSMutableArray *titleArr;
    NSMutableArray *timeArr;
    
    int  fix;
    
}
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@end
