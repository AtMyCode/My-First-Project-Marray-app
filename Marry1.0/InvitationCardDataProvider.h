//
//  InvitationCardDataProvider.h
//  Marry1.0
//
//  Created by apple on 14-10-6.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvitationCardDataProvider : NSObject<NSURLConnectionDataDelegate>
{
    
    NSURLConnection *getConnection;  // get链接
    NSMutableData *getData;  // getData
}
-(void)requesInvitationCardtData;
@end
