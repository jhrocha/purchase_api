//
//  TKTPHelper.m
//  App purchase
//
//  Created by Jorginho on 10/18/14.
//  Copyright (c) 2014 jorgehsrocha. All rights reserved.
//

#import "TKTPHelper.h"

@implementation TKTPHelper

+ (TKTPHelper *) sharedInstance:(NSSet *)identifiers{
    
    static TKTPHelper *tktpurchase;
    
    static dispatch_once_t once;
    

    dispatch_once(&once, ^{

        NSSet *auxIdentifier = [NSSet setWithObject:@"com.testapppurchase.trakto"];
        
        tktpurchase = [[self alloc] initWithProductsIdentifiers:auxIdentifier];
        
    });
    
    return tktpurchase;
    
}
@end
