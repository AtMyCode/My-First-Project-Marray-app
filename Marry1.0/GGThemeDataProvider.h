//
//  GGDetailDataProvider.h
//  Marry1.0
//
//  Created by Ibokan on 14-9-29.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGThemeDataProvider : NSObject<NSURLConnectionDataDelegate>
{
    
        NSURLConnection *getConnection;  // get链接
        NSMutableData *getThemeData;  // getData
    
    NSMutableArray *themeImageUrlArr; //主题图片url数组
    NSMutableArray *themeTitleArr;//主题标题
    NSMutableArray *themeIDArr;//id
}

-(void)requestImageThemeData;
//+(GGDetailDataProvider*)sharedGGDetailDataProvider;
//@property(retain,nonatomic)NSMutableArray *detailInfoCache;
@property(assign,nonatomic)int pageNum;

@end
