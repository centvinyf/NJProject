//
//  ItemsViewControllerCell.m
//  NJMobile
//
//  Created by Magic Beans on 15/1/8.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "PeriodicalsViewControllerCell.h"
#import "UIButton+AFNetworking.h"

@implementation PeriodicalsViewControllerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithArray:(NSArray *)itemsArray withIndex:(NSInteger)itemIndex
{
    if (itemsArray.count > 0) {
        NSDictionary *leftDic = itemsArray[0];
        [self.leftItemView setHidden:NO];
        [self.leftItemBtn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:leftDic[@"path"]] placeholderImage:[UIImage imageNamed:@"加载书刊"]];
        self.leftItemBtn.tag = itemIndex;
        self.leftDateLabel.text = leftDic[@"title"];
    }
    else
    {
        [self.leftItemView setHidden:YES];
    }
    
    if (itemsArray.count > 1) {
        NSDictionary *centerDic = itemsArray[1];
        [self.centerItemView setHidden:NO];
        [self.centerItemBtn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:centerDic[@"path"]] placeholderImage:[UIImage imageNamed:@"加载书刊"]];
        self.centerItemBtn.tag = itemIndex + 1;
        self.centerDateLabel.text = centerDic[@"title"];
    }
    else
    {
        [self.centerItemView setHidden:YES];
    }
    
    if (itemsArray.count > 2) {
        NSDictionary *rightDic = itemsArray[2];
        [self.rightItemView setHidden:NO];
        [self.rightItemBtn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:rightDic[@"path"]] placeholderImage:[UIImage imageNamed:@"加载书刊"]];
        self.rightItemBtn.tag = itemIndex + 2;
        self.rightDateLabel.text = rightDic[@"title"];
    }
    else
    {
        [self.rightItemView setHidden:YES];
    }
}

@end
