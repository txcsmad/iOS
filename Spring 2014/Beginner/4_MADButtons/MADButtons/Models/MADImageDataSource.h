//
//  MADImageDataSource.h
//  MADButtons
//
//  Created by Brad Zeis on 2/25/14.
//  Copyright (c) 2014 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MADImageType) {
    MADImageTypeFeline,
    MADImageTypeCanine,
    MADImageTypeOther
};

@interface MADImageDataSource : NSObject

+ (MADImageType)imageTypeForTitle:(NSString *)title;
+ (UIImage *)imageWithImageType:(MADImageType)imageType;
+ (UIImage *)grayScaleImage:(UIImage *)image;

@end
