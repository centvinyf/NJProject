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
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIView *mCategorysView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCategorysViewWidth;
@property (weak, nonatomic) IBOutlet UIPageControl *mPageControl;
@end
