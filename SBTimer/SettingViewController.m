//
//  SettingViewController.m
//  SBTimer
//
//  Created by Master on 2015/04/13.
//  Copyright (c) 2015年 net.masuhara. All rights reserved.
//

#import "SettingViewController.h"
#import "UIManager.h"

@interface SettingViewController () <UITableViewDataSource, UITableViewDelegate, ADBannerViewDelegate>

@end

@implementation SettingViewController {
    UISlider *volumeSlider;
    UISwitch *timeSetSwitch;
    IBOutlet UITableView *settingTableView;
    IBOutlet ADBannerView *bannerView;
    
    NSArray *cellNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    settingTableView.delegate = self;
    settingTableView.dataSource = self;
    cellNames = [NSArray arrayWithObjects:@"VolumeCell", @"SwitchCell", nil];
    
    [self initAdBannerView];
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
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cellNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName = [cellNames objectAtIndex:indexPath.row];
    UITableViewCell *cell = [settingTableView dequeueReusableCellWithIdentifier:cellName];
    volumeSlider = (UISlider *)[cell viewWithTag:1];
    timeSetSwitch = (UISwitch *)[cell viewWithTag:2];
    
    [self initSlider];
    return cell;
}


#pragma mark - iAd

- (void)initAdBannerView {
    bannerView.delegate = self;
    bannerView.backgroundColor = BG_COLOR;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    banner.hidden = NO;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
    NSLog(@"bannerViewActionDidFinish");
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    banner.hidden = YES;
}

#pragma mark - Private
- (void)initSlider {
    volumeSlider.minimumValue = 0;
    volumeSlider.maximumValue = 1;
    volumeSlider.value = 0.5;
    volumeSlider.continuous = YES;

    [volumeSlider addTarget:self
               action:@selector(valueChanged:)
     forControlEvents:UIControlEventValueChanged];
}

- (void)valueChanged:(UISlider *)sender
{
    MPMusicPlayerController *playerController = [MPMusicPlayerController systemMusicPlayer];
    [playerController setValue:@(sender.value) forKey:@"volume"];
}

@end
