//
//  CommentViewController.m
//  NJMobile
//
//  Created by Sylar-MagicBeans on 15/1/12.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentViewControllerCellTableViewCell.h"
#import "HttpJsonManager.h"
#import "UIScrollView+RefreshControl.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    numberOfItems = 5;
    mPrototypeCell = [self.mTableView dequeueReusableCellWithIdentifier:@"CommentViewControllerCell"];
    [self initViews];
    // Do any additional setup after loading the view.
}

- (void)initViews
{
    __weak typeof(self) weakSelf = self;
    [self.mTableView addTopRefreshControlUsingBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // request for datas
            [weakSelf loadData];
        });
    } refreshControlPullType:RefreshControlPullTypeInsensitive refreshControlStatusType:RefreshControlStatusTypeArrow];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mTableView topRefreshControlStartInitializeRefreshing];
    });
}


- (void)loadData
{
    NSDictionary *parameters = @{@"articleId":self.mArticleID};
    [HttpJsonManager getWithParameters:parameters sender:self url:@"http://182.92.183.22:8080/nj_app/app/getArticleCommont.do" completionHandler:^(BOOL sucess, id content) {
        if (sucess) {
            mCommentsArray = [NSMutableArray arrayWithArray:content[@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mTableView reloadData];
                [self.mTableView topRefreshControlStopRefreshing];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                [self.mTableView topRefreshControlStopRefreshing];
            });
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mCommentsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifiller = @"CommentViewControllerCell";
    CommentViewControllerCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiller];
    [cell initWithDic:mCommentsArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *comment = mCommentsArray[indexPath.row][@"content"];
    CGRect rect = [comment boundingRectWithSize:CGSizeMake(320 - 61, 0)
                                                               options:NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                   
                                                            attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                                               context:NULL];
    
    return 52 + rect.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *comment = mCommentsArray[indexPath.row][@"content"];
    CGRect rect = [comment boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 61, 0)
                                                               options:NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading

                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                   context:NULL];

    return 52 + rect.size.height;
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
