//
//  StoryContentController.h
//  Marry1.0
//
//  Created by Ibokan on 14-10-8.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryTableViewCell.h"
@interface StoryContentController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIActivityIndicatorView *indicator;
    NSMutableArray *mediaPathArr;
    NSMutableArray *descriptionArr;
}
@property(retain,nonatomic)UITableView *storyTableView;
@end
