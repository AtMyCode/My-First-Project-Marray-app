//
//  GuangGuangDataProvider.m
//  Marry1.0
//
//  Created by apple on 14-9-28.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "GuangGuangDataProvider.h"

@implementation GuangGuangDataProvider
@synthesize productsPriceArr,productsUrlArr,productsLike_CountArr,productsLikeNumArr,page_Int,products_IDArr,productsDetailInfoArr;

-(id)init
{
    if (self = [super init]) {
        [self initProductsArr];//初始化数组
        self.categoryIndex = 0;
        self.page_Int = 0;
//        [self requestData];
    }
    return self;
}
#pragma mark请求数据
-(void)requestData
{
   
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //get请求
        //创建URL
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://marrymemo.com/products.json?page=%d&user_id=-1&category=%d",++page_Int,self.categoryIndex]];
        //通过url创建网络请求
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
        //连接数据库
        NSURLResponse *respone =nil;
        NSError *error = nil;
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&respone error:&error];
        
        //json解析
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@",dict);
        
        NSArray *products = [dict objectForKey:@"products"];
        //NSLog(@"products = %@",products);
        for (NSDictionary *strProducts in products)
        {
            
            [self.productsUrlArr addObject:[strProducts objectForKey:@"photo_path"]];//图片url
            [self.productsPriceArr addObject:[strProducts objectForKey:@"price"]];//价格
            [self.productsLike_CountArr addObject:[strProducts objectForKey:@"like_count"]];// 喜欢数
            [self.productsLikeNumArr addObject:[strProducts objectForKey:@"like"]];//喜爱
            [self.products_IDArr addObject:[strProducts objectForKey:@"id"]];
            //dispatch_sync(dispatch_get_global_queue(0, 0), ^{
                
                //get请求
                //创建URL
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://marrymemo.com/products/%@.json?user_id=(null)",[self.products_IDArr lastObject]]];
                //通过url创建网络请求
                NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
                //连接数据库
                NSURLResponse *respone =nil;
                NSError *error = nil;
                NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&respone error:&error];
                
                //json解析
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
                
                NSDictionary *products = [dict objectForKey:@"product"];
                NSString *introduce = [products objectForKey:@"introduce"] ;
            [self.productsDetailInfoArr addObject:introduce];
            

        }
        
    });
    
    
}
-(void)initProductsArr
{
    self.productsLike_CountArr = [[NSMutableArray alloc] initWithCapacity:15];
    self.productsPriceArr = [[NSMutableArray alloc] initWithCapacity:15];
    self.productsUrlArr = [[NSMutableArray alloc] initWithCapacity:15];
    self.productsLikeNumArr = [[NSMutableArray alloc] initWithCapacity:15];
    self.products_IDArr = [[NSMutableArray alloc] initWithCapacity:15];
    self.productsDetailInfoArr = [[NSMutableArray alloc] initWithCapacity:15];
}
@end
