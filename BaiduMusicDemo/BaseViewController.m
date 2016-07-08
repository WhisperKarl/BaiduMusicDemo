//
//  BaseViewController.m
//  BaiduMusicDemo
//
//  Created by Karl on 16/7/8.
//  Copyright © 2016年 Karl. All rights reserved.
//

#import "BaseViewController.h"
#import "Reachability.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    
    [self.navigationController.navigationBar setBarTintColor:Green_Color];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reachabilityChanged:(NSNotification *)note{
    
    
    Reachability *reachAbility = [note object];
    NetworkStatus status = [reachAbility currentReachabilityStatus];
    if (status == NotReachable) {
        //无可用网络
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"当前网络不可用" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

@end
