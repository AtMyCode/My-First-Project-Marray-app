//
//  StoryDataProvider.h
//  Marry1.0
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryDataProvider : NSObject
{
    
    NSURLConnection *getConnection;  // get链接
    NSMutableData *getData;  // getData
    NSMutableArray *imagePath;
    NSMutableArray *titleArr;
    NSMutableArray *avatarArr;
    NSMutableArray *praise_countArr;
    NSMutableArray *storyId;
}
-(void)requestStoryData;
@end
