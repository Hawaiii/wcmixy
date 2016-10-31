//
//  ViewController.h
//  wcmixy
//
//  Created by Yi Hua on 9/11/16.
//  Copyright © 2016 Yi Hua. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#import "opencv2/highgui/ios.h"
#endif

@interface ViewController : UIViewController<CvVideoCameraDelegate> {
//    CGPoint point0;
//    CGPoint point1;
    float p0x;
    float p0y;
    uint p0r;
    uint p0g;
    uint p0b;
    float p1x;
    float p1y;
    
    
    float window_half;
    int line_width;
    int camera_width;
    int camera_height;
    int view_width;
    int view_height;
}

//- (float) scaleViewToCamera:(float)pos;

#ifdef __cplusplus
void rgb2hsv(uint r, uint g, uint b, float *H, float *S, float *V);
#endif

@end

