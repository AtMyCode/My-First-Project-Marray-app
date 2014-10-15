//
//  ThemeImageDetailVCViewController.h
//  Marry1.0
//
//  Created by apple on 14-10-1.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "ClickImageDisplayDetailViewController.h"

@interface ThemeImageDetailVCViewController : ClickImageDisplayDetailViewController
{
    int imageArrIndex;
}
-(void)dispalyImageAndDetailLabel:(int)index;
@property(strong,nonatomic)NSMutableArray *imageArr;
@end
