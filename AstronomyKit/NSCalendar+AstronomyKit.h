//
//  NSCalendar+AstronomyKit.h
//  Watchville
//
//  Created by Caleb Davenport on 2/9/15.
//  Copyright (c) 2015 North Technologies, Inc. All rights reserved.
//

#if defined(__has_feature) && __has_feature(objc_modules)
    @import Foundation;
#else
    #import <Foundation/Foundation.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface NSCalendar (AstronomyKit)

+ (instancetype)AstronomyKitGregorianCalendar;

@end

NS_ASSUME_NONNULL_END
