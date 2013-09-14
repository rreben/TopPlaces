//
//  PhotoViewController.h
//  TopPlaces
//
//  Created by Rupert Rebentisch on 26.08.13.
//  Copyright (c) 2013 Rupert Rebentisch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController
@property NSDictionary * photo;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end
