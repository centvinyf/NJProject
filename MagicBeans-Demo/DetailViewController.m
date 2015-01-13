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

#pragma mark- setFonts
-(void)RefreshStatus
{
    [self.BigButton setImage:[UIImage imageNamed:@"大未选中.png"] forState:UIControlStateNormal];
    [self.MidButton setImage:[UIImage imageNamed:@"中未选中.png"] forState:UIControlStateNormal];
    [self.SmallButton setImage:[UIImage imageNamed:@"小未选中.png"] forState:UIControlStateNormal];
    }
- (IBAction)FontSetButtonPressed:(id)sender {
    self.FengeView.hidden = NO;
    self.SmallButton.hidden = NO;
    self.MidButton.hidden = NO;
    self.BigButton.hidden = NO;
}

- (IBAction)BigFontButtonPressed:(id)sender {
    [self RefreshStatus];
    [self.BigButton setImage:[UIImage imageNamed:@"大选中.png"] forState:UIControlStateNormal];
    self.FengeView.hidden = YES;
    self.SmallButton.hidden = YES;
    self.MidButton.hidden = YES;
    self.BigButton.hidden = YES;
    self.currenFont = @"Big";
}
- (IBAction)MidFontButtonPressed:(id)sender {
    [self RefreshStatus];
    [self.MidButton setImage:[UIImage imageNamed:@"中选中.png"] forState:UIControlStateNormal];
    self.FengeView.hidden = YES;
    self.SmallButton.hidden = YES;
    self.MidButton.hidden = YES;
    self.BigButton.hidden = YES;
    self.currenFont = @"Mid";
}
- (IBAction)SmallFontButtonPressed:(id)sender {
    [self RefreshStatus];
    [self.SmallButton setImage:[UIImage imageNamed:@"小选中.png"] forState:UIControlStateNormal];
    self.FengeView.hidden = YES;
    self.SmallButton.hidden = YES;
    self.MidButton.hidden = YES;
    self.BigButton.hidden = YES;
    self.currenFont = @"Small";
}

#pragma mark-


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