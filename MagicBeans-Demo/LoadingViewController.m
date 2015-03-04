//
//  LoadingViewController.m
//  NJMobile
//
//  Created by Magic Beans on 15/1/9.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "LoadingViewController.h"
#import "HttpJsonManager.h"
#import "UIImageView+AFNetworking.h"
@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadLastestPic];
    [self getLoadingPicture];
}
- (IBAction)loadingButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"UINavigationController" sender:nil];
}
-(void)getLoadingPicture{
    [HttpJsonManager getWithParameters:nil sender:self url:@"http://182.92.183.22:8080/nj_app/app/getLoadingImg.do" completionHandler:^(BOOL sucess, id content) {
        if (sucess)
        {
            if ([content[@"data"][@"status"] boolValue])
            {
                self.LoadingPicture = content[@"data"][@"path"];
                NSRange range = [self.LoadingPicture rangeOfString:@"/" options:NSBackwardsSearch];
                if (range.length > 0)
                {
                    range.location += 1;//remove @"/"
                    range.length = self.LoadingPicture.length - range.location;
                    NSString *fileName = [self.LoadingPicture substringWithRange:range];
                    [self initViewWithImageFile:fileName URL:self.LoadingPicture];
                }
                else
                {
                    
                }

            }
            else
            {
                exit(0);
            }
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"获取loading图片失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"UINavigationController" sender:nil];
                });

            });
        }
    }];
}
- (void)initViewWithImageFile:(NSString *)fileName URL:(NSString *)urlStr
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@",fileName]];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    if (image == nil)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
            [imageData writeToFile:filePath atomically:YES];
            ///record latest Picture Name
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            [def setValue:fileName forKey:@"LatestPic"];

        });
    }
    else
    {
        [self.LoadingImage setImage:image];
    }
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadLastestPic
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *latestPicName = [def stringForKey:@"LatestPic"];
    if (latestPicName != nil)
    {
        NSString *filePath = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@",latestPicName]];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        [self.LoadingImage setImage:image];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
