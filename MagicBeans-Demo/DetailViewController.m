//
//  MoreViewController.m
//  MagicBeans-Demo
//
//  Created by Magic Beans on 14/12/11.
//  Copyright (c) 2014年 Magic Beans. All rights reserved.
//

#import "DetailViewController.h"
#import "HttpJsonManager.h"
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
    currentFontSize = 15;
    [self geturl];
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
    [button setTitle:[NSString stringWithFormat:@"%@条评论",self.CommentNum] forState:UIControlStateNormal];
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
    [self.mWebView stringByEvaluatingJavaScriptFromString:@"var str =  document.getElementById(\"ueditor_0\").contentDocument.getElementsByTagName(\"p\"),strLength =str.length;for (var i=0;i<strLength;i++){str[i].style.fontSize = \"30px\";}"];
    currentFontSize = 30;
}

- (IBAction)MidFontButtonPressed:(id)sender {
    [self RefreshStatus];
    self.MidButton.selected = !self.MidButton.selected;
    self.FontSetButton.selected = NO;
    self.FengeView.hidden = YES;
    self.currenFont = @"Mid";
    [self.mWebView stringByEvaluatingJavaScriptFromString:@"var str =  document.getElementById(\"ueditor_0\").contentDocument.getElementsByTagName(\"p\"),strLength =str.length;for (var i=0;i<strLength;i++){str[i].style.fontSize = \"20px\";}"];
    currentFontSize = 20;
}

- (IBAction)SmallFontButtonPressed:(id)sender {
    [self RefreshStatus];
    self.SmallButton.selected = !self.SmallButton.selected;
    self.FontSetButton.selected = NO;
    self.FengeView.hidden = YES;
    self.currenFont = @"Small";
    [self.mWebView stringByEvaluatingJavaScriptFromString:@"var str =  document.getElementById(\"ueditor_0\").contentDocument.getElementsByTagName(\"p\"),strLength =str.length;for (var i=0;i<strLength;i++){str[i].style.fontSize = \"15px\";}"];
    currentFontSize = 15;
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
    NSDictionary *parameters = @{@"articleId":self.mArticleID,
                                 @"sn":[def stringForKey:@"UUID"],
                                 @"status":self.mPraiseBtn.selected ? @"0":@"1"};
    [HttpJsonManager getWithParameters:parameters sender:self url:@"http://182.92.183.22:8080/nj_app/app/setArticlePraiseState.do" completionHandler:^(BOOL sucess, id content) {
        if (sucess) {
            BOOL succeed = [content[@"state"] boolValue];
            if (succeed) {
                ((UIButton *)sender).selected = !((UIButton *)sender).selected;
                if(((UIButton *)sender).selected)
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"点赞成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alertView show];
                }
                else
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"已取消点赞" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alertView show];
                }
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"操作失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            }
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            });

        }
    }];
}

- (IBAction)shareContent:(id)sender {
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"我是分享内容！"] applicationActivities:nil];
    __weak UIActivityViewController *weakActivityViewController = activityViewController;
    [activityViewController setCompletionHandler:^(NSString *activityType,BOOL completed)
    {
        if (completed)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"分享成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
        else
        {
            NSLog(@"cancel");
        }
        
        [weakActivityViewController dismissViewControllerAnimated:YES completion:nil];
    }];
    [self presentViewController:activityViewController animated:YES completion:nil];
}
#pragma mark- textfield

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if([self.mTextField.text isEqualToString:@""]){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"评论不能为空！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return NO;

        }else{
            
            [self postComment:textView.text];
            [textView resignFirstResponder];
        return NO;
        }
        
        
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
    NSDictionary *parameters = @{@"articleId":self.mArticleID,
                                 @"content":comment,
                                 @"ip":@"101.204.29.120"};
    [HttpJsonManager getWithParameters:parameters sender:self url:@"http://182.92.183.22:8080/nj_app/app/setArticleCommont.do" completionHandler:^(BOOL sucess, id content) {
        if (sucess) {
            BOOL succeed = [content[@"state"] boolValue];
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
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            });
        }
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer

{
    return YES;
}


-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.view];
    if (point.y<= self.mToolBarView.frame.origin.y)
    {
        [self.mToolBarView setHidden:!self.mToolBarView.isHidden];
    }
    else self.mToolBarView.hidden= NO;
    [self.mTextField resignFirstResponder];
}

- (IBAction)handPinch:(UIPinchGestureRecognizer *)sender
{
    if (sender.scale > 1) {
        currentFontSize +=1;
    }
    else
    {
        currentFontSize -=1;
    }
    [self.mWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"var str =  document.getElementById(\"ueditor_0\").contentDocument.getElementsByTagName(\"p\"),strLength =str.length;for (var i=0;i<strLength;i++){str[i].style.fontSize = \"%fpx\";}",currentFontSize]];

    sender.scale = 1;
    
}
#pragma mark- getrurl
-(void)geturl{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSDictionary *parameters = @{@"articleId":self.mArticleID,
                                 @"sn":[def stringForKey:@"UUID"],
                                 };
    [HttpJsonManager getWithParameters:parameters sender:self url:@"http://182.92.183.22:8080/nj_app/app/showArticle.do" completionHandler:^(BOOL sucess, id content) {
        if (sucess) {
            [self.mWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:content[@"path"]]]];
            self.mPraiseBtn.selected = [content[@"isPraised"] boolValue];
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            });
        }
    }];
}
@end