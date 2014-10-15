//
//  HDZuoPingDetailDataProvider.m
//  Marry1.0
//
//  Created by apple on 14-10-2.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "HDZuoPingDetailDataProvider.h"

@implementation HDZuoPingDetailDataProvider
-(void)requestDetailData:(NSDictionary*)idWithPageNumDict
{
    getThemeData = [NSMutableData data];
    
    
    
    imagesPathArr = [[NSMutableArray alloc] init];
    
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://marrymemo.com/opus/%d.json?page=%d&",[[idWithPageNumDict objectForKey:@"id"] intValue],[[idWithPageNumDict objectForKey:@"pageNum"]intValue]]];
    
    
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
    
    NSArray *contentArr =  [contentDict objectForKey:@"items"];
    for (NSDictionary *itemDict in contentArr)
    {
        [imagesPathArr addObject:[itemDict objectForKey:@"path"]];
    }
    //NSLog(@"%@",imagesPathArr);
    //商家信息
    NSDictionary *merchantDict = [contentDict objectForKey:@"merchant"];
    //logo路径
    NSString *logoPathStringURL = [merchantDict objectForKey:@"logo_path"];
    //作品数目
    NSString * opu_countStr = [merchantDict objectForKey:@"opu_count"];
    //NSLog(@"logopath = %@,opu_countStr = %@",logoPathStringURL,opu_countStr);
    NSString *merchantName = [merchantDict objectForKey:@"name"];
    //NSLog(@"%@",merchantName);
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZuoPingDetailDataImage" object:self userInfo:@{@"imagesPathArr": imagesPathArr,@"logo_path":logoPathStringURL,@"opu_count":opu_countStr,@"name":merchantName}];
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"请求失败，error = %@",error);
}
@end
