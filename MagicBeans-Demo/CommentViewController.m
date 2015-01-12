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
    
    // Do any additional setup after loading the view.
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
    static NSString *identifiller = @"CommentViewControllerCell";
    CommentViewControllerCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiller];
    
    
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

@end
