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
#import "HttpJsonManager.h"
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
            [weakSelf loadArticleDataWithID:mCurrentCategoryID];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.mTableView reloadData];
            [weakSelf.mTableView topRefreshControlStopRefreshing];
        });
    } refreshControlPullType:RefreshControlPullTypeInsensitive refreshControlStatusType:RefreshControlStatusTypeArrow];
    
    [self.mTableView addBottomRefreshControlUsingBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // request for datas
            [weakSelf loadArticleDataMoreWithID:mCurrentCategoryID];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.mTableView reloadData];
            [weakSelf.mTableView bottomRefreshControlStopRefreshing];
        });
    } refreshControlPullType:RefreshControlPullTypeInsensitive refreshControlStatusType:RefreshControlStatusTypeArrow];
    
//    mScrollTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(autoScrollBanner) userInfo:nil repeats:YES];
}

- (void)initCategorysWithArray:(NSArray *)categoryArray
{
    UIButton *defaultBtn;
    for (NSInteger index = 0; index < categoryArray.count; index++) {
        NSDictionary *categoryItem = categoryArray[index];
        if (index == 0)
            defaultBtn = [self addCategory:categoryItem[@"column_name"] CategoryID:index];
        else
        {
            if([categoryItem[@"key_mark"] isEqualToString:@"report"])
            {
                [self addCategory:categoryItem[@"column_name"] CategoryID:888];
            }
            else
            {
                [self addCategory:categoryItem[@"column_name"] CategoryID:index];
            }
        }
    }
    [self selectedButton:defaultBtn];
}

#pragma mark- navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailViewController"]) {
        DetailViewController * DetailViewController = [segue destinationViewController];
       
        
        DetailViewController.mArticleID = sender[@"articleid"];
        DetailViewController.CommentNum = sender[@"commentnum"];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *infomation = @{@"articleid":mArticles[indexPath.row][@"id"],
                                 @"commentnum":mArticles[indexPath.row][@"num"]};
  [self performSegueWithIdentifier:@"DetailViewController" sender:infomation];
}

#pragma mark- Load Data
- (void)loadCategoriesData
{
    NSDictionary *parameters = @{@"magazineId":self.mPeriodicalID};
    [HttpJsonManager getWithParameters:parameters sender:self url:@"http://182.92.183.22:8080/nj_app/app/getColumnList.do" completionHandler:^(BOOL sucess, id content) {
        if (sucess) {
            mCategories = content[@"data"];
            if (mCategories.count > 0)
                [self initCategorysWithArray:mCategories];
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            });

        }
    }];
}

-(void)loadArticleDataWithID:(NSString *)categoryID
{
    currentPageIndex = 1;
    NSDictionary *parameters = @{@"magazineId":self.mPeriodicalID,
                                 @"columnId":categoryID,
                                 @"page":[NSNumber numberWithInteger:currentPageIndex]};
    [HttpJsonManager getWithParameters:parameters sender:self url:@"http://182.92.183.22:8080/nj_app/app/getColumnContent.do" completionHandler:^(BOOL sucess, id content) {
        if (sucess) {
            //banner
//            mBanners = content[@"lstBanner"];
//            self.mPageControl.numberOfPages = mBanners.count;
//            
//            if (mBanners.count > 0) {
//                [self.bannerImage1 setImageWithURL:[NSURL URLWithString:mBanners[0][@"path"] ] placeholderImage:[UIImage imageNamed:@"banner1"]];
//                self.bannerTitleLabel.text = mBanners[0][@"title"];
//                [self.bannerImage1 setHidden:NO];
//                
//                [self.bannerImage_1 setImageWithURL:[NSURL URLWithString:mBanners[0][@"path"] ] placeholderImage:[UIImage imageNamed:@"banner1"]];
//                [self.bannerImage_1 setHidden:NO];
//
//            }
//            else
//            {
//                [self.bannerImage1 setHidden:YES];
//                [self.bannerImage_1 setHidden:YES];
//            }
//            
//            if (mBanners.count > 1) {
//                [self.bannerImage2 setImageWithURL:[NSURL URLWithString:mBanners[1][@"path"] ] placeholderImage:[UIImage imageNamed:@"banner1"]];
//                [self.bannerImage2 setHidden:NO];
//            }
//            else
//            {
//                [self.bannerImage2 setHidden:YES];
//            }
//            
//            if (mBanners.count > 2) {
//                [self.bannerImage3 setImageWithURL:[NSURL URLWithString:mBanners[2][@"path"] ] placeholderImage:[UIImage imageNamed:@"banner1"]];
//                [self.bannerImage3 setHidden:NO];
//            }
//            else
//            {
//                [self.bannerImage3 setHidden:YES];
//            }
            //articles
            mArticles = [NSMutableArray arrayWithArray:content[@"data"]];
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
            });

        }
    }];
}

- (void)loadArticleDataMoreWithID:(NSString *)categoryID
{
    currentPageIndex++;
    NSDictionary *parameters = @{@"magazineId":self.mPeriodicalID,
                                 @"columnId":categoryID,
                                 @"page":[NSNumber numberWithInteger:currentPageIndex]};
    [HttpJsonManager getWithParameters:parameters sender:self url:@"http://182.92.183.22:8080/nj_app/app/getColumnContent.do" completionHandler:^(BOOL sucess, id content) {
        if (sucess) {
            if([content[@"data"] count]>0)
            {
                [mArticles addObjectsFromArray:content[@"data"]];
                
            }
            else{
                currentPageIndex--;
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"没有更多的数据了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mTableView bottomRefreshControlStopRefreshing];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
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
    if (sender.tag == 888) {
        [self performSegueWithIdentifier:@"ReportViewController" sender:nil];
    }
    else
    {
        for (UIView *view in sender.superview.subviews)
        {
            if ([view isMemberOfClass:[UIButton class]])
            {
                if (view != sender) {
                    ((UIButton *)view).selected = NO;
                    ((UIButton *)view).titleLabel.font = [UIFont systemFontOfSize:14];
                    view.frame = CGRectMake(view.frame.origin.x, 0, view.frame.size.width, view.frame.size.height);
                }
            }
        }
        sender.selected = YES;
        sender.titleLabel.font = [UIFont systemFontOfSize:16];
        sender.frame = CGRectMake(sender.frame.origin.x, 2, sender.frame.size.width, sender.frame.size.height);
        mCurrentCategoryID = mCategories[sender.tag][@"id"];
        [self loadArticleDataWithID:mCategories[sender.tag][@"id"]];
    }
}

- (UIButton *)addCategory:(NSString *)name CategoryID:(NSInteger)categoryID
{
    UIButton *categoryBtn = [[UIButton alloc] init];
    [categoryBtn setTitle:name forState:UIControlStateNormal];
    [categoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [categoryBtn setTitleColor:[UIColor colorWithRed:7.0/255.0 green:63.0/255.0 blue:137.0/255.0 alpha:1] forState:UIControlStateSelected];
    categoryBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    categoryBtn.tag =categoryID;
    CGRect rect = categoryBtn.frame;
    rect.origin.x = self.mCategorysViewWidth.constant;
    rect.size = [name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
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
    
    if ([mScrollTimer isValid]) {
        [mScrollTimer invalidate];
    }
    mScrollTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(autoScrollBanner) userInfo:nil repeats:YES];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float WIDTH_OFF_SET = scrollView.frame.size.width * 2;
    float currentPage = scrollView.contentOffset.x;
    if (currentPage > WIDTH_OFF_SET && currentPage < WIDTH_OFF_SET*2)
    {
        [scrollView scrollRectToVisible:CGRectMake(0,0,scrollView.frame.size.width,scrollView.frame.size.height) animated:NO];
    }
    else if (currentPage < 0) {
        [scrollView scrollRectToVisible:CGRectMake(WIDTH_OFF_SET,0,scrollView.frame.size.width,scrollView.frame.size.height) animated:NO];
    }
    
}

- (void)autoScrollBanner
{
    if (self.mBannerScrollView.contentOffset.x >= self.mBannerScrollView.frame.size.width * 2)
    {
        [self.mBannerScrollView scrollRectToVisible:CGRectMake(0,0,self.mBannerScrollView.frame.size.width,self.mBannerScrollView.frame.size.height) animated:NO];
    }
    else
    {
        CGRect scrollRect = self.mBannerScrollView.frame;
        scrollRect.origin.x = self.mBannerScrollView.contentOffset.x + self.mBannerScrollView.frame.size.width;
        [self.mBannerScrollView scrollRectToVisible:scrollRect animated:YES];
    }
}

- (IBAction)showBannerDetail:(id)sender {
    
    NSDictionary *infomation = @{@"articleid":mBanners[self.mPageControl.currentPage][@"article_id"],
                                 @"commentnum":mBanners[self.mPageControl.currentPage][@"num"] ? mBanners[self.mPageControl.currentPage][@"num"] :@"0"};
    [self performSegueWithIdentifier:@"DetailViewController" sender:infomation];
}

@end
