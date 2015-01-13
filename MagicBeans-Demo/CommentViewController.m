//
//  CommentViewController.m
//  NJMobile
//
//  Created by Sylar-MagicBeans on 15/1/12.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentViewControllerCellTableViewCell.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    numberOfItems = 5;
    mPrototypeCell = [self.mTableView dequeueReusableCellWithIdentifier:@"CommentViewControllerCell"];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)loadData
{
    mDataSouceArray = @[@"你要钱不要命吗？",@"我要命也要钱啊啊啊！哈哈！我要命也要钱啊啊啊！哈哈！"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mDataSouceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifiller = @"CommentViewControllerCell";
    CommentViewControllerCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiller];
    cell.mCommentLabel.text = mDataSouceArray[indexPath.row];
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGRect rect = [mDataSouceArray[indexPath.row] boundingRectWithSize:CGSizeMake(320 - 58, 0)
                                                               options:NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                   
                                                            attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}
                                                               context:NULL];
    
    return 49 + rect.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGRect rect = [mDataSouceArray[indexPath.row] boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 58, 0)
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
