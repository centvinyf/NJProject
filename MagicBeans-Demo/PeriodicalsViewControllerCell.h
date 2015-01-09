//
//  ItemsViewControllerCell.h
//  NJMobile
//
//  Created by Magic Beans on 15/1/8.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeriodicalsViewControllerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *leftItemBtn;
@property (weak, nonatomic) IBOutlet UIButton *centerItemBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightItemBtn;

- (void)initWithArray:(NSArray *)itemsArray;
@end
