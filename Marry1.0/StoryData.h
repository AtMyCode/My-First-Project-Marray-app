//
//  StoryData.h
//  Marry1.0
//
//  Created by apple on 14-10-13.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface StoryData : NSManagedObject

@property (nonatomic, retain) NSString * storyTitle;
@property (nonatomic, retain) NSData * storyImage;
@property (nonatomic, retain) NSString * storyDate;

@end
