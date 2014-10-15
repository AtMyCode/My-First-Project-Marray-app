//
//  MyStoryViewController.h
//  Marry1.0
//
//  Created by apple on 14-10-10.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWTSideMenuViewController.h"

@interface MyStoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *imageArr;
    NSMutableArray *titleArr;
    NSMutableArray *timeArr;
   
}
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property(nonatomic,strong) UITableView *storyTableView;
@end
