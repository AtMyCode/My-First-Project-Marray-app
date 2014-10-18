//
//  HSBuyDataProvider.h
//  Marry1.0
//
//  Created by apple on 14-10-15.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSBuyDataProvider : NSObject
{
    NSURLConnection *getConnection;  // get链接
    NSMutableData *getBuyData;  // getData
}
-(void)requstBuyData:(int)ID;
@end
