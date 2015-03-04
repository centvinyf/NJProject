//
//  MoreViewController.h
//  MagicBeans-Demo
//
//  Created by Magic Beans on 14/12/11.
//  Copyright (c) 2014年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface DetailViewController : UIViewController<UIGestureRecognizerDelegate,UITextViewDelegate,UIWebViewDelegate>
{
    UIImageView *imageView;
    float currentFontSize;
    
}
@property (weak, nonatomic) IBOutlet UILabel *mOtherLabel;
@property (weak, nonatomic) IBOutlet UILabel *mSubTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mMainTitleLabel;
@property(weak,nonatomic) NSString *CommentNum;
@property (weak, nonatomic) IBOutlet UIButton *FontSetButton;
@property (weak, nonatomic) IBOutlet UIWebView *mWebView;
@property (retain, nonatomic) NSString * currenFont;
@property (weak,nonatomic) NSString * ArticleURL;
@property (weak, nonatomic) IBOutlet UIView *FengeView;
@property (weak, nonatomic) IBOutlet UIButton *SmallButton;
@property (weak, nonatomic) IBOutlet UIButton *MidButton;
@property (weak, nonatomic) IBOutlet UIButton *BigButton;
@property (weak, nonatomic) IBOutlet UIView *mToolBarView;
@property (weak, nonatomic) IBOutlet UIView *mTextViewContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mYLocationConstraint;
@property (weak, nonatomic) IBOutlet UITextView *mTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mTextFieldHeightConstraint;
@property (retain, nonatomic) NSString *mArticleID;
@property(assign, nonatomic) BOOL isPraised;
@property (weak, nonatomic) IBOutlet UIButton *mPraiseBtn;
@property (retain, nonatomic) NSString *articleTitle;
@property (retain,nonatomic) NSString *mAuthor;
@property (retain,nonatomic) NSString *mArticleDate;
@property(retain,nonatomic) NSString *mSubTitle;
@end