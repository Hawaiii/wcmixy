//
//  ViewController.m
//  wcmixy
//
//  Created by Yi Hua on 9/11/16.
//  Copyright © 2016 Yi Hua. All rights reserved.
//

#import "ViewController.h"
#include <stdlib.h>
#include <iostream>
using namespace std;
using namespace cv;

@interface ViewController () {
    CvVideoCamera *videoCamera;
    IBOutlet UIImageView *cameraView;
    IBOutlet UIImageView *value0View;
    IBOutlet UIView *hue0View;
    IBOutlet UIView *saturation0View;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    videoCamera = [[CvVideoCamera alloc] initWithParentView:cameraView];
    videoCamera.delegate = self;
    videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationLandscapeLeft;
    videoCamera.defaultFPS = 30;
    videoCamera.rotateVideo = YES; // Rotate video so everything looks correct
    
    // TODO: test video orientatio setup
    videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
    
    [videoCamera start];
    
    window_half = 15;
    line_width = 2;
    camera_width = 640;
    camera_height = 480;
    view_width = self.view.frame.size.width;
    view_height = self.view.frame.size.height;
    
    // TODO: update p0r, p0g, p0b with selected area
    p0r = 20;
    p0g = 255;
    p0b = 25;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch began");
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches moved");
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    p0x = float(pt.x);
    p0y = float(pt.y);
    
    NSLog(@"touch ended at (%f, %f)", p0x, p0y);
    
}

//- (void) selectWindow:(CGPoint *)selection) {
//    point0 = selection;
//}


#ifdef __cplusplus

void rgb2hsv(uint r, uint g, uint b, float *H, float *S, float *V){
    float rgb_min = float(min( min(r, g) , b))/255.0f;
    float rgb_max = float(max( max(r, g), b))/255.0f;
    
    *V = rgb_max;
    float delta = rgb_max - rgb_min;
    if (rgb_max != 0){
        *S = delta / rgb_max;
        if (r >= g && r >= b){
            *H = float(g - b)/255.0f / delta;
        } else if (g >= r && g >= b){
            *H = 2.0f + float(b - r)/255.0f / delta;
        } else {
            *H = 4.0f + float(r - b)/255.0f / delta;
        }
        *H *= 60; // degrees
        if (*H < 0) *H += 360;
        *H /= 360.0f;
    } else {
        *S = 0.0f;
        *H = -1.0f;
    }
}

float scaleViewToCamera(float pos) {
//    float scale_factor = 1.0 * camera_width / view_width;
//    float scale_factor_height = 1.0 * camera_height / view_height;
//    cout << "sf: " << scale_factor << " sfh: " <<  scale_factor_height << endl;
//    return pos * scale_factor;
    cout << "TODO:" << endl;
    return pos;
}

- (void)processImage:(Mat&)image;
{
    
    // Draw square around point 0
    cv::Point upper_left (p0x-window_half, p0y-window_half);
    cv::Point lower_right (p0x+window_half, p0y+window_half);
    
    cv::rectangle(image, upper_left, lower_right, cv::Scalar(255,0,0), line_width);
    
//    UIImage *imshow = MatToUIImage(image);
//    Mat image_copy;
//    cvtColor(image, image_copy, CV_BGRA2BGR);
//    
//    // invert image
//    bitwise_not(image_copy, image_copy);
//    cvtColor(image_copy, image, CV_BGR2BGRA);
    
    // Update value, hue, saturation based on selection
    // RGB to HSB
    float h, s, v;
    rgb2hsv(p0r, p0g, p0b, &h, &s, &v);
    
    UIColor *valColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:v alpha:1.0];
    value0View.backgroundColor = valColor;
//    CGRect rect = CGRectMake(0, 0, value0View.frame.size.width, value0View.frame.size.height);
//    UIGraphicsBeginImageContextWithOptions(value0View.frame.size, false, 0);
//    CGColorRef valColor_ = [valColor CGColor];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, valColor_);
//    CGContextFillPath(context);
//    value0View.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    
    
    UIColor *hueColor = [UIColor colorWithHue:h saturation:1.0f brightness:0.5f alpha:1.0];
//    [hue0View setBackgroundColor:hueColor];
    hue0View.backgroundColor = hueColor;
    
    UIColor *saturationColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:s alpha:1.0];
//    [saturation0View setBackgroundColor:saturationColor];
    saturation0View.backgroundColor = saturationColor;
    [saturation0View setNeedsDisplay];
    cout << "saturation0View.backgroundColor:" << saturation0View.backgroundColor << endl;
    
}
#endif
@end
