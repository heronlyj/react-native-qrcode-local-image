//
//  RCTQRCodeLocalImage.m
//  RCTQRCodeLocalImage
//
//  Created by fangyunjiang on 15/11/4.
//  Copyright (c) 2015年 remobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTLog.h>
#import <React/RCTUtils.h>
#import "RCTQRCodeLocalImage.h"

@implementation RCTQRCodeLocalImage
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(decode:(NSString *)path callback:(RCTResponseSenderBlock)callback)
{
    UIImage *srcImage;
    if ([path hasPrefix:@"http://"] || [path hasPrefix:@"https://"]) {
        srcImage = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString: path]]];
    } else {
        srcImage = [[UIImage alloc] initWithContentsOfFile:path];
    }
    if (srcImage == NULL) {
        NSLog(@"PROBLEM! IMAGE NOT LOADED\n");
        callback(@[RCTMakeError(@"IMAGE NOT LOADED!", nil, nil)]);
    } else {
        [self detectImage:srcImage callback:callback];
    }
}

RCT_EXPORT_METHOD(decodeBase64String:(NSString *)dataString callback:(RCTResponseSenderBlock)callback)
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:dataString options:0];
    UIImage *image = [[UIImage alloc] initWithData:data];
    
    if (image == NULL) {
        NSLog(@"PROBLEM! IMAGE NOT LOADED\n");
        callback(@[RCTMakeError(@"IMAGE NOT LOADED!", nil, nil)]);
    } else {
        [self detectImage:image callback:callback];
    }
}

- (void)detectImage:(UIImage*)srcImage callback:(RCTResponseSenderBlock)callback {
    
    NSLog(@"OK - IMAGE LOADED\n");
    
    NSDictionary *detectorOptions = @{@"CIDetectorAccuracy": @"CIDetectorAccuracyHigh"};
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:detectorOptions];
    CIImage *image = [CIImage imageWithCGImage:srcImage.CGImage];
    NSArray *features = [detector featuresInImage:image];
    
    if (0 == features.count) {
        NSLog(@"PROBLEM! Feature size is zero!\n");
        callback(@[RCTMakeError(@"Feature size is zero!", nil, nil)]);
        return;
    }
    
    CIQRCodeFeature *feature = [features firstObject];
    
    NSString *result = feature.messageString;
    NSLog(@"result: %@", result);
    
    if (result) {
        callback(@[[NSNull null], result]);
    } else {
        callback(@[RCTMakeError(@"QR Parse failed!", nil, nil)]);
    }
    
}



@end
