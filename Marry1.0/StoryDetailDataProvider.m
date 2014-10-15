//
//  StoryDetailDataProvider.m
//  Marry1.0
//
//  Created by Ibokan on 14-10-8.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "StoryDetailDataProvider.h"

@implementation StoryDetailDataProvider
-(void)requestDetailData:(int)storyId
{
    
    getData = [NSMutableData data];
    descriptionArr = [[NSMutableArray alloc] init];
    mediaPathArr = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://marrymemo.com/stories/%d.json",storyId]];
    
    
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
    [getData appendData:data];
}
// 数据下（加）载完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog(@"数据下（加）载完成");
    
    NSDictionary *contentDict = [getData objectFromJSONData];
    NSArray *contentArr = [contentDict objectForKey:@"items"];
    for (NSDictionary *dict in contentArr)
    {
        if ([dict objectForKey:@"media_path"]==nil)
        {
            [mediaPathArr addObject:[NSNull null]];
        }else
        {
            [mediaPathArr addObject:[dict objectForKey:@"media_path"]];
        }
        if ([dict objectForKey:@"description"]==nil)
        {
            [descriptionArr addObject:[NSNull null]];
        }
        [descriptionArr addObject:[dict objectForKey:@"description"]];
        
    }
    //NSLog(@"%@",contentDict);
    //NSLog(@"%@,%@",mediaPathArr,[descriptionArr objectAtIndex:0]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"detailDataNotifi" object:self userInfo:@{@"media_path": mediaPathArr,@"description":descriptionArr}];
   
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"请求失败，error = %@",error);
}

@end
