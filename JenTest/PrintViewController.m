//
//  PrintViewController.m
//  JenTest
//
//  Created by lijia on 2021/10/21.
//  Copyright © 2021 MJHF. All rights reserved.
//

#import "PrintViewController.h"

@interface PrintViewController ()

@end

@implementation PrintViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPixelColor];
}

static bool isYellowColor(NSInteger red, NSInteger green, NSInteger blue) {
    BOOL ret = (red == 255 && green == 228 && blue < 20);
    return ret;
}

static bool isPinkColor(NSInteger red, NSInteger green, NSInteger blue) {
    BOOL ret = (red > 250 && green > 80 && blue > 190);
    return ret;
}

- (void)getPixelColor {
    UIImage *image = [UIImage imageNamed:@"icon"];
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    int step = 20;
    for (int y = step; y < height - step; ++y) {
        for (int x = 0; x < width; ++x) {
            NSUInteger byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
            CGFloat alpha = ((CGFloat) rawData[byteIndex + 3] ) / 255.0f;
            CGFloat red   = ((CGFloat) rawData[byteIndex]     ) / alpha;
            CGFloat green = ((CGFloat) rawData[byteIndex + 1] ) / alpha;
            CGFloat blue  = ((CGFloat) rawData[byteIndex + 2] ) / alpha;
            //            UInt8 alpha = data[pixelInfo + 3];
            
            if (isPinkColor(red, green, blue)) {
                printf("h");
                continue;
            }
            
            if (isYellowColor(red, green, blue)) {
                //                printf("(%i, %i, %i)", (int)red, (int)green, (int)blue);
                printf("j");
                continue;
            }
//            printf("(%i, %i, %i)", (int)red, (int)green, (int)blue);
            printf("0");
        }
        printf("\n");
    }
}

@end
