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
    
    OQCircleProgressView *progressView = [[OQCircleProgressView alloc] initWithRadius:100];
    progressView.center = CGPointMake(200, 200);
//    progressView.progress = 0.35;
    [self.view addSubview:progressView];
    
    
    
}


@end
