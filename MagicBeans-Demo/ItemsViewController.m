//
//  ItemsViewController.m
//  MagicBeans-Demo
//
//  Created by Magic Beans on 14/12/10.
//  Copyright (c) 2014年 Magic Beans. All rights reserved.
//

#import "ItemsViewController.h"
#import "ItemsViewControllerCell.h"
#import "UIScrollView+RefreshControl.h"

@interface ItemsViewController ()

@end

@implementation ItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

- (void)initViews
{
    
    __weak typeof(self) weakSelf = self;
    [self.mTableView addTopRefreshControlUsingBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // request for datas
            [weakSelf loadData];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.mTableView reloadData];
            [weakSelf.mTableView topRefreshControlStopRefreshing];
        });
    } refreshControlPullType:RefreshControlPullTypeInsensitive refreshControlStatusType:RefreshControlStatusTypeArrow];
    
    [self.mTableView addBottomRefreshControlUsingBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // request for datas
            [weakSelf loadDataMore];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.mTableView reloadData];
            [weakSelf.mTableView bottomRefreshControlStopRefreshing];
        });
    } refreshControlPullType:RefreshControlPullTypeInsensitive refreshControlStatusType:RefreshControlStatusTypeArrow];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mTableView topRefreshControlStartInitializeRefreshing];
    });
}

- (void)loadData
{
    numberOfItems = 5;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self addCategory:@"我是测试按钮" CategoryID:1];
    });
}

- (void)loadDataMore
{
    numberOfItems += 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)selectedButton:(UIButton *)sender {
    for (UIView *view in sender.superview.subviews) {
        if ([view isMemberOfClass:[UIButton class]]) {
            if (view != sender) {
                ((UIButton *)view).selected = NO;
                ((UIButton *)view).titleLabel.font = [UIFont systemFontOfSize:13];
            }
        }
    }
    sender.selected = YES;
    sender.titleLabel.font = [UIFont systemFontOfSize:13];
    [self performSegueWithIdentifier:@"ReportViewController" sender:nil];
}

- (void)addCategory:(NSString *)name CategoryID:(NSInteger)categoryID
{
    UIButton *categoryBtn = [[UIButton alloc] init];
    [categoryBtn setTitle:name forState:UIControlStateNormal];
    [categoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [categoryBtn setTitleColor:[UIColor colorWithRed:13.0/255.0 green:0 blue:99/255.0 alpha:1] forState:UIControlStateSelected];
    categoryBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    categoryBtn.tag =categoryID;
    CGRect rect = categoryBtn.frame;
    rect.origin.x = self.mCategorysViewWidth.constant;
    rect.size = [name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    rect.size.height = self.mCategorysView.frame.size.height;
    categoryBtn.frame = rect;
    [categoryBtn addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.mCategorysViewWidth.constant += categoryBtn.frame.size.width + 8;
    [self.mCategorysView addSubview:categoryBtn];
}

#pragma UIScrollView Delegate
- (void) scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat scrollviewW =  sender.frame.size.width;
    CGFloat x = sender.contentOffset.x;
    int page = (x + scrollviewW / 2) /  scrollviewW;
    self.mPageControl.currentPage = page;
}
@end
