//
//  QTViewController.m
//  QTSkin
//
//  Created by fminor on 12/06/2016.
//  Copyright (c) 2016 fminor. All rights reserved.
//

#import "QTViewController.h"

@interface QTViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    UIView *_containerView1;
    UIView *_containerView2;
    
    UICollectionView *_collectionView;
    
    NSString *_cellStyle;
}

@end

@implementation QTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *_path = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"qts"];
    NSURL *_url = [NSURL fileURLWithPath:_path];
    [QT_SK_MGR loadStyleFile:_url];
    
    NSString *_layoutPath = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"qtl"];
    NSURL *_layoutUrl = [NSURL fileURLWithPath:_layoutPath];
    [QT_SK_MGR bindController:self  withLayoutFile:_layoutUrl];
    
    UICollectionViewFlowLayout *_flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat _margin = 10.0;
    [_flowLayout setItemSize:CGSizeMake((self.view.bounds.size.width - _margin ) / 2, 120.f)];
    [_flowLayout setMinimumLineSpacing:_margin];
    [_flowLayout setSectionInset:UIEdgeInsetsMake(_margin, 0, _margin, 0)];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_flowLayout];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"demo_cell"];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_collectionView];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _cellStyle = arc4random() % 2 == 0 ? @"demo_cell" : @"demo_cell2";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *_cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"demo_cell" forIndexPath:indexPath];
    [QT_SK_MGR bindView:_cell.contentView withStyle:_cellStyle];
    return _cell;
}

@end
