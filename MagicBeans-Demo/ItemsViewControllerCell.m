//
//  ItemsViewControllerCell.m
//  NJMobile
//
//  Created by Magic Beans on 15/1/8.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "ItemsViewControllerCell.h"

@implementation ItemsViewControllerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithArray:(NSArray *)itemsArray
{
    NSDictionary *leftDic = itemsArray[0];
    [self.leftItemBtn setTitle:leftDic[@"title"] forState:UIControlStateNormal];
    
    NSDictionary *centerDic = itemsArray[1];
    [self.leftItemBtn setTitle:centerDic[@"title"] forState:UIControlStateNormal];
    
    NSDictionary *rightDic = itemsArray[2];
    [self.leftItemBtn setTitle:rightDic[@"title"] forState:UIControlStateNormal];
}

@end
