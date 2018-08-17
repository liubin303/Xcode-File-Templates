//
//  ___FILENAME___
//  TakeAway
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ dianping.com. All rights reserved.
//

#import "___FILEBASENAME___.h"
#import "NVURLAction.h"
#import "UIViewController+TAStatistic.h"

@interface ___FILEBASENAMEASIDENTIFIER___ ()

//@property (nonatomic, strong) <#type#> *<#name#>;

@end

@implementation ___FILEBASENAMEASIDENTIFIER___

#pragma mark - NVBaseModulesViewControllerProtocol
- (BaseModulesArray)modules {
    return @[
 //            @[@[@"<#ModuleName#>", NSStringFromClass([<#ModuleClass#> class])]],
             ];
}

#pragma mark - NVURLAction
- (BOOL)handleWithURLAction:(NVURLAction *)urlAction {
    [super handleWithURLAction:urlAction];
    return YES;
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tast_cid = R_TAS_PV_<#PV_NAME#>;
    [self p_setupNavigationBar];
    [self p_setupSubViews];
    [self p_bindWhiteBoard];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Initialize Methods
- (void)p_setupNavigationBar {
    //    self.navigationItem.title = @"<#title#>";
}

- (void)p_setupSubViews {
    
}

- (void)p_bindWhiteBoard {
    
}

#pragma mark - Override Methods

#pragma mark - Notification Methods

#pragma mark - Delegate

#pragma mark - Private Methods

#pragma mark - Getter & Setter
- (<#type#>)<#name#> {
    if (_<#name#> == nil){
        _<#name#> = [[<#type#> new];
    }
    return _<#name#>;
}

@end
