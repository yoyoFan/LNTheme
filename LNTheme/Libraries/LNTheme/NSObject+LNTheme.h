//
//  NSObject+LNTheme.h
//  GoldUISSFramework
//
//  Created by vvusu on 1/16/17.
//  Copyright © 2017 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>

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
- (void)ln_tinyColor:(NSString *)type;
- (void)ln_backgroundColor:(NSString *)type;
@end

@interface UITabBar (LNTheme)
- (void)ln_barTinyColor:(NSString *)type;
- (void)ln_backgroundImageNamed:(NSString *)name;
@end

@interface UITabBarItem (LNTheme)
- (void)ln_imageInsets:(NSString *)type;
- (void)ln_imageNamed:(NSString *)name renderingMode:(UIImageRenderingMode)mode;
- (void)ln_selectedImageNamed:(NSString *)name renderingMode:(UIImageRenderingMode)mode;
- (void)ln_titleTextAttributesColorType:(NSString *)colorType font:(NSString *)fontType forState:(UIControlState)state;
@end

@interface UINavigationBar (LNTheme)
- (void)ln_barTinyColor:(NSString *)type;
- (void)ln_backgroundImageNamed:(NSString *)name forBarMetrics:(UIBarMetrics)state;
- (void)ln_titleTextAttributesColorType:(NSString *)colorType font:(NSString *)fontType;
@end

@interface UIBarButtonItem (LNTheme)
- (void)ln_tinyColor:(NSString *)type;
@end

@interface UILabel (LNTheme)
- (void)ln_textColor:(NSString *)type;
- (void)ln_shadowColor:(NSString *)type;
- (void)ln_highlightedTextColor:(NSString *)type;
@end

@interface UIButton (LNTheme)
- (void)ln_imageNamed:(NSString *)name forState:(UIControlState)state;
- (void)ln_backgroundImageNamed:(NSString *)name forState:(UIControlState)state;
- (void)theme_titleColor:(NSString *)type forState:(UIControlState)state;
@end

@interface UIImageView (LNTheme)
- (void)ln_imageNamed:(NSString *)name;
@end

@interface CALayer (LNTheme)
- (void)ln_borderColor:(NSString *)type;
- (void)ln_shadowColor:(NSString *)type;
- (void)ln_backgroundColor:(NSString *)type;
@end

@interface UITextField (LNTheme)
- (void)ln_textColor:(NSString *)type;
@end

@interface UITextView (LNTheme)
- (void)ln_textColor:(NSString *)type;
@end

@interface UISlider (LNTheme)
- (void)ln_thumbTintColor:(NSString *)type;
- (void)ln_minimumTrackTintColor:(NSString *)type;
- (void)ln_maximumTrackTintColor:(NSString *)type;
@end

@interface UISwitch (LNTheme)
- (void)ln_onTintColor:(NSString *)type;
- (void)ln_thumbTintColor:(NSString *)type;
@end

@interface UIProgressView (LNTheme)
- (void)ln_trackTintColor:(NSString *)type;
- (void)ln_progressTintColor:(NSString *)type;
@end

@interface UIPageControl (LNTheme)
- (void)ln_pageIndicatorTintColor:(NSString *)type;
- (void)ln_currentPageIndicatorTintColor:(NSString *)type;
@end

@interface UISearchBar (LNTheme)
- (void)ln_barTintColor:(NSString *)type;
@end
