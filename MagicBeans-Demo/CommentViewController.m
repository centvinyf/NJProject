//
//  CommentViewController.m
//  NJMobile
//
//  Created by Sylar-MagicBeans on 15/1/12.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentViewControllerCellTableViewCell.h"
#import "AFNetworking.h"
#import "UIScrollView+RefreshControl.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    numberOfItems = 5;
    mPrototypeCell = [self.mTableView dequeueReusableCellWithIdentifier:@"CommentViewControllerCell"];
    self.mArticleID = @"sdfasd123";
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
    
//    [self.mTableView addBottomRefreshControlUsingBlock:^{
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            // request for datas
//            [weakSelf loadDataMore];
//        });
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.mTableView reloadData];
//            [weakSelf.mTableView bottomRefreshControlStopRefreshing];
//        });
//    } refreshControlPullType:RefreshControlPullTypeInsensitive refreshControlStatusType:RefreshControlStatusTypeArrow];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mTableView topRefreshControlStartInitializeRefreshing];
    });
}


- (void)loadData
{
//    currentPageIndex = 1;
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"articleId":self.mArticleID};
    [mgr GET:@"http://192.168.1.113:8081/nj_app/app/getArticleCommont.do" parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         mCommentsArray = [NSMutableArray arrayWithArray:responseObject[@"data"]];
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.mTableView reloadData];
             [self.mTableView topRefreshControlStopRefreshing];
         });
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alertView show];
             [self.mTableView topRefreshControlStopRefreshing];
         });
     }];
}

- (void)loadDataMore
{
    currentPageIndex++;
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"articleId":[NSNumber numberWithInteger:currentPageIndex]};
    [mgr GET:@"http://192.168.1.113:8081/nj_app/app/getArticleCommont.do" parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if ([responseObject[@"data"] count] > 0)
         {
             [mCommentsArray addObjectsFromArray:responseObject[@"data"]];
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.mTableView reloadData];
             });
         }
         else
         {
             //恢复到之前的页码
             currentPageIndex--;
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"没有更多的数据了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alertView show];
             
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.mTableView bottomRefreshControlStopRefreshing];
         });
         
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"没有更多的数据了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alertView show];
             [self.mTableView bottomRefreshControlStopRefreshing];
         });
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
    CGRect rect = [comment boundingRectWithSize:CGSizeMake(320 - 58, 0)
                                                               options:NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                   
                                                            attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}
                                                               context:NULL];
    
    return 49 + rect.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *comment = mCommentsArray[indexPath.row][@"content"];
    CGRect rect = [comment boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 58, 0)
                                                               options:NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading

                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}
                                   context:NULL];

    return 49 + rect.size.height;
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
