//
//  CommentViewControllerCellTableViewCell.m
//  NJMobile
//
//  Created by Sylar-MagicBeans on 15/1/12.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "CommentViewControllerCellTableViewCell.h"

@implementation CommentViewControllerCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithDic:(NSDictionary *)dic
{
    self.mLocationLabel.text = dic[@"address"];
    self.mCommentLabel.text = dic[@"content"];
    self.mTimeLabel.text = dic[@"date"];
}
@end
