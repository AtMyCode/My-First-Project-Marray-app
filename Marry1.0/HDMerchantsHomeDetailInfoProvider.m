//
//  HDMerchantsHomeDetailInfoProvider.m
//  Marry1.0
//
//  Created by apple on 14-10-4.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "HDMerchantsHomeDetailInfoProvider.h"

@implementation HDMerchantsHomeDetailInfoProvider
-(void)requestMerchantsHomeDetailData:(NSString*)mid
{
    getThemeData = [NSMutableData data];
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://marrymemo.com/merchants/%@.json",mid]];
    
    
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
    //NSLog(@"%@",contentDict);
   
//    NSString *merchantHomeCompany_name = [contentDict objectForKey:@"company_name"];
//    NSString *merchantHomeEmail = [contentDict objectForKey:@"email"];
    NSString *merchantHomeFans_count = [contentDict objectForKey:@"fans_count"];
    NSString *merchantHomeLogo_path = [contentDict objectForKey:@"logo_path"];
    NSString *merchantHomeName = [contentDict objectForKey:@"name"];
    NSString *merchantHomePropertiesName = [[[contentDict objectForKey:@"properties"] objectAtIndex:0] objectForKey:@"name"];
    NSString *merchantHomePhone = [contentDict objectForKey:@"phone"];
   // NSString *merchantHomeOpu_count = [contentDict objectForKey:@"opu_count"];
    
    NSString *merchantHomeDetail = [contentDict objectForKey:@"detail"];
    NSDictionary *merchantDetailDict = [merchantHomeDetail objectFromJSONString];
    
    //城市
    NSString *city = [merchantDetailDict objectForKey:@"城市"];
    NSString *address = [merchantDetailDict objectForKey:@"地址"];
    NSString *qq = [merchantDetailDict objectForKey:@"QQ"];
    NSString *wechat = [merchantDetailDict objectForKey:@"微信"];
    NSString *weibo = [merchantDetailDict objectForKey:@"微博"];
    NSString *introduction = [merchantDetailDict objectForKey:@"简介"];
    NSString *scope = [merchantDetailDict objectForKey:@"经营范围"];
    
    NSArray *merchantDetailArr = [NSArray arrayWithObjects:address,introduction,weibo,wechat,qq,city,scope,merchantHomePhone, nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MerchantHomeDetailNotifi" object:self userInfo:@{@"logo_path": merchantHomeLogo_path,@"name":merchantHomeName,@"properties":merchantHomePropertiesName,@"fans_count":merchantHomeFans_count,@"merchantDetailArr":merchantDetailArr}];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"请求失败，error = %@",error);
}

@end
