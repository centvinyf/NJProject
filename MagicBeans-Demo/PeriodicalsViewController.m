//
//  PeriodicalsViewController.m
//  NJMobile
//
//  Created by Magic Beans on 15/1/8.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "PeriodicalsViewController.h"
#import "ItemsViewControllerCell.h"
#import "UIScrollView+RefreshControl.h"

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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [weakSelf.tableView topRefreshControlStopRefreshing];
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

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView topRefreshControlStartInitializeRefreshing];
    });
}



- (void)loadData
{
    numberOfItems = 5;
}

- (void)loadDataMore
{
    numberOfItems += 5;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numberOfItems;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifiller = @"ItemsViewControllerCell";
    ItemsViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiller];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showItemsViewController:(UIButton *)sender {
    [self performSegueWithIdentifier:@"ItemsViewController" sender:nil];
}
@end
