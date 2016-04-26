//
//  ViewController.m
//  My_Line
//
//  Created by 小新 on 16/4/15.
//  Copyright © 2016年 小新. All rights reserved.
//

#import "ViewController.h"
#import "XXPlot.h"
#import "XXLineChartView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    XXLineChartView *lineView = [[XXLineChartView alloc] initWithFrame:self.view.bounds];
    XXPlot *plot1 = [[XXPlot alloc] init];
    plot1.plottingValues = @[@"10", @"20", @"15", @"46", @"79", @"99", @"34", @"74", @"1"];
    plot1.xAxisValues = @[@"100", @"200", @"300", @"400", @"500", @"600", @"700", @"800", @"900"];
    plot1.lineColor = [UIColor greenColor];
    plot1.pointColor = [UIColor yellowColor];
    plot1.lineWidth = 1;
    [lineView addPlot:plot1];
    [self.view addSubview:lineView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
