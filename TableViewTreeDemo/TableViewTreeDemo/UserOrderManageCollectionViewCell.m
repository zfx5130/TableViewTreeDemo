//
//  UserOrderManageCollectionViewCell.m
//  TableViewTreeDemo
//
//  Created by admin on 16/10/14.
//  Copyright © 2016年 thomas. All rights reserved.
//

#import "UserOrderManageCollectionViewCell.h"

@implementation UserOrderManageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat size = [UIScreen mainScreen].bounds.size.width < 375.0f ? 13 : 14.0f;
    self.titleLabel.font = [UIFont systemFontOfSize:size];
}

@end
