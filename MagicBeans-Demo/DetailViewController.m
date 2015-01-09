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

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.mPickerView.showsSelectionIndicator = YES;//窗口透明
//    self.mPickerView.delegate = self;
//    
//    self.textArray = [NSArray arrayWithObjects:@"大",
//                      @"中",
//                      @"小",
//                       nil];
    
    
    
}
//#pragma mark  - dataSource method
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView
//
//numberOfRowsInComponent:(NSInteger)component
//{
//    return 3;
//}
//
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return 1;
//}
//
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
//
//            forComponent:(NSInteger)component
//{
//    return self.textArray[row];
//}
//
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:
//
//(NSInteger)component
//{
//    self.currenFont = self.textArray[row];
//}
//#pragma mark
//
//
//



- (void) viewWillAppear:(BOOL)paramAnimated{
    [super viewWillAppear:paramAnimated];

}

- (IBAction)FontButtonPreesed:(id)sender {
    self.mFontSetView.hidden = NO;
}
- (IBAction)ConfirmButtonPressed:(id)sender {
    NSLog(@"当前字体为：%@",self.currenFont);
    self.mFontSetView.hidden = YES;
}
@end