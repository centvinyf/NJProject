//
//  MoreViewController.h
//  MagicBeans-Demo
//
//  Created by Magic Beans on 14/12/11.
//  Copyright (c) 2014年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    UIImageView *imageView;
}
@property (weak, nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *mFontButton;
@property (weak, nonatomic) IBOutlet UIWebView *mWebView;
@property (weak, nonatomic) IBOutlet UIView *mFontSetView;
@property (weak, nonatomic) IBOutlet UIPickerView *mPickerView;
@property (strong, nonatomic) NSArray *textArray;  

@end