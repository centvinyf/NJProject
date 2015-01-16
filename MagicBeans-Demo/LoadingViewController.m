//
//  LoadingViewController.m
//  NJMobile
//
//  Created by Magic Beans on 15/1/9.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "LoadingViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLoadingPicture];
}
-(void)getLoadingPicture{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        [mgr GET:@"http://192.168.1.113:8081/nj_app/app/getLoadingImg.do" parameters:nil
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         self.LoadingPicture = responseObject[@"data"][@"path"];
         NSRange range = [self.LoadingPicture rangeOfString:@"/" options:NSBackwardsSearch];
         if (range.length > 0)
         {
             range.location += 1;//remove @"/"
             range.length = self.LoadingPicture.length - range.location;
             NSString *fileName = [self.LoadingPicture substringWithRange:range];
             [self initViewWithImageFile:fileName URL:self.LoadingPicture];
         }
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"获取loading图片失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alertView show];
             
         });
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
            [imageData writeToFile:[NSHomeDirectory() stringByAppendingPathComponent:fileName] atomically:YES];
        });
    }
    else
    {
        [self.LoadingImage setImage:image];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"UINavigationController" sender:nil];
    });

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
