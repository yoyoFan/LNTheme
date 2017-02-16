//
//  LNTheme.h
//  GoldUISSFramework
//
//  Created by vvusu on 12/30/16.
//  Copyright © 2016 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+LNTheme.h"

@interface LNTheme : NSObject
@property (nonatomic, strong, readonly) NSString *currentTheme;
@property (nonatomic, strong, readonly) NSDictionary *currentThemeDic;

+ (instancetype)instance;
+ (void)changeTheme:(NSString *)themeName;
+ (UIImage *)imageNamed:(NSString *)name;
+ (UIFont *)fontForType:(NSString *)type;
+ (UIColor *)colorForType:(NSString *)type;
+ (NSValue *)imageInsetsForType:(NSString *)type;
@end
