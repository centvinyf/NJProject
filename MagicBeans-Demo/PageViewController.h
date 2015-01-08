//
//  PageViewController.h
//  MagicBeans-Demo
//
//  Created by Magic Beans on 14/12/11.
//  Copyright (c) 2014年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController : UIViewController <UIPageViewControllerDataSource>
{
    __weak IBOutlet UIImageView *toolBar;
    
}
@property (retain, nonatomic) UIPageViewController *pageController;
@property (retain, nonatomic) NSArray *pageContent;

@end
