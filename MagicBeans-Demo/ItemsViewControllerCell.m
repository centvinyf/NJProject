//
//  ItemsViewControllerCell.m
//  NJMobile
//
//  Created by Magic Beans on 15/1/9.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "ItemsViewControllerCell.h"
#import "UIImageView+AFNetworking.h"

@implementation ItemsViewControllerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWitDic:(NSDictionary *)dic
{
    [self.mIconImageView setImageWithURL:[NSURL URLWithString:dic[@"path"]] placeholderImage:[UIImage imageNamed:@"目录栏图片加载"]];
    [self.mTitleLabel setText:dic[@"title"]];
    [self.mDetailLabel setText:dic[@"summary"]];
    NSString *numStr = [NSString stringWithFormat:@"%@条评论",dic[@"num"]];
    [self.mCommentsLabel setText:numStr];

}

@end
