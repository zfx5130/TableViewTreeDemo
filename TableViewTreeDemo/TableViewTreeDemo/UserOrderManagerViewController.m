//
//  UserOrderManagerViewController.m
//  TableViewTreeDemo
//
//  Created by admin on 16/10/14.
//  Copyright © 2016年 thomas. All rights reserved.
//

#import "UserOrderManagerViewController.h"
#import "UserOrderManageCollectionViewCell.h"
#import "UserOrderManageTableViewCell.h"
#import "UserOrderProductTableViewCell.h"
#import "UserOrderPayTableViewCell.h"

#import "WSTableviewTree.h"

typedef enum : NSUInteger {
    //全部
    UserOrderTypeAll = 0,
    //未付款
    UserOrderTypeUnpaid,
    //待分拣
    UserOrderTypePaid,
    //可提货
    UserOrderTypeShipped,
    //已提/完成
    UserOrderTypeComplete
} UserOrderType;

@interface UserOrderManagerViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
WSTableViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet WSTableView *tableView;

@property (copy, nonatomic) NSArray *titleArrays;

@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@property (nonatomic, strong)NSMutableArray *dataSourceArrM;

@end

@implementation UserOrderManagerViewController

#pragma mark - Private

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单管理";
    self.navigationController.navigationBar.translucent = NO;
    [self registerCell];
    [self addRightBarButtonItem];
    [self addData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private

- (UserOrderType)getOrderTypeWithTitle:(NSString *)title {
    if ([title isEqualToString:@"全部"]) {
        return UserOrderTypeAll;
    } else if ([title isEqualToString:@"未支付"]) {
        return UserOrderTypeUnpaid;
    } else if ([title isEqualToString:@"待分拣"]) {
        return UserOrderTypePaid;
    } else if ([title isEqualToString:@"可提货"]) {
        return UserOrderTypeShipped;
    } else if ([title isEqualToString:@"已提/完成"]) {
        return UserOrderTypeComplete;
    }
    return UserOrderTypeAll;
}

- (void)addRightBarButtonItem {
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"收起" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)registerCell {
    UINib *nibName = [UINib nibWithNibName:NSStringFromClass([UserOrderManageCollectionViewCell class]) bundle:nil];
    [self.collectionView registerNib:nibName forCellWithReuseIdentifier:NSStringFromClass([UserOrderManageCollectionViewCell class])];
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    UINib *orderManagerNib = [UINib nibWithNibName:NSStringFromClass([UserOrderManageTableViewCell class]) bundle:nil];
    [self.tableView registerNib:orderManagerNib forCellReuseIdentifier:NSStringFromClass([UserOrderManageTableViewCell class])];
    
    UINib *orderProductNib = [UINib nibWithNibName:NSStringFromClass([UserOrderProductTableViewCell class]) bundle:nil];
    [self.tableView registerNib:orderProductNib forCellReuseIdentifier:NSStringFromClass([UserOrderProductTableViewCell class])];
    
    UINib *orderPayNib = [UINib nibWithNibName:NSStringFromClass([UserOrderPayTableViewCell class]) bundle:nil];
    [self.tableView registerNib:orderPayNib forCellReuseIdentifier:NSStringFromClass([UserOrderPayTableViewCell class])];
}

- (void)addData {
    
    self.tableView.WSTableViewDelegate = self;
    
    _dataSourceArrM = [NSMutableArray array];
    WSTableviewDataModel *dataModel = [[WSTableviewDataModel alloc] init];
    dataModel.firstLevelStr = @"医院选择";
    dataModel.shouldExpandSubRows = YES;
    [dataModel object_add_toSecondLevelArrM:@"医院1"];
    [dataModel object_add_toSecondLevelArrM:@"医院2"];
    [dataModel object_add_toSecondLevelArrM:@"医院3"];
    [dataModel object_add_toSecondLevelArrM:@"医院4"];
    [_dataSourceArrM addObject:dataModel];
    
    WSTableviewDataModel *dataModel2 = [[WSTableviewDataModel alloc] init];
    dataModel2.firstLevelStr = @"部位选择";
    //dataModel2.shouldExpandSubRows = YES;
    [dataModel2 object_add_toSecondLevelArrM:@"腿"];
    [dataModel2 object_add_toSecondLevelArrM:@"脚"];
    [dataModel2 object_add_toSecondLevelArrM:@"头"];
    [_dataSourceArrM addObject:dataModel2];
    
    
    WSTableviewDataModel *dataModel3 = [[WSTableviewDataModel alloc] init];
    dataModel3.firstLevelStr = @"部位选择2";
    [dataModel3 object_add_toSecondLevelArrM:@"腿2"];
    [dataModel3 object_add_toSecondLevelArrM:@"脚2"];
    dataModel3.expandable = YES;
    [_dataSourceArrM addObject:dataModel3];
    
    WSTableviewDataModel *dataModel4 = [[WSTableviewDataModel alloc] init];
    dataModel4.firstLevelStr = @"部位选择3";
    [_dataSourceArrM addObject:dataModel4];
}

#pragma mark - Getters & Setters

- (NSArray *)titleArrays {
    if (!_titleArrays) {
        _titleArrays = @[
                         @"全部",
                         @"未支付",
                         @"待分拣",
                         @"可提货",
                         @"已提/完成"
                         ];
    }
    return _titleArrays;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.titleArrays.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UserOrderManageCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UserOrderManageCollectionViewCell class])
                                              forIndexPath:indexPath];
    NSString *title = self.titleArrays[indexPath.item];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",title];
    cell.lineView.hidden = ![self.selectedIndexPath isEqual:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(floorf([UIScreen mainScreen].bounds.size.width / self.titleArrays.count) - 1, 45);
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndexPath = indexPath;
    [collectionView reloadData];
    NSString *title = self.titleArrays[indexPath.item];
    
    UserOrderType type = [self getOrderTypeWithTitle:title];
    NSLog(@"tyel:::::::%@",@(type));
}


#pragma mark - UITableViewDataSource & UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_dataSourceArrM count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)tableView:(WSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.section];
    return [dataModel.secondLevelArrM count] + 1;
}

- (BOOL)tableView:(WSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.section];
    return dataModel.shouldExpandSubRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.section];
    UserOrderManageTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserOrderManageTableViewCell class])];
    cell.statusLabel.text = dataModel.firstLevelStr;
    cell.expandable = dataModel.expandable;
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.section];
    
    if (indexPath.subRow < dataModel.secondLevelArrM.count) {
        UserOrderProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserOrderProductTableViewCell class])];
        cell.productNamelabel.text = [dataModel object_get_fromSecondLevelArrMWithIndex:indexPath.subRow];
        cell.bottomHeightConstraint.constant = indexPath.subRow == dataModel.secondLevelArrM.count - 1 ? 0.0f : 5.0f;
        return cell;
    }
    UserOrderPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserOrderPayTableViewCell class])];
    return cell;
}

- (CGFloat)tableView:(WSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

- (CGFloat)tableView:(WSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.section];
    if (indexPath.subRow < dataModel.secondLevelArrM.count) {
        if (indexPath.subRow == dataModel.secondLevelArrM.count - 1) {
            return 85.0f;
        }
        return 90.0f;
    } else {
        return 40.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.section];
    dataModel.shouldExpandSubRows = !dataModel.shouldExpandSubRows;
    NSLog(@"Section: %ld, Row:%ld", indexPath.section, indexPath.section);
}

- (void)tableView:(WSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Section: %ld, Row:%ld, Subrow:%ld", indexPath.section, indexPath.section, indexPath.subRow);
}

#pragma mark - handlers

- (void)close {
    [self.tableView collapseCurrentlyExpandedIndexPaths];
}

@end
