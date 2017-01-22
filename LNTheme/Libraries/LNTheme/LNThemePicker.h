//
//  LNThemePicker.h
//  LNTheme
//
//  Created by vvusu on 1/19/17.
//  Copyright © 2017 vvusu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LNThemeColorType) {
    C1 = 0,C2,C3,C4,C5,C6,C7,C8,C9,Cmsgl,Cmsgr,Cred,Ctabn,Ctabh
};

typedef NS_ENUM(NSInteger, LNThemeFontType) {
    F1 = 6,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16
};

typedef NS_ENUM(NSInteger, LNThemeImageInsetsType) {
    TabBarItemImageViewH = 0,
    TabBarItemImageViewN,
    TabBarItemTextViewH,
    TabBarItemTextViewN
};

typedef NS_ENUM(NSInteger, LNThemePickerType) {
    ThemePicker = 0,
    ThemeStatePicker,
    ThemeCGColorPicker,
    ThemeCGFloatPicker,
    ThemeEdgeInsetPicker,
    ThemeStatusBarPicker
};

typedef id (^LNThemePickerBlock)();
@interface LNThemePicker : NSObject
@property (copy, nonatomic) LNThemePickerBlock block;
@property (assign, nonatomic) LNThemePickerType type;
@property (assign, nonatomic) UIControlState valueState;

#pragma mark - ThemePicker
+ (instancetype)initWithColorType:(LNThemeColorType)type;
+ (instancetype)initWithImageName:(NSString *)name;
+ (instancetype)initWithImageName:(NSString *)name renderingMode:(UIImageRenderingMode)mode;
+ (instancetype)initTextAttributesColorType:(LNThemeColorType)color font:(LNThemeFontType)font;

#pragma mark - ThemeStatePicker
+ (instancetype)initWithImageName:(NSString *)name forState:(UIControlState)state;
+ (instancetype)initWithImageName:(NSString *)name forBarMetrics:(UIBarMetrics)state;
+ (instancetype)initWithColorType:(LNThemeColorType)type forState:(UIControlState)state;
+ (instancetype)initTextAttributesColorType:(LNThemeColorType)color font:(LNThemeFontType)font forState:(UIControlState)state;

#pragma mark - ThemeCGColorPicker
+ (instancetype)initWithCGColor:(LNThemeColorType)type;

#pragma mark - ThemeCGFloatPicker
+ (instancetype)initWithCGFloat:(CGFloat)num;

#pragma mark - ThemeEdgeInsetPicker
+ (instancetype)initWithImageInsets:(LNThemeImageInsetsType)type;

#pragma mark - ThemeStatusBarPicker
+ (instancetype)initWithStatusBarAnimated:(BOOL)animated;
@end
