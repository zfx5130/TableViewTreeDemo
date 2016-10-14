//
//  ViewController.m
//  TableViewTreeDemo
//
//  Created by admin on 16/10/14.
//  Copyright © 2016年 thomas. All rights reserved.
//

#import "ViewController.h"
#import "UserOrderManagerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - handlers

- (IBAction)handleButtonWasPressed:(UIButton *)sender {
    UserOrderManagerViewController *orderController = [[UserOrderManagerViewController alloc] init];
    [self.navigationController pushViewController:orderController animated:YES];
}


@end
