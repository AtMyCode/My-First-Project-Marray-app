//
//  HDMerchantsDataProvider.h
//  Marry1.0
//
//  Created by apple on 14-10-3.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDMerchantsDataProvider : NSObject
{
    NSURLConnection *getConnection;  // get链接
    NSMutableData *getThemeData;  // getData
    
    NSMutableArray *merchantsLogo_pathArr;
    NSMutableArray *merchantsNameArr;
    NSMutableArray *merchantsFans_countArr;
    NSMutableArray *merchantsOpu_count;//作品数目
    NSMutableArray *merchantsPropertiesNameArr;
    NSMutableArray *merchantsMID;//
    
    
}
@property(assign,nonatomic)int pageNum;
-(void)requestMerchantsData;
@end
