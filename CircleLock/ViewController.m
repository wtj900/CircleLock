//
//  ViewController.m
//  CircleLock
//
//  Created by 王史超 on 2018/11/21.
//  Copyright © 2018 offcn. All rights reserved.
//

#import "ViewController.h"
#import "OQCircleProgressView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    OQCircleProgressView *circleProgressView = [[OQCircleProgressView alloc] initWithRadius:100];
    circleProgressView.frame = CGRectMake(100, 100, 200, 200);
    [self.view addSubview:circleProgressView];

}

@end
