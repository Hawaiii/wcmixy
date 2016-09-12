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

@interface ViewController : UIViewController<CvVideoCameraDelegate>


@end

