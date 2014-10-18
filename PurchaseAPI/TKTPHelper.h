//
//  TKTPHelper.h
//  App purchase
//
//  Created by Jorginho on 10/18/14.
//  Copyright (c) 2014 jorgehsrocha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRKTPurchase.h"

@interface TKTPHelper : TRKTPurchase

+ (TKTPHelper *) sharedInstance:(NSSet *)identifiers;

@end
