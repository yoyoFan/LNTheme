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
@property (nonatomic, strong, readwrite) NSMutableDictionary *currentFontDic;
@property (nonatomic, strong, readwrite) NSMutableDictionary *currentColorDic;
@property (nonatomic, strong, readwrite) NSMutableDictionary *currentOffsetDic;
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
    
    NSArray *JsonFileArr = [self getFilenamelistOfType:@"json" fromDirPath:self.currentThemePath];
    NSMutableDictionary *fontDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *colorDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *offsetDic = [NSMutableDictionary dictionary];
    //取出所有值
    for (NSString *jsonfile in JsonFileArr) {
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",self.currentThemePath,jsonfile];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        if (fileData) {
            NSError *error = nil;
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:&error];
            [fontDic setValuesForKeysWithDictionary:[jsonDic valueForKey:@"fonts"]];
            [colorDic setValuesForKeysWithDictionary:[jsonDic valueForKey:@"colors"]];
            [offsetDic setValuesForKeysWithDictionary:[jsonDic valueForKey:@"coordinators"]];
        }
    }
    
    if (colorDic.count == 0) {
        //默认颜色数值
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"defaultTheme" ofType:@"json"];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        NSError *error = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:&error];
        fontDic = [json valueForKey:@"fonts"];
        colorDic = [json valueForKey:@"colors"];
        offsetDic = [json valueForKey:@"coordinators"];
    }
    
    //添加配置
    self.currentFontDic = fontDic;
    self.currentColorDic = colorDic;
    self.currentOffsetDic = offsetDic;
}

- (NSArray *)getFilenamelistOfType:(NSString *)type fromDirPath:(NSString *)dirPath {
    NSMutableArray *filenamelist = [NSMutableArray arrayWithCapacity:10];
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil];
    for (NSString *filename in tmplist) {
        NSString *fullpath = [dirPath stringByAppendingPathComponent:filename];
        if ([self isFileExistAtPath:fullpath]) {
            if ([[filename pathExtension] isEqualToString:type]) {
                [filenamelist  addObject:filename];
            }
        }
    }
    return filenamelist;
}

- (BOOL)isFileExistAtPath:(NSString*)fileFullPath {
    BOOL isExist = NO;
    isExist = [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
    return isExist;
}

#pragma mark - 方法
+ (void)changeTheme:(NSString *)themeName {
    [[LNTheme instance] changeTheme:themeName];
    [[LNTheme instance] updateTheme];
}

+ (UIImage *)imageNamed:(NSString *)name {
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@",[LNTheme instance].currentThemePath,name];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    if (!image) {
        image = [UIImage imageNamed:name];
    }
    return image;
}

+ (UIColor *)colorForType:(NSString *)type {
    if (type) {
        NSString *hexString = [LNTheme instance].currentColorDic[type];
        if (hexString.length < 6) {
            return [UIColor whiteColor];
        } else {
            return [UIColor colorWithHexString:hexString];
        }
    } else {
        return [UIColor clearColor];
    }
}

+ (UIFont *)fontForType:(NSString *)type {
    if (type) {
        //后台控制font类型 和 大小 自行定义
        NSString *fontSize = [LNTheme instance].currentFontDic[type];
        return [UIFont systemFontOfSize:fontSize.floatValue];
    } else {
        return [UIFont systemFontOfSize:10];
    }
}

+ (NSValue *)imageInsetsForType:(NSString *)type {
    NSString *coordinator = [LNTheme instance].currentOffsetDic[type];
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
