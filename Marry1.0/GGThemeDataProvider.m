//
//  GGDetailDataProvider.m
//  Marry1.0
//
//  Created by Ibokan on 14-9-29.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "GGThemeDataProvider.h"

@implementation GGThemeDataProvider
@synthesize pageNum;
-(id)init
{
    if (self = [super init])
    {
        themeIDArr = [[NSMutableArray alloc] init];
        themeImageUrlArr = [[NSMutableArray alloc] init];
        themeTitleArr = [[NSMutableArray alloc] init];
        getThemeData = [NSMutableData data];
    }
    return self;
}
-(void)requestImageThemeData
{
    getThemeData = [NSMutableData data];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://marrymemo.com/subjects.json?page=%d",++pageNum]];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
    getConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self ];
}
// 接收到请求响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"接收到请求响应");
   // NSLog(@"length= %lld",response.expectedContentLength);
   

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
    
    NSDictionary *dict = [getThemeData objectFromJSONData];
    ;

    NSArray *arr = [dict objectForKey:@"subjects"];
        for (NSDictionary *contentDict in arr)
    {
       [themeImageUrlArr addObject:[contentDict objectForKey:@"cover_path"]] ;//主题图片url
       [themeIDArr addObject:[contentDict objectForKey:@"id"]] ;//id
       [themeTitleArr addObject:[contentDict objectForKey:@"title"]] ;//主题标题
    }
   // NSLog(@"%@,%@,%@",[themeTitleArr objectAtIndex:0],[themeImageUrlArr objectAtIndex:0],[themeIDArr objectAtIndex:0]);
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"THEMEDATADFINISH" object:self userInfo:@{@"cover_path": themeImageUrlArr,@"id":themeIDArr,@"title":themeTitleArr}];
    

}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"请求失败，error = %@",error);
}
@end
