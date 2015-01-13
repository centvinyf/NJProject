//
//  PageViewController.m
//  MagicBeans-Demo
//
//  Created by Magic Beans on 14/12/11.
//  Copyright (c) 2014年 Magic Beans. All rights reserved.
//

#import "PageViewController.h"
#import "DetailViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self createContentPages];
//    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
//                                                       forKey: UIPageViewControllerOptionSpineLocationKey];
//    
//    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
//                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
//                                                                        options: options];
//    _pageController.dataSource = self;
//    [_pageController.view setFrame:self.view.frame];
    
//    DetailViewController *initialViewController =[self viewControllerAtIndex:0];
//    NSArray *viewControllers =[NSArray arrayWithObject:initialViewController];
//    [_pageController setViewControllers:viewControllers
//                              direction:UIPageViewControllerNavigationDirectionForward
//                               animated:NO
//                             completion:nil];
//    
//    [self addChildViewController:_pageController];
//    [self.view addSubview:_pageController.view];
}

//// 初始化所有数据
//- (void) createContentPages
//{
//    NSMutableArray *pageImages = [[NSMutableArray alloc] init];
//    for (int i = 1; i < 5; i++)
//    {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Detail_page%d",i]];
//        [pageImages addObject:image];
//    }
//    self.pageContent = [[NSArray alloc] initWithArray:pageImages];
//                                   
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//// 得到相应的VC对象
//- (DetailViewController *)viewControllerAtIndex:(NSUInteger)index {
//    if (([self.pageContent count] == 0) || (index >= [self.pageContent count])) {
//        return nil;
//    }
//    // 创建一个新的控制器类，并且分配给相应的数据
//    DetailViewController *dataViewController =[[DetailViewController alloc] init];
//    dataViewController.image =[self.pageContent objectAtIndex:index];
//    return dataViewController;
//}
//
//// 根据数组元素值，得到下标值
//- (NSUInteger)indexOfViewController:(DetailViewController *)viewController {
//    return [self.pageContent indexOfObject:viewController.image];
//}
//
//#pragma mark- UIPageViewControllerDataSource
//
//// 返回上一个ViewController对象
//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
//    
//    NSUInteger index = [self indexOfViewController:(DetailViewController *)viewController];
//    if ((index == 0) || (index == NSNotFound)) {
//        return nil;
//    }
//    index--;
//    return [self viewControllerAtIndex:index];
//}
//
//// 返回下一个ViewController对象
//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
//    
//    NSUInteger index = [self indexOfViewController:(DetailViewController *)viewController];
//    if (index == NSNotFound) {
//        return nil;
//    }
//    index++;
//    if (index == [self.pageContent count]) {
//        return nil;
//    }
//    return [self viewControllerAtIndex:index];
//}


@end
