//
//  InvitationCardDataProvider.m
//  Marry1.0
//
//  Created by apple on 14-10-6.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "InvitationCardDataProvider.h"

@implementation InvitationCardDataProvider
-(void)requesInvitationCardtData
{
    getData = [NSMutableData data];
    NSURL *url = [NSURL URLWithString:@"http://marrymemo.com/themes.json"];
    
    
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
    
    NSArray *contentArr = [getData objectFromJSONData];
    ;
    NSMutableArray *invitationCardURLArr = [[NSMutableArray alloc] init];
    //NSLog(@"contentArr = %@",contentArr);
    for (NSDictionary *dict in contentArr)
    {
        [invitationCardURLArr addObject:[dict objectForKey:@"thumb_path"]];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"invitationCardURLArr" object:self userInfo:@{@"invitationCardURLArr": invitationCardURLArr}];
    //NSLog(@"%@",qingTie);
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"请求失败，error = %@",error);
}

@end
