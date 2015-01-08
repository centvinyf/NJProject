//
//  ItemsViewController.m
//  MagicBeans-Demo
//
//  Created by Magic Beans on 14/12/10.
//  Copyright (c) 2014年 Magic Beans. All rights reserved.
//

#import "ItemsViewController.h"
#import "ItemsViewControllerCell.h"

@interface ItemsViewController ()

@end

@implementation ItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initView
{
    
}

- (void)loadDataWithPageIndex:(NSInteger)index
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
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
            }
        }
    }
    sender.selected = YES;
}

@end
