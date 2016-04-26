//
//  XXLineChartView.h
//  My_Line
//
//  Created by 小新 on 16/4/15.
//  Copyright © 2016年 小新. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXPlot;
@interface XXLineChartView : UIView

/* x轴颜色 */
@property (nonatomic, assign) UIColor     *x_axis_color;
/* y轴颜色 */
@property (nonatomic, assign) UIColor     *y_axis_color;

/* x轴文字颜色 */
@property (nonatomic, assign) UIColor     *x_axis_text_color;
/* y轴文字颜色 */
@property (nonatomic, assign) UIColor     *y_axis_text_color;

/* y轴文字个数，也就是x轴个数 */
@property (nonatomic, assign) CGFloat     y_axis_text_number;
//@property (nonatomic, assign) CGFloat     x_axis_text_number;

/* 文字与纵轴间间距 */
@property (nonatomic, assign) CGFloat     y_axis_text_space;

@property (nonatomic, assign) CGFloat     x_axis_text_space;

/* 纵轴距离左边间距 */
@property (nonatomic, assign) CGFloat     y_axis_left_space;

/* 纵轴最大值 */
@property (nonatomic, copy) NSString      *y_axis_maxValue;

/* 纵轴最小值 */
@property (nonatomic, copy) NSString      *y_axis_minValue;

/* 文字字体名 */
@property (nonatomic, copy) NSString      *font_name;

/* 点的尺寸 */
@property (nonatomic, assign) CGSize      point_size;

/* 折线线宽 */
@property (nonatomic, assign) CGFloat     line_width;

/* 各个横轴之间间隙大小 */
@property (nonatomic, assign) CGFloat     x_axis_line_space;

/* 横轴线宽 */
@property (nonatomic, assign) CGFloat     x_axis_line_width;

/* 横轴字号 */
@property (nonatomic, assign) CGFloat     x_axis_font_size;

/* 各个纵轴之间间隙大小 */
@property (nonatomic, assign) CGFloat     y_axis_line_space;

/* 纵轴线宽 */
@property (nonatomic, assign) CGFloat     y_axis_line_width;

/* 纵轴字号 */
@property (nonatomic, assign) CGFloat     y_axis_font_size;

/* 纵轴高度 */
@property (nonatomic, assign) CGFloat     y_axis_line_hight;

- (void)addPlot:(XXPlot *)newPlot;

@end
