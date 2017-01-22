//
//  LNTheme.m
//  GoldUISSFramework
//
//  Created by vvusu on 12/30/16.
//  Copyright © 2016 Micker. All rights reserved.
//

#import "LNTheme.h"

@interface LNTheme()
@property (nonatomic, strong, readwrite) NSString *currentTheme;
@property (nonatomic, strong, readwrite) NSString *currentThemePath;
@property (nonatomic, strong, readwrite) NSDictionary *currentThemeDic;
@property (nonatomic, strong, readwrite) NSDictionary *currentColorDic;
@end
@implementation LNTheme

+ (instancetype)instance {
    static LNTheme *staticInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticInstance = [[self alloc] init];
    });
    return staticInstance;
}

- (id)init {
    if (self = [super init]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *themeName = [defaults objectForKey:@"com.wscn.LNTheme.defaulttheme"];
        if (!themeName) {
            themeName = @"default";
        }
        [self changeTheme:themeName];
    }
    return self;
}

- (void)setCurrentTheme:(NSString *)currentTheme {
    _currentTheme = currentTheme;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentTheme forKey:@"com.wscn.LNTheme.defaulttheme"];
    [defaults synchronize];
}

- (void)changeTheme:(NSString *)themeName {
    self.currentTheme = themeName;
    self.currentThemePath = [NSString stringWithFormat:@"%@/Library/UserData/Skin/CurrentTheme/%@",NSHomeDirectory(),themeName];
    //设置颜色值
    NSString *filePath = [NSString stringWithFormat:@"%@/Info.json",self.currentThemePath];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    if (fileData) {
        NSError *error = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:&error];
        self.currentThemeDic = json;
        self.currentColorDic = [json valueForKey:@"colors"];
    }
}

#pragma mark - 方法
+ (void)changeTheme:(NSString *)themeName {
    [[LNTheme instance] changeTheme:themeName];
    [[LNTheme instance] updateTheme];
}

+ (UIColor *)colorForType:(LNThemeColorType)type {
    NSArray *colorKeys = @[@"c1",@"c2",@"c3",@"c4",@"c5",@"c6",@"c7",@"c8",@"c9",@"c1",@"cmsgl",@"cmsgr",@"ctabn",@"ctabh"];
    NSInteger num = type;
    if (num < colorKeys.count) {
        NSString *hexString = [LNTheme instance].currentColorDic[colorKeys[num]];
        if (hexString.length < 6) {
            return [UIColor whiteColor];
        } else {
            return [UIColor colorWithHexString:hexString];
        }
    } else {
        return [UIColor clearColor];
    }
}

+ (UIImage *)imageNamed:(NSString *)name {
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@",[LNTheme instance].currentThemePath,name];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    if (!image) {
        image = [UIImage imageNamed:name];
    }
    return image;
}

+ (UIFont *)fontForType:(LNThemeFontType)type {
    //后台控制font类型 和 大小 自行定义
    return [UIFont systemFontOfSize:(CGFloat)type];
}


+ (NSValue *)imageInsetsForType:(LNThemeImageInsetsType)type {
    NSArray *coordinatorKeys = @[@"NMTabBarBadgePointViewHighlightOriginOffset",
                                 @"NMTabBarBadgePointViewOriginOffset",
                                 @"NMTabBarBadgeTextViewHighlightOriginOffset",
                                 @"NMTabBarBadgeTextViewOriginOffset"];
    NSString *coordinator = [LNTheme instance].currentThemeDic[@"coordinators"][coordinatorKeys[type]];
    //为了demo 写死，后续要根据接口实际返回格式做调整
    coordinator = [coordinator stringByReplacingOccurrencesOfString:@"{"withString:@""];
    coordinator = [coordinator stringByReplacingOccurrencesOfString:@"}"withString:@""];
    NSArray *array = [coordinator componentsSeparatedByString:@","];
    NSString *numStr = array[1];
    CGFloat num = numStr.floatValue;
    num = fabs(num);
    NSValue *value = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(-num, 0, num, 0)];
    return value;
}

@end
