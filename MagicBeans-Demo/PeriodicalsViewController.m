//
//  PeriodicalsViewController.m
//  NJMobile
//
//  Created by Magic Beans on 15/1/8.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "PeriodicalsViewController.h"
#import "PeriodicalsViewControllerCell.h"
#import "UIScrollView+RefreshControl.h"
#import "AFNetworking.h"
#import "ItemsViewController.h"

@interface PeriodicalsViewController ()

@end

@implementation PeriodicalsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initViews
{    
    __weak typeof(self) weakSelf = self;
    [self.tableView addTopRefreshControlUsingBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // request for datas
            [weakSelf loadData];
        });
    } refreshControlPullType:RefreshControlPullTypeInsensitive refreshControlStatusType:RefreshControlStatusTypeArrow];
    
    [self.tableView addBottomRefreshControlUsingBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // request for datas
            [weakSelf loadDataMore];
    });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [weakSelf.tableView bottomRefreshControlStopRefreshing];
        });
    } refreshControlPullType:RefreshControlPullTypeInsensitive refreshControlStatusType:RefreshControlStatusTypeArrow];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView topRefreshControlStartInitializeRefreshing];
    });
}



- (void)loadData
{
    currentPageIndex = 1;
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"page":[NSNumber numberWithInteger:currentPageIndex]};
    [mgr GET:@"http://192.168.1.113:8081/nj_app/app/getMagazineList.do" parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
        mPeriodicalsArray = [NSMutableArray arrayWithArray:responseObject[@"data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView topRefreshControlStopRefreshing];
        });
    }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            [self.tableView topRefreshControlStopRefreshing];
        });
    }];
}

- (void)loadDataMore
{
    currentPageIndex++;
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"page":[NSNumber numberWithInteger:currentPageIndex]};
    [mgr GET:@"http://192.168.1.113:8081/nj_app/app/getMagazineList.do" parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if ([responseObject[@"data"] count] > 0)
         {
             [mPeriodicalsArray addObjectsFromArray:responseObject[@"data"]];
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.tableView reloadData];
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
             [self.tableView bottomRefreshControlStopRefreshing];
         });

     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"没有更多的数据了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alertView show];
             [self.tableView bottomRefreshControlStopRefreshing];
         });
     }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ceilf(mPeriodicalsArray.count/3.0);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"刊号10086";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifiller = @"PeriodicalsViewControllerCell";
    PeriodicalsViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiller];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:3];
    if (mPeriodicalsArray.count >indexPath.row) {
        [items addObject:mPeriodicalsArray[indexPath.row]];
    }
    
    if (mPeriodicalsArray.count >indexPath.row +1) {
        [items addObject:mPeriodicalsArray[indexPath.row + 1]];
    }
    
    if (mPeriodicalsArray.count >indexPath.row +2) {
        [items addObject:mPeriodicalsArray[indexPath.row + 1]];
    }
    [cell initWithArray:items withIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ItemsViewController *itemsViewController = [segue destinationViewController];
    itemsViewController.mPeriodicalID = sender;
}

- (IBAction)showItemsViewController:(UIButton *)sender {
    NSDictionary *dic = mPeriodicalsArray[sender.tag];
    NSString *PeriodicalID = dic[@"id"];
    [self performSegueWithIdentifier:@"ItemsViewController" sender:PeriodicalID];
}
@end
