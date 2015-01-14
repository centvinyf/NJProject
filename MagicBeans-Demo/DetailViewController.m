//
//  MoreViewController.m
//  MagicBeans-Demo
//
//  Created by Magic Beans on 14/12/11.
//  Copyright (c) 2014年 Magic Beans. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad
{
    self.FengeView.hidden = YES;
    self.SmallButton.hidden = YES;
    self.MidButton.hidden = YES;
    self.BigButton.hidden = YES;
    self.mToolBarView.hidden = YES;
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = YES;

    [self initNotifications];
}

- (void)initNotifications
{
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSDictionary *dic =  note.userInfo;
        CGSize kbSize=[[dic objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
        self.mYLocationConstraint.constant = kbSize.height;
        self.mTextViewContainer.hidden = NO;
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        self.mTextField.text = @"";
        self.mTextFieldHeightConstraint.constant = 30;
        self.mTextViewContainer.hidden = YES;
    }];
}

#pragma mark- setFonts
-(void)RefreshStatus
{
    [self.BigButton setImage:[UIImage imageNamed:@"大未选中.png"] forState:UIControlStateNormal];
    [self.MidButton setImage:[UIImage imageNamed:@"中未选中.png"] forState:UIControlStateNormal];
    [self.SmallButton setImage:[UIImage imageNamed:@"小未选中.png"] forState:UIControlStateNormal];
}

- (IBAction)FontSetButtonPressed:(id)sender {
    self.FengeView.hidden = !self.FengeView.isHidden;
    self.SmallButton.hidden = !self.SmallButton.isHidden;
    self.MidButton.hidden = !self.MidButton.isHidden;
    self.BigButton.hidden = !self.BigButton.isHidden;
}

- (IBAction)BigFontButtonPressed:(id)sender {
    [self RefreshStatus];
    [self.BigButton setImage:[UIImage imageNamed:@"大选中.png"] forState:UIControlStateNormal];
    self.FengeView.hidden = YES;
    self.SmallButton.hidden = YES;
    self.MidButton.hidden = YES;
    self.BigButton.hidden = YES;
    self.currenFont = @"Big";
}

- (IBAction)MidFontButtonPressed:(id)sender {
    [self RefreshStatus];
    [self.MidButton setImage:[UIImage imageNamed:@"中选中.png"] forState:UIControlStateNormal];
    self.FengeView.hidden = YES;
    self.SmallButton.hidden = YES;
    self.MidButton.hidden = YES;
    self.BigButton.hidden = YES;
    self.currenFont = @"Mid";
}

- (IBAction)SmallFontButtonPressed:(id)sender {
    [self RefreshStatus];
    [self.SmallButton setImage:[UIImage imageNamed:@"小选中.png"] forState:UIControlStateNormal];
    self.FengeView.hidden = YES;
    self.SmallButton.hidden = YES;
    self.MidButton.hidden = YES;
    self.BigButton.hidden = YES;
    self.currenFont = @"Small";
}

- (IBAction)CommentButtonPressed:(id)sender {
    [self.mTextField becomeFirstResponder];
}

#pragma mark- textfield

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        mComment = textView.text;
        return NO;
    }
    
    CGRect rect = [textView.text boundingRectWithSize:CGSizeMake(textView.contentSize.width - 8, 0)
                                              options:NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                   
                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                              context:NULL];
    
    self.mTextFieldHeightConstraint.constant = rect.size.height > 30 ? rect.size.height + 16 : 30;

    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer

{
    return YES;
}


-(void)handleSingleTap:(UITapGestureRecognizer *)sender

{
    CGPoint point = [sender locationInView:self.view];
    if (point.y<= self.mToolBarView.frame.origin.y
        ) {
        [self.mToolBarView setHidden:!self.mToolBarView.isHidden];
    }
    else self.mToolBarView.hidden= NO;
    [self.mTextField resignFirstResponder];
}

@end