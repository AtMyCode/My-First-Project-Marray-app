//
//  GGThemeContentImageProvider.h
//  Marry1.0
//
//  Created by apple on 14-10-1.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGThemeContentImageProvider : NSObject<NSURLConnectionDataDelegate>
{
    NSURLConnection *getConnection;  // get链接
    NSMutableData *getThemeData;  // getData
    
    NSMutableArray *themeContentImagesURLArr;
    NSMutableArray *themeContentLikeCountArr;
    NSMutableArray *themeContentPriceArr;
    NSMutableArray *themeSubject_descArr;//商品描述
    
    NSMutableArray *themeContentID;
}
-(void)requestImageThemeData:(int)ID;
@end
