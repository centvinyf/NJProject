//
//  CommentViewController.h
//  NJMobile
//
//  Created by Sylar-MagicBeans on 15/1/12.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentViewControllerCellTableViewCell;

@interface CommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger numberOfItems;
    CommentViewControllerCellTableViewCell *mPrototypeCell;
    NSMutableArray *mCommentsArray;
    NSInteger currentPageIndex;

}
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (retain, nonatomic) NSString *mArticleID;

@end
