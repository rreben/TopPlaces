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
    [self.photoView setImage:img];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
