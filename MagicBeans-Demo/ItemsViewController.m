//
//  ItemsViewController.m
//  MagicBeans-Demo
//
//  Created by Magic Beans on 14/12/10.
//  Copyright (c) 2014年 Magic Beans. All rights reserved.
//

#import "ItemsViewController.h"
#import "ItemsViewControllerCell.h"
#import "DetailViewController.h"
#import "UIScrollView+RefreshControl.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface ItemsViewController ()

@end

@implementation ItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    [self loadCategoriesData];
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
    
}

- (void)initCategorysWithArray:(NSArray *)categoryArray
{
    for (NSInteger index = 0; index < categoryArray.count; index++) {
        NSDictionary *categoryItem = categoryArray[index];
        [self addCategory:categoryItem[@"column_name"] CategoryID:index];
    }

}

#pragma mark- navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController * DetailViewController = [segue destinationViewController];
    DetailViewController.mArticleID = sender;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self performSegueWithIdentifier:@"DetailViewController" sender:mArticles[indexPath.row][@"id"]];
}
#pragma mark- Load Data

-(void)loadArticleDataWithID:(NSString *)categoryID
{
    currentPageIndex = 1;
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"magazineId":self.mPeriodicalID,
                                 @"columnId":categoryID,
                                 @"page":[NSNumber numberWithInteger:currentPageIndex]};
    [mgr GET:@"http://192.168.1.113:8081/nj_app/app/getColumnContent.do" parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         mArticles = responseObject[@"data"];
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.mTableView reloadData];
             [self.mTableView topRefreshControlStopRefreshing];
         });
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alertView show];
         });
     }];


}

- (void)loadData
{
    
}

- (void)loadCategoriesData
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"magazineId":self.mPeriodicalID};
    [mgr GET:@"http://192.168.1.113:8081/nj_app/app/getColumnList.do" parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         mCategories = responseObject[@"data"];
         [self initCategorysWithArray:mCategories];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alertView show];
         });
     }];
}

- (void)loadDataMore
{
    
}

- (void)loadBannersDataWithID:(NSString *)categoryID
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"magazineId":self.mPeriodicalID,
                                 @"columnId":categoryID};
    [mgr GET:@"http://192.168.1.113:8081/nj_app/app/getColumnBanner.do" parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         mBanners = responseObject[@"data"];
         self.mPageControl.numberOfPages = mBanners.count;
         
         if (mBanners.count > 0) {
             [self.bannerImage1 setImageWithURL:[NSURL URLWithString:mBanners[0][@"path"] ] placeholderImage:[UIImage imageNamed:@"banner1"]];
             self.bannerTitleLabel.text = mBanners[0][@"title"];
             [self.bannerImage1 setHidden:NO];

         }
         else
         {
             [self.bannerImage1 setHidden:YES];
         }
         
         if (mBanners.count > 1) {
             [self.bannerImage2 setImageWithURL:[NSURL URLWithString:mBanners[1][@"path"] ] placeholderImage:[UIImage imageNamed:@"banner1"]];
             [self.bannerImage2 setHidden:NO];
         }
         else
         {
             [self.bannerImage2 setHidden:YES];
         }
         
         if (mBanners.count > 2) {
             [self.bannerImage3 setImageWithURL:[NSURL URLWithString:mBanners[2][@"path"] ] placeholderImage:[UIImage imageNamed:@"banner1"]];
             [self.bannerImage3 setHidden:NO];
         }
         else
         {
             [self.bannerImage3 setHidden:YES];
         }
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alertView show];
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
    return mArticles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifiller = @"ItemsViewControllerCell";
    ItemsViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiller];
    [cell initWitDic:mArticles[indexPath.row]];
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
    mCurrentCategoryID = mCategories[sender.tag][@"id"];
    [self loadBannersDataWithID:mCategories[sender.tag][@"id"]];
    [self loadArticleDataWithID:mCategories[sender.tag][@"id"]];
//    [self performSegueWithIdentifier:@"ReportViewController" sender:nil];
}

- (UIButton *)addCategory:(NSString *)name CategoryID:(NSInteger)categoryID
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
    
    return categoryBtn;
}

#pragma UIScrollView Delegate
- (void) scrollViewDidScroll:(UIScrollView *)sender
{
    if(sender != self.mTableView)
    {
        CGFloat scrollviewW =  sender.frame.size.width;
        CGFloat x = sender.contentOffset.x;
        int page = (x + scrollviewW / 2) /  scrollviewW;
        if (self.mPageControl.numberOfPages > page)
        {
            self.mPageControl.currentPage = page;
            self.bannerTitleLabel.text = mBanners[page][@"title"];
        }
    }
}
@end
