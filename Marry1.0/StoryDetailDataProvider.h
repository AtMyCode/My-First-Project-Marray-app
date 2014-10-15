//
//  StoryDetailDataProvider.h
//  Marry1.0
//
//  Created by Ibokan on 14-10-8.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryDetailDataProvider : NSObject
{
    
    NSURLConnection *getConnection;  // get链接
    NSMutableData *getData;  // getData
    NSMutableArray *mediaPathArr;
    NSMutableArray *descriptionArr;
}
-(void)requestDetailData:(int)storyId;
@end
