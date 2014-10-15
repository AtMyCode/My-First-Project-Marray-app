//
//  HDZuoPingDataProvide.h
//  Marry1.0
//
//  Created by apple on 14-10-2.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDZuoPingDataProvide : NSObject<NSURLConnectionDataDelegate>
{
    
    NSURLConnection *getConnection;  // get链接
    NSMutableData *getThemeData;  // getData
    
   
    NSMutableArray *zuoPingTitleArr;

    NSMutableArray *zuoPingItemsImagePathArr;
    NSMutableArray *zuoPingIDArr;
    NSMutableArray *zuoPingMIDArr;
    
    
}
-(void)requestZuoPingData;
@end
