//
//  ItemsViewControllerCell.h
//  NJMobile
//
//  Created by Magic Beans on 15/1/9.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemsViewControllerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *mCommentsLabel;

- (void)initWitDic:(NSDictionary *)dic;
@end
