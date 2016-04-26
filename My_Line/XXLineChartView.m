//
//  XXLineChartView.m
//  My_Line
//
//  Created by 小新 on 16/4/15.
//  Copyright © 2016年 小新. All rights reserved.
//

#import "XXLineChartView.h"
#import "XXPlot.h"

@interface XXLineChartView()

@property (nonatomic, strong) NSMutableArray *plots;

@end

@implementation XXLineChartView


- (instancetype)init {
    if((self = [super init])) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [self commonInit];
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (NSMutableArray *)plots {
    if (!_plots) {
        _plots = [NSMutableArray new];
    }
    return _plots;
}

- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];
    self.font_name              = @"Helvetica";
    self.point_size             = CGSizeMake(4.0f, 4.0f);
    self.line_width             = 2.0f;
    
    
    self.y_axis_text_number     = 10;
    
    self.y_axis_line_space      = 10.0f;
    self.y_axis_line_width      = 1.0f;
    self.y_axis_font_size       = 10.0f;
    self.y_axis_maxValue        = @"100";
    self.y_axis_minValue        = @"0";
    self.y_axis_left_space      = 20.0f;
    self.y_axis_text_space      = 10.0f;
    
    
    
    self.x_axis_line_space      = 20;
    self.x_axis_line_width      = 1.0f;
    self.x_axis_font_size       = 10.0f;
    self.x_axis_text_space      = 10.0f;
    
    self.x_axis_color = [UIColor orangeColor];
    self.x_axis_text_color = [UIColor blackColor];
    self.y_axis_color = [UIColor blueColor];
    self.y_axis_text_color = [UIColor purpleColor];
    
}

- (void)addPlot:(XXPlot *)newPlot {
    
    [self layoutIfNeeded];
    if(nil == newPlot ) {
        return;
    }
    
    if ([newPlot.plottingValues count] ==0) {
        return;
    }
    
    [self.plots addObject:newPlot];
    
    [self layoutIfNeeded];
}

-(void)drawRect:(CGRect)rect {
    
    CGFloat y_axis_maxValue_width = [self widthWithString:self.y_axis_maxValue FontSize:self.y_axis_font_size];
    ;
    
    CGFloat interval = (([self.y_axis_maxValue floatValue] - [self.y_axis_minValue floatValue])/10);
    
    CGFloat line_start_x = y_axis_maxValue_width + self.y_axis_text_space;
    CGFloat line_start_y = 30;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0f , self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    /* 画X轴与X周文字 */
    for (NSInteger i=0; i < self.y_axis_text_number + 1; i++) {
        [self.x_axis_color set];
        NSInteger height = self.x_axis_line_space*i + line_start_y;
        CGContextSetLineWidth(context, self.x_axis_line_width);
        CGContextMoveToPoint(context, line_start_x, height);
        CGContextAddLineToPoint(context, self.frame.size.width - line_start_x, height);
        CGContextStrokePath(context);

        
        NSMutableArray *yAxisValues = [NSMutableArray new];
        for (int i = 0; i < self.y_axis_text_number + 1; i++) {
            NSString *str = [NSString stringWithFormat:@"%.f", [self.y_axis_minValue floatValue] + interval * i];
            [yAxisValues addObject:str];
        }
        
//        NSNumber *yAxisVlue = [NSNumber numberWithInteger:i+1];
        NSString *numberString = [NSString stringWithFormat:@"%@", yAxisValues[i]];
        NSInteger count = [numberString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        [self.x_axis_text_color set];
        CGContextSelectFont(context, [self.font_name UTF8String], self.y_axis_font_size, kCGEncodingMacRoman);
        CGContextShowTextAtPoint(context, 5, height - self.y_axis_font_size/2, [numberString UTF8String], count);
        
    }
    
    for (int i = 0; i < self.plots.count; i++) {
        
        XXPlot* plot = [self.plots objectAtIndex:i];
        [plot.lineColor set];
        CGContextSetLineWidth(context, plot.lineWidth);
        NSArray *pointArray = plot.plottingValues;
        
        CGFloat pointerInterval = (self.frame.size.width - 2 * line_start_x)/(pointArray.count - 1);
        
        CGContextSelectFont(context, [self.font_name UTF8String], self.y_axis_font_size, kCGEncodingMacRoman);
        for (NSInteger i=0; i < plot.xAxisValues.count; i++) {
            CGFloat width = pointerInterval*(i) + line_start_x;
            CGFloat height = self.x_axis_line_space * self.y_axis_text_number + line_start_y;
            /* 设置纵轴颜色 */
            [self.y_axis_color set];
            CGContextSetLineWidth(context, self.x_axis_line_width);
            CGContextMoveToPoint(context, width, line_start_y);
            CGContextAddLineToPoint(context, width, height);
            CGContextStrokePath(context);
            
            NSInteger count = [[plot.xAxisValues objectAtIndex:i] lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            CGFloat width1 = [self widthWithString:[plot.xAxisValues objectAtIndex:i] FontSize:self.x_axis_font_size];
            [self.y_axis_text_color set];
            CGContextShowTextAtPoint(context, width - width1/2, 10, [[plot.xAxisValues objectAtIndex:i] UTF8String], count);
        }
        
        // draw lines
        /** 画折线 */
        for (NSInteger i=0; i < pointArray.count; i++) {
            CGFloat floatValue = [[pointArray objectAtIndex:i] floatValue];
            CGFloat height = (floatValue - [self.y_axis_minValue floatValue]) / interval * self.x_axis_line_space + line_start_y;
            CGFloat width = pointerInterval*(i) + line_start_x;
            [plot.lineColor set];
            if (i==0) {
                CGContextMoveToPoint(context,  width, height);
            } else {
                CGContextAddLineToPoint(context, width, height);
            }
            
            
        }
        
        CGContextStrokePath(context);
        
        // draw pointer
        /* 画点 */
        for (NSInteger i=0; i < pointArray.count; i++) {
            CGFloat floatValue = [[pointArray objectAtIndex:i] floatValue];
            CGFloat height = (floatValue - [self.y_axis_minValue floatValue]) / interval * self.x_axis_line_space + line_start_y;
            CGFloat width = pointerInterval*(i) + line_start_x;
            [plot.pointColor set];
            CGContextFillEllipseInRect(context, CGRectMake(width-self.point_size.width/2, height - self.point_size.height/2, self.point_size.width, self.point_size.height));
        }
        
        CGContextStrokePath(context);
        
    }
    
    
    
}

- (CGFloat)widthWithString:(NSString *)string FontSize:(CGFloat)fontSize {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize textSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
//    labelSize.height = ceil(labelSize.height);
    textSize.width = ceil(textSize.width);
    return textSize.width;
}

- (CGFloat)heightWithString:(NSString *)string FontSize:(CGFloat)fontSize {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize textSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    //    labelSize.height = ceil(labelSize.height);
    textSize.height = ceil(textSize.height);
    return textSize.height;
}

@end
