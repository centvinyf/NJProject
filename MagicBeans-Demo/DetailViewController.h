//
//  MoreViewController.h
//  MagicBeans-Demo
//
//  Created by Magic Beans on 14/12/11.
//  Copyright (c) 2014年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UIGestureRecognizerDelegate,UITextViewDelegate>
{
    UIImageView *imageView;
    NSString * mComment;
}

@property (weak, nonatomic) IBOutlet UIButton *FontSetButton;

@property (weak, nonatomic) IBOutlet UIWebView *mWebView;

@property (retain, nonatomic) NSString * currenFont;
@property (weak, nonatomic) IBOutlet UIView *FengeView;
@property (weak, nonatomic) IBOutlet UIButton *SmallButton;
@property (weak, nonatomic) IBOutlet UIButton *MidButton;
@property (weak, nonatomic) IBOutlet UIButton *BigButton;
@property (weak, nonatomic) IBOutlet UIView *mToolBarView;
@property (weak, nonatomic) IBOutlet UIView *mTextViewContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mYLocationConstraint;
@property (weak, nonatomic) IBOutlet UITextView *mTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mTextFieldHeightConstraint;

@end