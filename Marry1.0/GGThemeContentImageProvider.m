//
//  GGThemeContentImageProvider.m
//  Marry1.0
//
//  Created by apple on 14-10-1.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "GGThemeContentImageProvider.h"

@implementation GGThemeContentImageProvider

-(void)requestImageThemeData:(int)ID
{
    getThemeData = [NSMutableData data];
    themeContentImagesURLArr = [[NSMutableArray alloc] init];
    themeContentLikeCountArr = [[NSMutableArray alloc] init];
    themeContentPriceArr = [[NSMutableArray alloc] init];
    themeSubject_descArr = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://marrymemo.com/subjects/%d.json",ID]];
    

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
    
    NSArray *arr = [contentDict objectForKey:@"products"];
    NSLog(@"%@",arr);
    for (NSDictionary *productDict in arr)
    {
        [themeContentLikeCountArr addObject:[productDict objectForKey:@"like_count"]];
        [themeContentImagesURLArr addObject:[productDict objectForKey:@"photo_path"]];
        [themeContentPriceArr addObject:[productDict objectForKey:@"price"]] ;
        [themeSubject_descArr addObject:[productDict objectForKey:@"subject_desc"]];
    }
//     NSLog(@"%@,%@,%@,%@",[themeContentLikeCountArr objectAtIndex:0],[themeContentImagesURLArr objectAtIndex:0],[themeContentPriceArr objectAtIndex:0],[themeSubject_descArr objectAtIndex:0]);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"THEMEContentDATADFINISH" object:self userInfo:@{@"photo_path": themeContentImagesURLArr,@"price":themeContentPriceArr,@"like_count":themeContentLikeCountArr,@"subject_desc":themeSubject_descArr}];
   
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"请求失败，error = %@",error);
}
@end
