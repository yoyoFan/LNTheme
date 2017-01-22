//
//  LNThemePicker.m
//  LNTheme
//
//  Created by vvusu on 1/19/17.
//  Copyright © 2017 vvusu. All rights reserved.
//

#import "LNThemePicker.h"
#import "LNTheme.h"

@implementation LNThemePicker

+ (instancetype)initWithColorType:(LNThemeColorType)type {
    LNThemePicker *picker = [[LNThemePicker alloc]init];
    picker.block = ^() {
       return [LNTheme colorForType:type];
    };
    return picker;
}

+ (instancetype)initWithImageName:(NSString *)name {
    LNThemePicker *picker = [[LNThemePicker alloc]init];
    picker.block = ^() {
       return [LNTheme imageNamed:name];
    };
    return picker;
}

+ (instancetype)initWithImageName:(NSString *)name renderingMode:(UIImageRenderingMode)mode {
    LNThemePicker *picker = [[LNThemePicker alloc]init];
    picker.block = ^() {
        return [[LNTheme imageNamed:name] imageWithRenderingMode:mode];
    };
    return picker;
}

+ (instancetype)initTextAttributesColorType:(LNThemeColorType)color font:(LNThemeFontType)font {
    LNThemePicker *picker = [[LNThemePicker alloc]init];
    picker.block = ^() {
        NSDictionary *textAttributes = @{NSFontAttributeName:[LNTheme fontForType:font],
                                         NSForegroundColorAttributeName:[LNTheme colorForType:color]};
        return textAttributes;
    };
    return picker;
}

#pragma mark - UIControlState

+ (instancetype)initWithColorType:(LNThemeColorType)type forState:(UIControlState)state {
    LNThemePicker *picker = [self initWithColorType:type];
    picker.valueState = state;
    picker.type = ThemeStatePicker;
    return picker;
}

+ (instancetype)initWithImageName:(NSString *)name forState:(UIControlState)state {
   LNThemePicker *picker = [self initWithImageName:name];
    picker.valueState = state;
    picker.type = ThemeStatePicker;
    return picker;
}

+ (instancetype)initWithImageName:(NSString *)name forBarMetrics:(UIBarMetrics)state {
    LNThemePicker *picker = [self initWithImageName:name];
    picker.type = ThemeStatePicker;
    picker.valueState = (NSUInteger)state;
    return picker;
}

+ (instancetype)initTextAttributesColorType:(LNThemeColorType)color font:(LNThemeFontType)font forState:(UIControlState)state {
    LNThemePicker *picker = [self initTextAttributesColorType:color font:font];
    picker.valueState = state;
    picker.type = ThemeStatePicker;
    return picker;
}

#pragma mark - ThemeCGColorPicker
+ (instancetype)initWithCGColor:(LNThemeColorType)type {
    LNThemePicker *picker = [[LNThemePicker alloc]init];
    picker.type = ThemeCGColorPicker;
    picker.block = ^() {
        return [LNTheme colorForType:type];
    };
    return picker;
}

#pragma mark - ThemeCGFloatPicker
+ (instancetype)initWithCGFloat:(CGFloat)num {
    LNThemePicker *picker = [[LNThemePicker alloc]init];
    picker.type = ThemeCGFloatPicker;
    picker.block = ^() {
        //这里根据主题选择
        return [NSNumber numberWithFloat:num];
    };
    return picker;
}

#pragma mark - ThemeEdgeInsetPicker
+ (instancetype)initWithImageInsets:(LNThemeImageInsetsType)type {
    LNThemePicker *picker = [[LNThemePicker alloc]init];
    picker.type = ThemeEdgeInsetPicker;
    picker.block = ^() {
        return [LNTheme imageInsetsForType:type];
    };
    return picker;
}

#pragma mark - ThemeStatusBarPicker
+ (instancetype)initWithStatusBarAnimated:(BOOL)animated {
    LNThemePicker *picker = [[LNThemePicker alloc]init];
    picker.type = ThemeStatusBarPicker;
    picker.valueState = animated;
    picker.block = ^() {
        //这里根据主题选择
        return [NSNumber numberWithFloat:0];
    };
    return picker;
}

@end
