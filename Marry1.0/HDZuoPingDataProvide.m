//
//  HDZuoPingDataProvide.m
//  Marry1.0
//
//  Created by apple on 14-10-2.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "HDZuoPingDataProvide.h"

@implementation HDZuoPingDataProvide
static int pageNum = 0;
-(id)init
{
    if (self = [super init])
    {
        
        zuoPingTitleArr = [[NSMutableArray alloc] init];
        zuoPingItemsImagePathArr = [[NSMutableArray alloc] init];
        zuoPingIDArr = [[NSMutableArray alloc] init];
        zuoPingMIDArr = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)requestZuoPingData
{
    getThemeData = [NSMutableData data];

    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://marrymemo.com/opus.json?page=%d&",++pageNum]];
    
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
    getConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self ];

}
// 接收到请求响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"接收到请求响应");
    
    
    
}
// 连接建立，开始接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSLog(@"连接建立，开始接收数据");
    [getThemeData appendData:data];
}
// 数据下（加）载完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog(@"数据下（加）载完成");
    
    NSDictionary *contentDict = [getThemeData objectFromJSONData];
    ;
    
    NSArray *arr = [contentDict objectForKey:@"opus"];
    //NSLog(@"%@",arr);
    
    for (NSDictionary *dict in arr)
    {
        [zuoPingTitleArr addObject:[dict objectForKey:@"title"]];
        [zuoPingMIDArr addObject:[dict objectForKey:@"mid"]];
        
        NSDictionary *idWithPageNumDict = @{@"id": [dict objectForKey:@"id"],@"pageNum":[NSNumber numberWithInt:pageNum]};
        [zuoPingIDArr addObject:idWithPageNumDict];
        
        NSMutableArray *item = [[NSMutableArray alloc] init];
        
        for (NSDictionary *itemDict in [dict objectForKey:@"items"])
        {
            [item addObject:[itemDict objectForKey:@"path"]];
        }
        
        [zuoPingItemsImagePathArr addObject:item];
    }
    //NSLog(@"MID = %@",zuoPingMIDArr);
         //NSLog(@"%@,%@,%@,%@",[zuoPingTitleArr objectAtIndex:0],[zuoPingNameArr objectAtIndex:0],[zuoPingLogoUrlArr objectAtIndex:0],zuoPingItemsImagePathArr );
    //NSLog(@"%@",zuoPingIDArr);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HDZuoPingItemsData" object:self userInfo:@{@"items": zuoPingItemsImagePathArr,@"title":zuoPingTitleArr,@"idArr":zuoPingIDArr,@"midArr":zuoPingMIDArr}];
    
    
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"请求失败，error = %@",error);
}

@end
