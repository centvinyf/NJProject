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
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];

    if (itemsArray.count > 0) {
        NSDictionary *leftDic = itemsArray[0];
        [self.leftItemView setHidden:NO];
        [self.leftItemBtn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:leftDic[@"path"]] placeholderImage:nil];
        self.leftItemBtn.tag = itemIndex;
        [formater setDateFormat:@"yyyy-M-dd"];
        NSDate *date = [formater dateFromString:leftDic[@"date"]];
        [formater setDateFormat:@"yyyy"];
        NSString *year = [formater stringFromDate:date];
        [formater setDateFormat:@"M"];
        NSString *month = [formater stringFromDate:date];
        self.leftDateLabel.text = [NSString stringWithFormat:@"%@年第%@期",year,month];
    }
    else
    {
        [self.leftItemView setHidden:YES];
    }
    
    if (itemsArray.count > 1) {
        NSDictionary *centerDic = itemsArray[1];
        [self.centerItemView setHidden:NO];
        [self.centerItemBtn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:centerDic[@"path"]] placeholderImage:nil];
        self.centerItemBtn.tag = itemIndex + 1;
        [formater setDateFormat:@"yyyy-M-dd"];
        NSDate *date = [formater dateFromString:centerDic[@"date"]];
        [formater setDateFormat:@"yyyy"];
        NSString *year = [formater stringFromDate:date];
        [formater setDateFormat:@"M"];
        NSString *month = [formater stringFromDate:date];
        self.centerDateLabel.text = [NSString stringWithFormat:@"%@年第%@期",year,month];
    }
    else
    {
        [self.centerItemView setHidden:YES];
    }
    
    if (itemsArray.count > 2) {
        NSDictionary *rightDic = itemsArray[2];
        [self.rightItemView setHidden:NO];
        [self.rightItemBtn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:rightDic[@"path"]] placeholderImage:nil];
        self.rightItemBtn.tag = itemIndex + 2;
        [formater setDateFormat:@"yyyy-M-dd"];
        NSDate *date = [formater dateFromString:rightDic[@"date"]];
        [formater setDateFormat:@"yyyy"];
        NSString *year = [formater stringFromDate:date];
        [formater setDateFormat:@"M"];
        NSString *month = [formater stringFromDate:date];
        self.rightDateLabel.text = [NSString stringWithFormat:@"%@年第%@期",year,month];
    }
    else
    {
        [self.rightItemView setHidden:YES];
    }
}

@end
