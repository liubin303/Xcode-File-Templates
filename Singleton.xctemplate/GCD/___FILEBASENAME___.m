//
//  ___FILENAME___
//  TakeAway
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ dianping.com. All rights reserved.
//

#import "___FILEBASENAME___.h"

@implementation ___FILEBASENAMEASIDENTIFIER___

static ___FILEBASENAMEASIDENTIFIER___ *sharedInstance = nil;

+ (___FILEBASENAMEASIDENTIFIER___ *)shared___FILEBASENAMEASIDENTIFIER___ {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
	return sharedInstance;
}

- (instancetype)init {
    if (sharedInstance) {
        return sharedInstance;
    }
    if (self = [super init]) {
    }
    return self;
}

@end
