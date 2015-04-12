//
//  RecommendViewController.m
//  SBTimer
//
//  Created by Master on 2015/04/13.
//  Copyright (c) 2015年 net.masuhara. All rights reserved.
//

#import "RecommendViewController.h"

@interface RecommendViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation RecommendViewController {
    IBOutlet UITableView *recommendTableView;
    NSArray *cellNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    recommendTableView.dataSource = self;
    recommendTableView.delegate = self;
    cellNames = [NSArray arrayWithObjects:@"RecommendCell1", @"RecommendCell2", @"RecommendCell3", nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cellNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellName = [cellNames objectAtIndex:indexPath.row];
    UITableViewCell *cell = [recommendTableView dequeueReusableCellWithIdentifier:cellName];
    
    return cell;
}


@end
