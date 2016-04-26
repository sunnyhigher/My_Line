//
//  XXPlot.h
//  My_Line
//
//  Created by 小新 on 16/4/15.
//  Copyright © 2016年 小新. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XXPlot : NSObject

/* 数据数组 */
@property (nonatomic, strong) NSArray *plottingValues;

/* x轴文字 */

@property (nonatomic, strong) NSArray *xAxisValues;

/* 折线的颜色 */
@property (nonatomic, strong) UIColor *lineColor;

/* 点颜色 */
@property (nonatomic, strong) UIColor *pointColor;

/* 折线宽度 */
@property (nonatomic, assign) float lineWidth;

@end
