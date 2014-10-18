//
//  TRKTPurchase.m
//  App purchase
//
//  Created by Jorginho on 10/17/14.
//  Copyright (c) 2014 jorgehsrocha. All rights reserved.
//

#import "TRKTPurchase.h"

@implementation TRKTPurchase

-(id)initWithProductsIdentifiers:(NSSet *)identifiers{
  
    self = [super init];

    self.productIdentifiers = identifiers;

    return self;
}

#pragma mark - SKPayment delegate
- (void) paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    
    for (SKPaymentTransaction *transaction in transactions) {
        
        switch (transaction.transactionState) {
            
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"Purchasing...");
                break;
            
            case SKPaymentTransactionStatePurchased:
                
                [self saveProductState:transaction.payment.productIdentifier withTransaction:transaction];
                
                self.purchaseRequestHandler(YES,nil);
                self.purchaseRequestHandler = nil;
                
                break;
            
            case SKPaymentTransactionStateDeferred:
                
                NSLog(@"Deffered");
                self.purchaseRequestHandler = nil;
                break;
            
            case SKPaymentTransactionStateRestored:
                
                NSLog(@"Purchase restored");
                [self saveProductState:transaction.payment.productIdentifier withTransaction:transaction];
                self.purchaseRequestHandler(YES,nil);
                self.purchaseRequestHandler = nil;
                break;
            
            case SKPaymentTransactionStateFailed:
                
                NSLog(@"Purchase failed!\nError description:\n%@",transaction.error.debugDescription);
                break;
            
            default:
                break;
        }
        
    }
    
}

- (void) paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions{
    
}

- (void) paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    
}

- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue{
    
}

- (void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    if (response.products.count > 0) {

        self.productsRequestHandler(YES, response.products);
        self.productsRequestHandler = nil;
        
    }else if( [response isEqual:[NSNull null]] ){
        
        self.productList = [NSMutableArray new];
        self.productsRequestHandler(NO, nil);
        self.productsRequestHandler = nil;
        
    }
    
}

- (void) request:(SKRequest *)request didFailWithError:(NSError *)error{
    
    self.productsRequestHandler(NO, nil);
    self.productsRequestHandler = nil;
}

- (BOOL) canMakePayments{
    
    return [SKPaymentQueue canMakePayments];
    
}

- (void) receiveListOfProducts:(RequestProductsCompletionHandler)completionHandler{
    
    self.productsRequestHandler = [completionHandler copy];

    self.skProductsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:self.productIdentifiers];
    
    self.skProductsRequest.delegate = self;
    
    [self.skProductsRequest start];
    
}

- (void) purchaseProduct:(SKProduct *)product completation:(RequestPurchaseCompletionHandler)completionHandler{
    
    self.purchaseRequestHandler = [completionHandler copy];
    
    if ([self canMakePayments]) {

        
        SKPayment *productPayment = [SKPayment paymentWithProduct:product];
        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:productPayment];
     
    }else{

        self.purchaseRequestHandler(NO, nil);
        self.purchaseRequestHandler = nil;
    }

}

- (void) saveProductState:(NSString *)product withTransaction:(SKPaymentTransaction *)paymentTransaction{

    [[SKPaymentQueue defaultQueue] finishTransaction:paymentTransaction];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:product];
    
}

@end
