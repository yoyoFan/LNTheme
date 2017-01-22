//
//  NSObject+LNTheme.h
//  GoldUISSFramework
//
//  Created by vvusu on 1/16/17.
//  Copyright © 2017 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LNThemePicker.h"

@interface NSObject (LNTheme)
@property (strong, nonatomic)NSMutableDictionary *themePickers;
- (void)updateTheme;

@end

@interface UIColor (LNTheme)
+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end

@interface UIApplication (LNTheme)
- (void)ln_setStatusBarAnimated:(BOOL)animated;

@end

@interface UIView (LNTheme)
- (void)ln_tinyColor:(LNThemeColorType)type;
- (void)ln_backgroundColor:(LNThemeColorType)type;

@end

@interface UITabBar (LNTheme)
- (void)ln_barTinyColor:(LNThemeColorType)type;
- (void)ln_backgroundImageNamed:(NSString *)name;

@end

@interface UITabBarItem (LNTheme)
- (void)ln_imageInsets:(LNThemeImageInsetsType)type;
- (void)ln_titleTextAttributes:(LNThemePicker *)picker;
- (void)ln_imageNamed:(NSString *)name renderingMode:(UIImageRenderingMode)mode;
- (void)ln_selectedImageNamed:(NSString *)name renderingMode:(UIImageRenderingMode)mode;

@end

@interface UINavigationBar (LNTheme)
- (void)ln_barTinyColor:(LNThemeColorType)type;
- (void)ln_titleTextAttributes:(LNThemePicker *)picker;
- (void)ln_backgroundImageNamed:(NSString *)name forBarMetrics:(UIBarMetrics)state;

@end

@interface UIBarButtonItem (LNTheme)
- (void)ln_tinyColor:(LNThemeColorType)type;

@end

@interface UILabel (LNTheme)
- (void)ln_textColor:(LNThemeColorType)type;
- (void)ln_shadowColor:(LNThemeColorType)type;
- (void)ln_highlightedTextColor:(LNThemeColorType)type;

@end

@interface UIButton (LNTheme)
- (void)ln_imageNamed:(NSString *)name forState:(UIControlState)state;
- (void)ln_backgroundImageNamed:(NSString *)name forState:(UIControlState)state;
- (void)theme_titleColor:(LNThemeColorType)type forState:(UIControlState)state;

@end

@interface UIImageView (LNTheme)
- (void)ln_imageNamed:(NSString *)name;

@end

@interface CALayer (LNTheme)
- (void)ln_borderColor:(LNThemeColorType)type;
- (void)ln_shadowColor:(LNThemeColorType)type;
- (void)ln_backgroundColor:(LNThemeColorType)type;
@end
