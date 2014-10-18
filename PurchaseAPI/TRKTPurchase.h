//
//  TRKTPurchase.h
//  App purchase
//
//  Created by Jorginho on 10/17/14.
//  Copyright (c) 2014 jorgehsrocha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray * products);
typedef void (^RequestPurchaseCompletionHandler)(BOOL success, NSError *error);

@interface TRKTPurchase : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>

-(id)initWithProductsIdentifiers:(NSSet *)identifiers;

@property (strong, nonatomic) RequestProductsCompletionHandler productsRequestHandler;
@property (strong, nonatomic) RequestPurchaseCompletionHandler purchaseRequestHandler;
@property (strong, nonatomic) NSMutableArray *productList;
@property (strong, nonatomic) SKProduct *skProduct;
@property (strong, nonatomic) SKPayment *skPayment;
@property (strong, nonatomic) SKProductsRequest *skProductsRequest;
@property (strong, nonatomic) SKRequest *skRequest;
@property (strong, nonatomic) NSSet *productIdentifiers;

- (BOOL) canMakePayments;
- (void) receiveListOfProducts:(RequestProductsCompletionHandler)completionHandler;
- (void) purchaseProduct:(SKProduct *)product completation:(RequestPurchaseCompletionHandler)completionHandler;


@end
