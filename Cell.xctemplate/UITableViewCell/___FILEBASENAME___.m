//
//  ___FILENAME___
//  TakeAway
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ dianping.com. All rights reserved.
//

#import "___FILEBASENAME___.h"
#import "UIView+Layout.h"
#import "NVStyle.h"
#import "UIColor+Util.h"
#import "UIFont+TAFont.h"

@interface ___FILEBASENAMEASIDENTIFIER___ ()

@property (nonatomic, strong) <#type#> *<#name#>;

@end

@implementation ___FILEBASENAMEASIDENTIFIER___

#pragma mark - LifeCycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initCellViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - NVBaseCellProtocol
- (void)setData:(id)data {
    if (!data) {
        TAAssert(NO, @"data can not be nil");
        return;
    }
}

+ (CGFloat)cellHeight:(id)data {
    return 0;
}

+ (NSString *)cellReuseId:(id)data {
    return NSStringFromClass(self.class);
}

#pragma mark - TargetAction Methods

#pragma mark - Private Methods
- (void)p_initCellViews {
    
}

#pragma mark - Getter & Setter
- (<#type#>)<#name#> {
    if (_<#name#> == nil){
        _<#name#> = [[<#type#> alloc] init];
    }
    return _<#name#>;
}

@end
