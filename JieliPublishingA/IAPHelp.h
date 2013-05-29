//
//  IAPHelp.h
//  LearnInApp
//
//  Created by HuaChen on 13-5-6.
//  Copyright (c) 2013年 HuaChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#define kProductsLoadedNotification         @"ProductsLoaded"
#define kProductPurchasedNotification       @"ProductPurchased"
#define kProductPurchaseFailedNotification  @"ProductPurchaseFailed"
@interface IAPHelp : NSObject<SKProductsRequestDelegate,SKPaymentTransactionObserver>
@property (nonatomic,strong) SKProductsRequest *request;
@property (nonatomic,strong) NSSet *productIdentifiers;

@property (nonatomic,strong) NSArray *products;
@property (nonatomic,strong) NSMutableSet *purchasedProducts;

-(id)initWithProductIdentifiers:(NSSet *)productIdentifiers;

-(void)requestProducts;
//-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response;
- (void)buyProductIdentifier:(SKProduct *)product;

@end
