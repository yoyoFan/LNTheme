//
//  NSObject+LNTheme.m
//  GoldUISSFramework
//
//  Created by vvusu on 1/16/17.
//  Copyright © 2017 Micker. All rights reserved.
//

#import "NSObject+LNTheme.h"
#import "LNTheme.h"
#import <objc/runtime.h>
#import "LNThemePicker.h"

static void *LNTheme_ThemeMap;
static NSHashTable *themeHashTable;

@implementation NSObject (LNTheme)
- (NSHashTable *)themeHashTable {
    if (!themeHashTable) {
        themeHashTable = [NSHashTable weakObjectsHashTable];
    }
    return themeHashTable;
}

- (NSMutableDictionary *)themePickers {
    NSMutableDictionary *themeMap = objc_getAssociatedObject(self, &LNTheme_ThemeMap);
    if (themeMap) {
        return themeMap;
    } else {
        themeMap = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &LNTheme_ThemeMap, themeMap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return themeMap;
    }
}

- (void)setThemePickers:(NSMutableDictionary *)themePickers {
    objc_setAssociatedObject(self, &LNTheme_ThemeMap, themePickers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (themePickers) {
        [self.themeHashTable addObject:self];
    }
}

//添加标识设置属性
- (void)setThemePicker:(NSObject *)object selector:(NSString *)sel picker:(LNThemePicker *)picker {
    NSMutableArray *pickers = [object.themePickers valueForKey:sel];
    if (!pickers) { pickers = [NSMutableArray array]; }
    [pickers addObject:picker];
    [object.themePickers setValue:pickers forKey:sel];
    [object performThemePicker:sel picker:picker];
    [self.themeHashTable addObject:object];
}

//更新主题，遍历Map 设置主题
- (void)updateTheme {
    for (NSObject *objetc in self.themeHashTable) {
        [objetc.themePickers enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
            NSMutableArray *arry = object;
            [arry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [UIView animateWithDuration:0.3 animations:^{
                    [objetc performThemePicker:key picker:obj];
                }];
            }];
        }];
    }
}

//解析，动态设置属性
- (void)performThemePicker:(NSString *)selStr picker:(LNThemePicker *)picker {
    SEL selector = NSSelectorFromString(selStr);
    //判断有没有方法
    if (![self respondsToSelector:selector]) { return; }
    id value = picker.block();
    if (!value) { return; }
    IMP imp = [self methodForSelector:selector];

    //调用方法
    switch (picker.type) {
        case ThemePicker: {
            void (*func)(id, SEL, id) = (void *)imp;
            func(self, selector, value);
        }
            break;
        case ThemeStatePicker: {
            void (*func)(id, SEL, id, UIControlState) = (void *)imp;
            func(self, selector, value, picker.valueState);
        }
            break;
        case ThemeCGColorPicker: {
            void (*func)(id, SEL, CGColorRef) = (void *)imp;
            CGColorRef color = ((UIColor *)value).CGColor;
            func(self, selector, color);
        }
            break;
        case ThemeCGFloatPicker: {
            void (*func)(id, SEL, CGFloat) = (void *)imp;
            NSNumber *num = value;
            func(self, selector, num.floatValue);
        }
            break;
        case ThemeEdgeInsetPicker: {
            void (*func)(id, SEL, UIEdgeInsets) = (void *)imp;
            NSValue *empty = value;
            func(self, selector, empty.UIEdgeInsetsValue);
        }
            break;
        case ThemeStatusBarPicker: {
            void (*func)(id, SEL, UIStatusBarStyle, BOOL) = (void *)imp;
            NSNumber *num = value;
            UIStatusBarStyle style = num.integerValue;
            func(self, selector, style, picker.valueState);
        }
            break;
    }
}

@end

@implementation UIColor (LNTheme)
+ (UIColor *)colorWithHexString:(NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat)colorComponentFrom:(NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@end

#pragma mark - UIView

@implementation UIApplication (LNTheme)
- (void)ln_setStatusBarAnimated:(BOOL)animated {
    [self setThemePicker:self selector:@"setStatusBarStyle:animated:"
                  picker:[LNThemePicker initWithStatusBarAnimated:animated]];
}

@end

@implementation UIView (LNTheme)
- (void)ln_tinyColor:(LNThemeColorType)type {
    [self setThemePicker:self selector:@"setTintColor:" picker:[LNThemePicker initWithColorType:type]];
}

- (void)ln_backgroundColor:(LNThemeColorType)type {
    [self setThemePicker:self selector:@"setBackgroundColor:" picker:[LNThemePicker initWithColorType:type]];
}

@end

@implementation UITabBar (LNTheme)
- (void)ln_barTinyColor:(LNThemeColorType)type {
    [self setThemePicker:self selector:@"setBarTintColor:" picker:[LNThemePicker initWithColorType:type]];
}

- (void)ln_backgroundImageNamed:(NSString *)name {
    [self setThemePicker:self selector:@"setBackgroundImage:" picker:[LNThemePicker initWithImageName:name]];
}

@end

@implementation UITabBarItem (LNTheme)

- (void)ln_imageNamed:(NSString *)name renderingMode:(UIImageRenderingMode)mode {
    [self setThemePicker:self selector:@"setImage:"
                  picker:[LNThemePicker initWithImageName:name renderingMode:mode]];
}

- (void)ln_selectedImageNamed:(NSString *)name renderingMode:(UIImageRenderingMode)mode {
    [self setThemePicker:self selector:@"setSelectedImage:"
                  picker:[LNThemePicker initWithImageName:name renderingMode:mode]];
}

- (void)ln_imageInsets:(LNThemeImageInsetsType)type {
    [self setThemePicker:self selector:@"setImageInsets:"
                  picker:[LNThemePicker initWithImageInsets:type]];
}

- (void)ln_titleTextAttributes:(LNThemePicker *)picker {
    [self setThemePicker:self selector:@"setTitleTextAttributes:forState:" picker:picker];
}

@end

@implementation UINavigationBar (LNTheme)
- (void)ln_barTinyColor:(LNThemeColorType)type {
    [self setThemePicker:self selector:@"setBarTintColor:" picker:[LNThemePicker initWithColorType:type]];
}

- (void)ln_titleTextAttributes:(LNThemePicker *)picker {
    [self setThemePicker:self selector:@"setTitleTextAttributes:" picker:picker];
}

- (void)ln_backgroundImageNamed:(NSString *)name forBarMetrics:(UIBarMetrics)state {
     [self setThemePicker:self selector:@"setBackgroundImage:forBarMetrics:"
                   picker:[LNThemePicker initWithImageName:name forBarMetrics:state]];
}

@end

@implementation UIBarButtonItem (LNTheme)
- (void)ln_tinyColor:(LNThemeColorType)type {
    [self setThemePicker:self selector:@"setTintColor:" picker:[LNThemePicker initWithColorType:type]];
}

@end

@implementation UILabel (LNTheme)
- (void)ln_textColor:(LNThemeColorType)type {
    [self setThemePicker:self selector:@"setTextColor:" picker:[LNThemePicker initWithColorType:type]];
}

- (void)ln_shadowColor:(LNThemeColorType)type {
    [self setThemePicker:self selector:@"setShadowColor:" picker:[LNThemePicker initWithColorType:type]];
}

- (void)ln_highlightedTextColor:(LNThemeColorType)type {
    [self setThemePicker:self selector:@"setHighlightedTextColor:" picker:[LNThemePicker initWithColorType:type]];
}

@end

@implementation UIButton (LNTheme)
- (void)ln_imageNamed:(NSString *)name forState:(UIControlState)state {
    [self setThemePicker:self selector:@"setImage:forState:"
                  picker:[LNThemePicker initWithImageName:name forState:(UIControlState)state]];
}

- (void)ln_backgroundImageNamed:(NSString *)name forState:(UIControlState)state {
    [self setThemePicker:self selector:@"setBackgroundImage:forState:"
                  picker:[LNThemePicker initWithImageName:name forState:(UIControlState)state]];
}

- (void)theme_titleColor:(LNThemeColorType)type forState:(UIControlState)state {
    [self setThemePicker:self selector:@"setTitleColor:forState:"
                  picker:[LNThemePicker initWithColorType:type forState:state]];
}

@end

@implementation UIImageView (LNTheme)
- (void)ln_imageNamed:(NSString *)name {
    [self setThemePicker:self selector:@"setImage:" picker:[LNThemePicker initWithImageName:name]];
}

@end

@implementation CALayer (LNTheme)
- (void)ln_borderColor:(LNThemeColorType)type {
  [self setThemePicker:self selector:@"setBorderColor:" picker:[LNThemePicker initWithCGColor:type]];
}

- (void)ln_shadowColor:(LNThemeColorType)type {
  [self setThemePicker:self selector:@"setShadowColor:" picker:[LNThemePicker initWithCGColor:type]];
}

- (void)ln_backgroundColor:(LNThemeColorType)type {
  [self setThemePicker:self selector:@"setBackgroundColor:" picker:[LNThemePicker initWithCGColor:type]];
}

@end

