//
//  MADImageDataSource.m
//  MADButtons
//
//  Created by Brad Zeis on 2/25/14.
//  Copyright (c) 2014 MAD. All rights reserved.
//

#import "MADImageDataSource.h"

@implementation MADImageDataSource

+ (MADImageType)imageTypeForTitle:(NSString *)title
{
    if ([title isEqualToString:@"Feline"]) {
        return MADImageTypeFeline;
    } else if ([title isEqualToString:@"Canine"]) {
        return MADImageTypeCanine;
    }
    return MADImageTypeOther;
}

+ (UIImage *)imageWithImageType:(MADImageType)imageType
{
    NSString *type;
    if (imageType == MADImageTypeFeline) {
        type = @"feline";
    } else if (imageType == MADImageTypeCanine) {
        type = @"canine";
    } else {
        type = @"other";
    }
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@-%ld.jpg", type, (long)arc4random_uniform(3) + 1]];
}

+ (UIImage *)grayScaleImage:(UIImage *)image
{
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // Grayscale color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    
    // Draw image into current context, with specified rectangle
    // using previously defined context (with grayscale colorspace)
    CGContextDrawImage(context, imageRect, [image CGImage]);
    
    // Create bitmap image info from pixel data in current context
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // Create a new UIImage object
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    
    // Release colorspace, context and bitmap information
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    
    // Return the new grayscale image
    return newImage;
}

@end
