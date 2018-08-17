# Xcode File Templates
![xcode1.png]()

在创建一个工程或者一个类时，Xcode会根据我们的输入和选择帮我们生成不同的文件和文件内容，这个就是Xcode默认支持的模板，不幸的是，苹果并没有将模板相关的语法规则放到官方文档，但是我们可以通过Xcode本身包含的默认模板学习他的格式和语法，从而定制出更适合我们工程的文件模板。

## Xcode模板文件位置
* 全局路径：
`/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates`
`/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates`

* 自定义路径：
`~/Library/Developer/Xcode/Templates/`

注意路径下有平台和分类的区分，全局路径需要root的读写权限，一般不用修改，把自己的定制模板文件放在用户自定义的路径下就可以了。

## 模板文件介绍
### 模板文件结构

模板是包含在扩展名为.xctemplate的目录中的文件的集合。这只是一个普通的文件夹，但是Xcode需要.xctemplate后缀才能将这些目录识别为模板，一个模板通常包含以下文件:

```
├── TAFileTemplates
│   ├── xxx.xctemplate
│   │   ├── TemplateIcon.png
│   │   ├── TemplateIcon@2x.png
│   │   ├── TemplateInfo.plist
│   │   ├── ___FILEBASENAME___.h
│   │   └── ___FILEBASENAME___.m

```

1. TAFileTemplates是分类名
2. xxx.xctemplate是模板名，且必须以.xctemplate结尾
2. TemplateIcon.png和TemplateIcon@2x.png是Xcode创建文件界面的图标
3. TemplateInfo.plist用于配置文件模板的一些属性和选项
4. ___FILEBASENAME___文件就是我们的.h和.m文件的模板

### TemplateInfo.plist解析
![templateInfo.png]()
模板中最重要的文件是TemplateInfo.plist。这是一个描述模板行为的标准Apple plist。它允许你定义要创建的一个或多个输出文件，声明用户界面的选项和输入项，并允许在生成代码时创建要使用的自定义变量。

这个文件有两个不同的部分:第一个定义了通用的模板配置，第二个定义了模板的用户界面和输出变量。

#### 通用配置key

| Key | Value | Value Type |
| --- | --- | --- |
|  AllowedTypes | 允许包含的文件类型数组| Array<String> |
|  DefaultCompletionName | 如果允许不设置文件名时Save dialog上默认的名字 | String |
|  Kind | 模板分类，文件模板为Xcode.IDEKit.TextSubstitutionFileTemplateKind | String |
|  MainTemplateFile | 模板文件源文件 | String |
|  Description | 模板文件说明 | String |
|  Summary | 简短说明 | String |
|  SortOrder | 该模板显示的位置索引 | String |
|  Platforms | 支持的平台集，如com.apple.platform.iphoneos | Array<String> |
|  Options | 选择模板点击next后的dialog中的内容以及自定义变量 | Array<Dictionary>|

##### AllowedTypes常见类型
* public.objective-c-source (Objective-C)
* public.objective-c-plus-plus-source (Objective C++)
* public.c-source (C)
* public.c-plus-plus.source (C++)
* public.c-header (header file for C, C++, Objective C)
* public.ruby-script (Ruby)
* public.python-script (Python)
* com.sun.java-class (Java .class file)
* com.sun.java-source (Java .java file)
* public.xml (XML)
* public.source-code (generic source code)

#### Options key
Xcode的模板语法定义了一个可选的“Options”结构，用于配置模板的用户界面。Options键定义了一组字典元素，它们描述用户输入组件、用户界面字符串和自定义输出变量。

| Key | Value | Value Type |
| --- | --- | --- |
|  Default | 默认值 | String |
|  Description | 说明，鼠标悬浮在选项位置时会显示 | String |
|  Identifier | 唯一标识符 | String |
|  Name | 选项名字，会显示在xcode界面上 | String |
|  Required | 该选项是否必须输入或选择 | Boolean |
|  Type | 选项类型，包含static, text, combo, popup, class, and buildSetting | String |
|  NotPersisted | 输入值是否为将来使用而保留 | Boolean |
|  FallbackHeader | 如果无法确定要子类化的类的位置时倒入的头文件 | String |
|  Suffixes | 一个后缀字典，根据你要子类化的类型添加。 | Array<Dictionary>|
|  Values | 如果类型是combo, popup, classs时，需要提供的值数组 | Array<String>|
|  RequiredOptions | 根据其他选项的值来选择启用/禁用本选项 | Array<Dictionary>|

![option_type.png]()

##### 需要分组的类型

popup、combo、class、checkbox这几种类型需要我们为其创建子目录并添加对应的模板文件，Xcode将在.xctemplate文件中查找到输入元素提供的值的子目录。

```
<key>Options</key>
<array>
    <dict>
        <key>Type</key>
        <string>combo</string>
        <key>Values</key>
        <array>
            <string>Red</string>
            <string>Green</string>
            <string>Blue</string>
        </array>
    </dict>
</array>
```

以上模板期望在红色、绿色或蓝色目录下找到主模板文件。如果不提供这个目录结构，模板将会无声地失败，或者导致Xcode崩溃。需要有几个模板源文件的变体(通常是微妙的变体)确实会导致大量冗余，但也提供了一种方便的方式来对模板内容进行分组。

##### 其他类型
 
* static
* text

如何从用户界面获取输入并将其映射到模板源中呢?我们可以在源模板文件中使用Options定义的的标识符变量名来引用它的关联值。例如，如果模板定义了一个名为viewColor的标识符，那么您可以在源模板中使用___VARIABLE_viewColor___或___VARIABLE_viewColor:identifier___引用变量的值。

### 模板文件源

一般情况下我们希望根据我们的文件模板输出一个OC类，所有我们需要在模板目录中创建.h和.m两个文件模板，其内容大概如下。

___FILEBASENAME___.h

```
//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
 
@interface ___FILEBASENAMEASIDENTIFIER___ : NSObject
 
@end
```

___FILEBASENAME___.m

```
//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
 
#import "___FILEBASENAME___.h"
 
@implementation ___FILEBASENAMEASIDENTIFIER___
 
@end
```

源模板文件有许多以三重下划线作为前缀和后缀的值。这些是内置的扩展宏，可用于在输出中提供动态值。以下是一些常用的宏:

| 宏 | 说明 |
| --- | --- | 
|  `___PROJECTNAME___` | 工程名 |
|  `___FILENAME___` | 包含后缀的文件名 |
|  `___FILEBASENAME___` | 不包含后缀的文件名 |
|  `___FILEBASENAMEASIDENTIFIER___` | 不包含后缀的c格式文件名 |
|  `___FULLUSERNAME___` | 用户名 |
|  `___ORGANIZATIONNAME___` | 公司名 |
|  `___COPYRIGHT___` | 版权说明 |
|  `___DATE___` | 当前日期 |
|  `___TIME___` | 当前时间 |
|  `___YEAR___` | 当前年 |


## TakeAway File Templates
我们定制的模板分类名称为TAFileTemplates，目前支持Cell、Module、ModuleViewController、Singleton四种模板。
![xcode1.png]()

### Cell Template
![xcode_cell.png]()


```
//
//  ___FILENAME___
//  TakeAway
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ dianping.com. All rights reserved.
//

#import "___VARIABLE_cocoaTouchSubclass___.h"
#import "NVBaseCellProtocol.h"

@interface ___FILEBASENAMEASIDENTIFIER___ : ___VARIABLE_cocoaTouchSubclass___<NVBaseCellProtocol>

@end


```

___FILEBASENAME___.m

```
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
```

### Module Template
![xcode_module.png]()


___FILEBASENAME___.h

```
//
//  ___FILENAME___
//  TakeAway
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ dianping.com. All rights reserved.
//

#import "___VARIABLE_cocoaTouchSubclass___.h"

extern NSString *k___FILEBASENAMEASIDENTIFIER___<#Name#>Key;

@interface ___FILEBASENAMEASIDENTIFIER___ : ___VARIABLE_cocoaTouchSubclass___

@end
```

___FILEBASENAME___.m

```
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

```

### ModuleViewController Template
![xcode_vc.png]()

___FILEBASENAME___.h

```
//
//  ___FILENAME___
//  TakeAway
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ dianping.com. All rights reserved.
//

#import "___VARIABLE_cocoaTouchSubclass___.h"

@interface ___FILEBASENAMEASIDENTIFIER___ : ___VARIABLE_cocoaTouchSubclass___

@end

```

___FILEBASENAME___.m


```
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

```

### Singleton Template
![xcode_singleton.png]()

___FILEBASENAME___.h

```
//
//  ___FILENAME___
//  TakeAway
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ dianping.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ___FILEBASENAMEASIDENTIFIER___ : NSObject

+ (___FILEBASENAMEASIDENTIFIER___ *)shared___FILEBASENAMEASIDENTIFIER___;

@end

```

___FILEBASENAME___.m

```
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

```

## Usage
1. Clong Xcode-File-Templates
2. $cd Xcode-File-Templates
3. $sh install.sh
4. restart Xcode


## 参考
[http://www.bobmccune.com/2012/03/04/creating-custom-xcode-4-file-templates/](http://www.bobmccune.com/2012/03/04/creating-custom-xcode-4-file-templates/)



