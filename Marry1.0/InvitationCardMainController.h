//
//  InvitationCardMainController.h
//  Marry1.0
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvitationCardDataProvider.h"
@interface InvitationCardMainController : UIViewController<UIScrollViewDelegate>
{
    NSArray *invitationUrlArr;
    int totlalPage;
    int currentPage;
    
    float startContentOffsetX;
    float willEndContentOffsetX;
    float endContentOffsetX;
    UILabel *numLabel;
}
@property(nonatomic,retain)UIScrollView *imageScrollView;

@end
