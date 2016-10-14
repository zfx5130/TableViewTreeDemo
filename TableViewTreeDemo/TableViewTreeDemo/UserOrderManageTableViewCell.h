//
//  UserOrderManageTableViewCell.h
//  TableViewTreeDemo
//
//  Created by admin on 16/10/14.
//  Copyright © 2016年 thomas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserOrderManageTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (strong, nonatomic) IBOutlet UIImageView *expandImageView;

@property (nonatomic, assign, getter = isExpandable) BOOL expandable;
@property (nonatomic, assign, getter = isExpanded) BOOL expanded;

- (void)addIndicatorView;
- (void)removeIndicatorView;
- (BOOL)containsIndicatorView;
- (void)accessoryViewAnimation;

@end
