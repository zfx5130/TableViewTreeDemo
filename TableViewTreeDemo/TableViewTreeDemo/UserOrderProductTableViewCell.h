//
//  UserOrderProductTableViewCell.h
//  TableViewTreeDemo
//
//  Created by admin on 16/10/14.
//  Copyright © 2016年 thomas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserOrderProductTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *productImageView;

@property (strong, nonatomic) IBOutlet UILabel *productNamelabel;

@property (strong, nonatomic) IBOutlet UILabel *productPriceLabel;

@property (strong, nonatomic) IBOutlet UILabel *productCountLabel;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomHeightConstraint;

@end
