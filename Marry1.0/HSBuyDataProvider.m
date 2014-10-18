//
//  HSBuyDataProvider.m
//  Marry1.0
//
//  Created by apple on 14-10-15.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "HSBuyDataProvider.h"

@implementation HSBuyDataProvider
-(void)requstBuyData:(int)ID
{
    getBuyData = [NSMutableData data];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://marrymemo.com/products/%d.json?user_id=(null)",ID]];
    
    
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
    [getBuyData appendData:data];
}
// 数据下（加）载完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog(@"数据下（加）载完成");
    
    NSDictionary *contentDict = [getBuyData objectFromJSONData];
    ;
    
    
    NSString *urlString = [[contentDict objectForKey:@"product"] objectForKey:@"buy_url"];
    
    @try {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BuyNotifi" object:self userInfo:@{@"buy_url": urlString}];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    

}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"请求失败，error = %@",error);
}

@end
