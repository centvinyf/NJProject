//
//  MoreViewController.m
//  MagicBeans-Demo
//
//  Created by Magic Beans on 14/12/11.
//  Copyright (c) 2014年 Magic Beans. All rights reserved.
//

#import "DetailViewController.h"
#import "AFNetworking.h"
#import "CommentViewController.h"

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
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = YES;
    [self initNotifications];
    [self initViews];
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

- (void)initViews
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 20)];
    [button setBackgroundImage:[UIImage imageNamed:@"看评论BG"] forState:UIControlStateNormal];
    [button setTitle:@"312条评论" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showCommentsList:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

#pragma mark- setFonts
-(void)RefreshStatus
{
    self.BigButton.selected = NO;
    self.MidButton.selected = NO;
    self.SmallButton.selected = NO;
}

- (IBAction)FontSetButtonPressed:(id)sender {
    ((UIButton *)sender).selected = !((UIButton *)sender).selected;
    self.FengeView.hidden = !self.FengeView.isHidden;
}

- (IBAction)BigFontButtonPressed:(id)sender {
    [self RefreshStatus];
    self.BigButton.selected = !self.BigButton.selected;
    self.FontSetButton.selected = NO;
    self.FengeView.hidden = YES;
    self.currenFont = @"Big";
}

- (IBAction)MidFontButtonPressed:(id)sender {
    [self RefreshStatus];
    self.MidButton.selected = !self.MidButton.selected;
    self.FontSetButton.selected = NO;
    self.FengeView.hidden = YES;
    self.currenFont = @"Mid";
}

- (IBAction)SmallFontButtonPressed:(id)sender {
    [self RefreshStatus];
    self.SmallButton.selected = !self.SmallButton.selected;
    self.FontSetButton.selected = NO;
    self.FengeView.hidden = YES;
    self.currenFont = @"Small";
}

- (IBAction)CommentButtonPressed:(id)sender {
    [self.mTextField becomeFirstResponder];
}

- (IBAction)showCommentsList:(id)sender {
    [self performSegueWithIdentifier:@"CommentViewController" sender:self.mArticleID];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CommentViewController *commentViewController = [segue destinationViewController];
    commentViewController.mArticleID = sender;
}

- (IBAction)praiseArticle:(id)sender {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"articleId":self.mArticleID,
                                 @"sn":[def stringForKey:@"UUID"],
                                 @"status":self.mPraiseBtn.selected ? @"0":@"1"};
    [mgr GET:@"http://192.168.1.113:8081/nj_app/app/setArticlePraiseState.do" parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         BOOL succeed = [responseObject[@"state"] boolValue];
         if (succeed) {
             ((UIButton *)sender).selected = !((UIButton *)sender).selected;
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"操作成功，谢谢！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alertView show];
         }
         else
         {
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"操作失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alertView show];
         }
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alertView show];
         });
     }];
}
#pragma mark- textfield

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self postComment:textView.text];
        return NO;
    }
    
    CGRect rect = [textView.text boundingRectWithSize:CGSizeMake(textView.contentSize.width - 8, 0)
                                              options:NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                   
                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                              context:NULL];
    
    self.mTextFieldHeightConstraint.constant = rect.size.height > 30 ? rect.size.height + 16 : 30;

    return YES;
}

- (void)postComment:(NSString *)comment
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"articleId":self.mArticleID,
                                 @"content":comment,
                                 @"ip":@"101.204.29.120"};
    [mgr GET:@"http://192.168.1.113:8081/nj_app/app/setArticleCommont.do" parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         BOOL succeed = [responseObject[@"state"] boolValue];
         if (succeed) {
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"评论成功，谢谢！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alertView show];
         }
         else
         {
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"评论失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alertView show];
         }
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alertView show];
         });
     }];

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