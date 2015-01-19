//
//  ItemsViewController.h
//  MagicBeans-Demo
//
//  Created by Magic Beans on 14/12/10.
//  Copyright (c) 2014年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSInteger numberOfItems;
    NSString *mCurrentCategoryID;
    NSArray *mCategories;
    NSArray *mBanners;
    NSMutableArray *mArticles;
    NSInteger currentPageIndex;
    NSTimer *mScrollTimer;
}
@property (retain, nonatomic) NSString *mPeriodicalID;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIView *mCategorysView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCategorysViewWidth;
@property (weak, nonatomic) IBOutlet UIPageControl *mPageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *mBannerScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage1;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage2;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage3;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage_1;
@property (weak, nonatomic) IBOutlet UILabel *bannerTitleLabel;
@end
