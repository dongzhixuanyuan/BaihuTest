//
//  HomeTabBarController.m
//  BaihuTest
//
//  Created by liudong on 2020/4/27.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "HomeTabBarController.h"
#import "HomeTabBar.h"
#import "HomeTabBarConfig.h"
#import "HomeTabBarItem.h"

static CGFloat tabBarHeight = 49.0;
@interface HomeTabBarController ()<HomeTabBarDelegate>

@property (nonatomic, strong) HomeTabBar *customTabBar;
@property (nonatomic, strong) HomeTabBarConfig *config;
@end

@implementation HomeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.selectedIndex = 0;
}

- (HomeTabBar *)customTabBar {
    if (_customTabBar == nil) {
        _customTabBar = [[HomeTabBar alloc]init];
        _customTabBar.delegate = self;
    }
    return _customTabBar;
}

+ (instancetype)createTabBarController:(tabBarBlock)block {
    static dispatch_once_t onceToken;
    static HomeTabBarController *tabBarController;
    dispatch_once(&onceToken, ^{
        tabBarController = [[HomeTabBarController alloc]initWithBlock:block];
    });
    return tabBarController;
}

+ (instancetype)defaultTabBarController {
    return [HomeTabBarController createTabBarController:nil];
}

- (void)hiddenTabBarWithAnimation:(BOOL)animate {
    if (animate) {
        [UIView animateWithDuration:0.2 animations:^{
            self.customTabBar.alpha = 0;
        }];
    } else {
        self.customTabBar.alpha = 0;
    }
}

- (void)showTabBarWithAnimation:(BOOL)animate {
    if (animate) {
        [UIView animateWithDuration:0.2 animations:^{
            _customTabBar.alpha = 1.0;
        }];
    } else {
        _customTabBar.alpha = 1.0;
    }
}

- (instancetype)initWithBlock:(tabBarBlock)block {
    self = [super init];
    if (self) {
        HomeTabBarConfig *config = [[HomeTabBarConfig alloc]init];
        NSAssert(block, @"Param in the function ,can not be nil");
        if (block) {
            _config = block(config);
        }
        NSAssert(_config.viewController, @"Param viewcontroller in the config, can not be nil ");
        [self setupViewControllers];
        [self setupTabBar];
        _isAutoRotation = YES;
    }
    return self;
}

- (void)setupViewControllers {
    if (_config.isNavigation) {
        NSMutableArray *vcs = [NSMutableArray arrayWithCapacity:_config.viewController.count];
        for (UIViewController *vc in _config.viewController) {
            if (![vc isKindOfClass:[UINavigationController class]]) {
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
                [vcs addObject:nav];
            } else {
                [vcs addObject:vc];
            }
        }
        self.viewControllers = [vcs copy];
    } else {
        self.viewControllers = [_config.viewController copy];
    }
}

- (void)setupTabBar {
    NSMutableArray* items = [NSMutableArray array];
    for (int i=0; i < _config.viewController.count; i++) {
        HomeTabBarItem* item = [[HomeTabBarItem alloc]init];
        if (i == 0) {
            item.icon = _config.seletedImages[i];
            if (_config.title.count > 0) {
                item.titleColor = _config.selectedColor;
            }
        }else {
            item.icon = _config.normalImage[i];
            if(_config.title.count > 0 ){
                item.titleColor = _config.normalColor;
            }
        }
        if (i < _config.title.count) {
            item.title = _config.title[i];
        }
        [items addObject:item];
        item.tag = i;
    }
    self.tabBar.hidden = YES;
    self.customTabBar.items = [items copy];
    self.customTabBar.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - tabBarHeight, CGRectGetWidth(self.view.frame), tabBarHeight);
    [self.view addSubview:self.customTabBar];
}


-(void)tabBar:(HomeTabBar*) tab didSelectItem:(nonnull HomeTabBarItem *)item atIndex:(NSInteger)index {
    NSMutableArray* items = [NSMutableArray arrayWithCapacity:0 ];
    for (UIView* view in tab.subviews) {
        if ([view isKindOfClass:[HomeTabBarItem class]]) {
                    [items addObject:view];
        }
    }
    
    for (int i=0; i < items.count; i++) {
        UIView* view = items[i];
        if ([view isKindOfClass:[HomeTabBarItem class]]) {
            HomeTabBarItem* item = (HomeTabBarItem*)view;
            item.icon = self.config.normalImage[i];
            if (self.config.title.count > 0) {
                item.titleColor = _config.normalColor;
            }
        }
    }
    item.icon = _config.seletedImages[index];
    if (self.config.title.count > 0) {
        item.titleColor = _config.selectedColor;
    }
    self.selectedIndex = index;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    self.customTabBar.frame = CGRectMake(0, size.height-tabBarHeight, size.width, tabBarHeight);
}


- (BOOL)shouldAutorotate {
    return self.isAutoRotation;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.isAutoRotation) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
