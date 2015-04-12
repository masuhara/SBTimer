//
//  SoundViewController.m
//  SBTimer
//
//  Created by Master on 2015/04/13.
//  Copyright (c) 2015年 net.masuhara. All rights reserved.
//

#import "SoundViewController.h"

@interface SoundViewController () <UITableViewDelegate, UITableViewDataSource, MPMediaPickerControllerDelegate>

@end

@implementation SoundViewController {
    IBOutlet UITableView *soundTableView;
    NSArray *soundNameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    soundTableView.dataSource = self;
    soundTableView.delegate = self;
    
    soundNameArray = [NSArray arrayWithObjects:@"SelectFromLibrary", nil];
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

#pragma mark - TableView DataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return soundNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellName = [soundNameArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [soundTableView dequeueReusableCellWithIdentifier:cellName];
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [soundTableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self showMusicLibrary];
    }
}

- (void)showMusicLibrary {
    MPMediaPickerController *picker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    picker.delegate = self;
    picker.allowsPickingMultipleItems = NO;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - MPMediaPlayerDelegate

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker
  didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    
    for (MPMediaItem *item in mediaItemCollection.items) {
        NSString *title = [item valueForProperty:MPMediaItemPropertyTitle];
        NSLog(@"selected title:%@", title);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
