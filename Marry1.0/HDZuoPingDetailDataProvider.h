//
//  HDZuoPingDetailDataProvider.h
//  Marry1.0
//
//  Created by apple on 14-10-2.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDZuoPingDetailDataProvider : NSObject<NSURLConnectionDataDelegate>
{
    NSURLConnection *getConnection;  // get链接
    NSMutableData *getThemeData;  // getData
    
    
    
    NSMutableArray *imagesPathArr;
    
}
-(void)requestDetailData:(NSDictionary*)idWithPageNumDict;

@end
