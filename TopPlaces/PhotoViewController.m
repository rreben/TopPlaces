//
//  PhotoViewController.m
//  TopPlaces
//
//  Created by Rupert Rebentisch on 26.08.13.
//  Copyright (c) 2013 Rupert Rebentisch. All rights reserved.
//

#import "PhotoViewController.h"
#import "FlickrFetcher.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController
@synthesize photo = _photo;
@synthesize photoView = _photoView;
@synthesize scrollView = _scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSURL * urlForPhoto = [FlickrFetcher urlForPhoto:self.photo format:FlickrPhotoFormatOriginal];
//    UIImage * img = [[UIImage alloc] imageWithData:[NSData dataWithContentsOfURL:urlForPhoto]];
    UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:urlForPhoto]];
//    NSLog(@"scale: %f",[self calculateScaleForImage:img]);
//    [self.photoView setImage:img];
    CGSize modSize = img.size;
    double scale = [self calculateScaleForImage:img];
    modSize.height = scale * modSize.height;
    modSize.width = scale * modSize.width;
    NSLog(@"%f", scale);
  //  [self.photoView set]
    self.photoView.contentMode = UIViewContentModeTopLeft;
    [self.photoView setImage:[self imageWithImage:img convertToSize:modSize]];
    self.scrollView.minimumZoomScale = 0.5; // 0.5 means half its normal size
    self.scrollView.maximumZoomScale = 2.0; // 2.0 means twice its normal size
    self.scrollView.contentSize = self.photoView.bounds.size;
    [self.scrollView addSubview:self.photoView];
}

//If your scroll view only has one subview, you return it here. More than one? Up to you.
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)sender{
    return self.photoView;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

- (double)calculateScaleForImage:(UIImage *)image{
    double horizontalScale = self.view.bounds.size.width /  image.size.width;
    double verticalScale = self.view.bounds.size.height / image.size.height;
    return MIN(horizontalScale, verticalScale);
}


@end
