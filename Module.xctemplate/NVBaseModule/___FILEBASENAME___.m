//
//  ___FILENAME___
//  TakeAway
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ dianping.com. All rights reserved.
//

#import "___FILEBASENAME___.h"
#import "ReactiveCocoa.h"
#import "RACEXTScope.h"
#import "UITableViewCell+NVSeparator.h"

NSString *k___FILEBASENAMEASIDENTIFIER___<#Name#>Key = @"k___FILEBASENAMEASIDENTIFIER___<#Name#>Key";

@interface ___FILEBASENAMEASIDENTIFIER___ ()

@property (nonatomic, strong) <#type#> *<#name#>;

@end

@implementation ___FILEBASENAMEASIDENTIFIER___

#pragma mark - NVBaseModuleProtocol
- (void)setupModule {
    [self registerClass:[<#CellClass#> class] forCellReuseIdentifier:[<#CellClass#> cellReuseId:nil]];
    @weakify(self)
    [[self.whiteBoard signalForKey:<#keypath#>] subscribeNext:^(id x) {
        @strongify(self)
        
        [self needReloadTableView];
    }];
}

- (BOOL)shouldShow {
    return YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    <#CellClass#> *cell = [tableView dequeueReusableCellWithIdentifier:[<#CellClass#> cellReuseId:nil]];
    [cell setData:<#data#>];
    cell.nvSeparatorType = NVCellSeparatorTypeNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [<#CellClass#> cellHeight:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

#pragma mark - Cell Delegate

#pragma mark - Private Methods

@end
