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

@interface UITextField (LNTheme)
- (void)ln_textColor:(LNThemeColorType)type;
@end

@interface UITextView (LNTheme)
- (void)ln_textColor:(LNThemeColorType)type;
@end

@interface UISlider (LNTheme)
- (void)ln_thumbTintColor:(LNThemeColorType)type;
- (void)ln_minimumTrackTintColor:(LNThemeColorType)type;
- (void)ln_maximumTrackTintColor:(LNThemeColorType)type;
@end

@interface UISwitch (LNTheme)
- (void)ln_onTintColor:(LNThemeColorType)type;
- (void)ln_thumbTintColor:(LNThemeColorType)type;
@end

@interface UIProgressView (LNTheme)
- (void)ln_trackTintColor:(LNThemeColorType)type;
- (void)ln_progressTintColor:(LNThemeColorType)type;
@end

@interface UIPageControl (LNTheme)
- (void)ln_pageIndicatorTintColor:(LNThemeColorType)type;
- (void)ln_currentPageIndicatorTintColor:(LNThemeColorType)type;
@end

@interface UISearchBar (LNTheme)
- (void)ln_barTintColor:(LNThemeColorType)type;
@end


