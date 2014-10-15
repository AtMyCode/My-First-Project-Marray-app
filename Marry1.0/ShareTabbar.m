//
//  ShareTabbar.m
//  Marry1.0
//
//  Created by apple on 14-10-9.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "ShareTabbar.h"

@implementation ShareTabbar
+(SSCCommentToolbar*)toolbar
{
    SSCCommentToolbar *toolbar = [Comment commentToolbarWithContentId:@"22" title:@"标题" frame:CGRectMake(0.0, KScreenHeight-44,KScreenWidth, 44)];
    return toolbar;
}
@end
