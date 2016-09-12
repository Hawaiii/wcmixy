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
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    videoCamera = [[CvVideoCamera alloc] initWithParentView:cameraView];
    videoCamera.delegate = self;
    
    videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset1280x720;
    videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationLandscapeRight;
    videoCamera.defaultFPS = 30;
//    videoCamera.grayscale = NO;
    
    [videoCamera start];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#ifdef __cplusplus
- (void)processImage:(Mat&)image;
{
    
//    UIImage *imshow = MatToUIImage(image);
//    Mat image_copy;
//    cvtColor(image, image_copy, CV_BGRA2BGR);
//    
//    // invert image
//    bitwise_not(image_copy, image_copy);
//    cvtColor(image_copy, image, CV_BGR2BGRA);
}
#endif
@end
