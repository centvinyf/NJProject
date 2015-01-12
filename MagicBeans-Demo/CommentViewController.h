//
//  CommentViewController.h
//  NJMobile
//
//  Created by Sylar-MagicBeans on 15/1/12.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController
{
    NSInteger numberOfItems;
}
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
