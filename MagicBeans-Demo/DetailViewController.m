//
//  MoreViewController.m
//  MagicBeans-Demo
//
//  Created by Magic Beans on 14/12/11.
//  Copyright (c) 2014年 Magic Beans. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}




#pragma


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.FengeView.hidden = YES;
    self.SmallButton.hidden = YES;
    self.MidButton.hidden = YES;
    self.BigButton.hidden = YES;
    
}



- (void) viewWillAppear:(BOOL)paramAnimated{
    [super viewWillAppear:paramAnimated];

}

@end