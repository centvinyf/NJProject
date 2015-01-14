//
//  ItemsViewControllerCell.h
//  NJMobile
//
//  Created by Magic Beans on 15/1/8.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeriodicalsViewControllerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *leftItemView;
@property (weak, nonatomic) IBOutlet UIButton *leftItemBtn;
@property (weak, nonatomic) IBOutlet UILabel *leftDateLabel;
@property (weak, nonatomic) IBOutlet UIView *centerItemView;
@property (weak, nonatomic) IBOutlet UIButton *centerItemBtn;
@property (weak, nonatomic) IBOutlet UILabel *centerDateLabel;
@property (weak, nonatomic) IBOutlet UIView *rightItemView;
@property (weak, nonatomic) IBOutlet UIButton *rightItemBtn;
@property (weak, nonatomic) IBOutlet UILabel *rightDateLabel;

- (void)initWithArray:(NSArray *)itemsArray withIndex:(NSInteger)itemIndex;
@end
