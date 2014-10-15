//
//  StoryViewController.h
//  Marry1.0
//
//  Created by apple on 14-10-6.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryDataProvider.h"
#import "StoryContentController.h"
#import "StoryDetailDataProvider.h"
@interface StoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *imageURL;
    NSMutableArray *titleArr;
    NSMutableArray *avatarArr;
    NSMutableArray *praise_countArr;
    UIActivityIndicatorView *indicator;
    NSMutableArray *storyId;
    
}
@property(retain,nonatomic)UITableView *storyTableView;
@property(retain,nonatomic)StoryDataProvider *dataProvider;
@end
