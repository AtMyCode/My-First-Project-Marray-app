//
//  StoryDataProvider.m
//  Marry1.0
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "StoryDataProvider.h"

@implementation StoryDataProvider
-(id)init
{
    if (self=[super init]) {
        imagePath = [[NSMutableArray alloc] init];
        titleArr = [[NSMutableArray alloc] init];
        avatarArr = [[NSMutableArray alloc] init];
        praise_countArr = [[NSMutableArray alloc] init];
        storyId = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)requestStoryData
{
    static int pageNum=1;
    getData = [NSMutableData data];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://marrymemo.com/stories.json?page=%d&",pageNum++]];
    
    
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
    NSArray *storiesArr = [contentDict objectForKey:@"stories"];
    for (NSDictionary *dict in storiesArr)
    {
        [imagePath addObject:[dict objectForKey:@"cover_path"]];
        [titleArr addObject:[dict objectForKey:@"title"]];
        
        [avatarArr addObject:[[dict objectForKey:@"user"] objectForKey:@"avatar"]];
        [praise_countArr addObject:[dict objectForKey:@"praise_count"]];
        [storyId addObject:[dict objectForKey:@"id"]];
        //NSLog(@"%@",[[dict objectForKey:@"user"] objectForKey:@"nick"]);
    }
    //NSLog(@"%@",storiesArr);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"storyDataNotifi" object:self userInfo:@{@"cover_path": imagePath,@"title":titleArr,@"avatar":avatarArr,@"praise_count":praise_countArr,@"id":storyId}];
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"请求失败，error = %@",error);
}


@end
