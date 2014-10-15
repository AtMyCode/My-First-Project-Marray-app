//
//  HDMerchantsHomeDetailInfoProvider.h
//  Marry1.0
//
//  Created by apple on 14-10-4.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDMerchantsHomeDetailInfoProvider : NSObject<NSURLConnectionDataDelegate>
{
    NSURLConnection *getConnection;  // get链接
    NSMutableData *getThemeData;  // getData
    
 
    
}
-(void)requestMerchantsHomeDetailData:(NSString*)mid;
@end
