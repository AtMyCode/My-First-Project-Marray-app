//
//  HDMerchantsDataProvider.m
//  Marry1.0
//
//  Created by apple on 14-10-3.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "HDMerchantsDataProvider.h"

@implementation HDMerchantsDataProvider
@synthesize pageNum;
-(id)init
{
    if (self = [super init]) {
        merchantsFans_countArr = [[NSMutableArray alloc] init];
        merchantsLogo_pathArr = [[NSMutableArray alloc] init];
        merchantsNameArr = [[NSMutableArray alloc] init];
        merchantsOpu_count = [[NSMutableArray alloc] init];
        merchantsPropertiesNameArr = [[NSMutableArray alloc] init];
        merchantsMID = [[NSMutableArray alloc] init];
        self.pageNum=1;
    }
    return self;
}
-(void)requestMerchantsData
{
    getThemeData = [NSMutableData data];
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://marrymemo.com/merchants.json?page=%d",self.pageNum]];
    if (self.pageNum==1)
    {
        
        merchantsFans_countArr = [[NSMutableArray alloc] init];
        merchantsLogo_pathArr = [[NSMutableArray alloc] init];
        merchantsNameArr = [[NSMutableArray alloc] init];
        merchantsOpu_count = [[NSMutableArray alloc] init];
        merchantsPropertiesNameArr = [[NSMutableArray alloc] init];
    }
    NSLog(@"%d",self.pageNum);
    
    
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
    NSArray *merchantsArr = [contentDict objectForKey:@"merchants"];
   // NSLog(@"merchantsArr =%@",merchantsArr);
    
    for (NSDictionary *itemsDict in merchantsArr)
    {
        [merchantsFans_countArr addObject:[itemsDict objectForKey:@"fans_count"]];
        [merchantsLogo_pathArr addObject:[itemsDict objectForKey:@"logo_path"]];
        [merchantsNameArr addObject:[itemsDict objectForKey:@"name"]];
        [merchantsOpu_count addObject:[itemsDict objectForKey:@"opu_count"]];
        [merchantsMID addObject:[itemsDict objectForKey:@"mid"]];
        NSArray *propertiesArr = [itemsDict objectForKey:@"properties"];
        for (NSDictionary *propertiesDict in propertiesArr) {
            [merchantsPropertiesNameArr addObject:[propertiesDict objectForKey:@"name"]];
        }
    }
    //NSLog(@"%@",merchantsMID);
    //NSLog(@"%@,%@,%@,%@,%@",[merchantsPropertiesNameArr objectAtIndex:0],[merchantsOpu_count objectAtIndex:0],[merchantsNameArr objectAtIndex:0],[merchantsLogo_pathArr objectAtIndex:0],[merchantsFans_countArr objectAtIndex:0]);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"merchantsDataNotification" object:self userInfo:@{@"fans_count": merchantsFans_countArr,@"logo_path":merchantsLogo_pathArr,@"name":merchantsNameArr,@"opu_count":merchantsOpu_count,@"propertiesName":merchantsPropertiesNameArr,@"merchantsMID":merchantsMID}];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"请求失败，error = %@",error);
}


@end
