//
//  UserOrderManageTableViewCell.m
//  TableViewTreeDemo
//
//  Created by admin on 16/10/14.
//  Copyright © 2016年 thomas. All rights reserved.
//

#import "UserOrderManageTableViewCell.h"
#import "WSTableViewCellIndicator.h"

#define kIndicatorViewTag -1

@implementation UserOrderManageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.expandable = NO;
    self.expanded = NO;
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    [super setSelected:selected
              animated:animated];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if(self.isExpanded) {
        if (![self containsIndicatorView]);
        else {
            [self removeIndicatorView];
            [self addIndicatorView];
        }
    }
}

static UIImage *_image = nil;
- (UIView *)expandableView {
    if (!_image) {
        _image = [UIImage imageNamed:@"expandableImage"];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, _image.size.width, _image.size.height);
    button.frame = frame;
    [button setBackgroundImage:_image forState:UIControlStateNormal];
    return button;
}


- (void)setExpandable:(BOOL)isExpandable {
    if (isExpandable)
        [self setAccessoryView:[self expandableView]];
    _expandable = isExpandable;
}

- (void)addIndicatorView {
    CGPoint point = self.accessoryView.center;
    CGRect bounds = self.accessoryView.bounds;
    
    CGRect frame = CGRectMake((point.x - CGRectGetWidth(bounds) * 1.5), point.y * 1.4, CGRectGetWidth(bounds) * 3.0, CGRectGetHeight(self.bounds) - point.y * 1.4);
    WSTableViewCellIndicator *indicatorView = [[WSTableViewCellIndicator alloc] initWithFrame:frame];
    indicatorView.tag = kIndicatorViewTag;
    [self.contentView addSubview:indicatorView];
}

- (void)removeIndicatorView {
    id indicatorView = [self.contentView viewWithTag:kIndicatorViewTag];
    if (indicatorView) {
        [indicatorView removeFromSuperview];
        indicatorView = nil;
    }
}

- (BOOL)containsIndicatorView {
    return [self.contentView viewWithTag:kIndicatorViewTag] ? YES : NO;
}

- (void)accessoryViewAnimation {
    [UIView animateWithDuration:0.2 animations:^{
        if (self.isExpanded) {
            self.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
        } else {
            self.accessoryView.transform = CGAffineTransformMakeRotation(0);
        }
    } completion:^(BOOL finished) {
        if (!self.isExpanded)
            [self removeIndicatorView];
    }];
}

@end
