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
#import "HttpJsonManager.h"
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
    NSDictionary *parameters = @{@"page":[NSNumber numberWithInteger:currentPageIndex]};
    [HttpJsonManager getWithParameters:parameters sender:self url:@"http://182.92.183.22:8080/nj_app/app/getMagazineList.do" completionHandler:^(BOOL sucess, id content) {
        if (sucess) {
            mPeriodicalsArray = [NSMutableArray arrayWithArray:content[@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.tableView topRefreshControlStopRefreshing];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                [self.tableView topRefreshControlStopRefreshing];
            });
        }
    }];
}

- (void)loadDataMore
{
    currentPageIndex++;
    NSDictionary *parameters = @{@"page":[NSNumber numberWithInteger:currentPageIndex]};
    [HttpJsonManager getWithParameters:parameters sender:self url:@"http://182.92.183.22:8080/nj_app/app/getMagazineList.do" completionHandler:^(BOOL sucess, id content) {
        if (sucess) {
            if ([content[@"data"] count] > 0)
            {
                [mPeriodicalsArray addObjectsFromArray:content[@"data"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                    [self.tableView bottomRefreshControlStopRefreshing];

                });
            }
            else
            {
                //恢复到之前的页码
                currentPageIndex--;
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"没有更多的数据了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                
            }
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"没有更多的数据了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                [self.tableView bottomRefreshControlStopRefreshing];
            });

        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ceilf(mPeriodicalsArray.count/3.0);
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 22)];
    headerView.backgroundColor = [UIColor clearColor];
    UILabel *titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, headerView.frame.size.width, headerView.frame.size.height - 5)];
    titileLabel.text = @"刊号10086";
    titileLabel.font = [UIFont systemFontOfSize:12];
    titileLabel.textColor = [UIColor colorWithRed:7.0/255.0 green:63.0/255.0 blue:137.0/255.0 alpha:1];
    [headerView addSubview:titileLabel];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifiller = @"PeriodicalsViewControllerCell";
    PeriodicalsViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiller];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:3];
    if (mPeriodicalsArray.count >indexPath.row*3) {
        [items addObject:mPeriodicalsArray[indexPath.row*3]];
    }
    
    if (mPeriodicalsArray.count >indexPath.row*3 +1) {
        [items addObject:mPeriodicalsArray[indexPath.row*3 + 1]];
    }
    
    if (mPeriodicalsArray.count >indexPath.row*3 +2) {
        [items addObject:mPeriodicalsArray[indexPath.row*3 + 2]];
    }
    [cell initWithArray:items withIndex:indexPath.row*3];
    
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
