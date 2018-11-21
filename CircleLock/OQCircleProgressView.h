//
//  OQCircleProgressView.h
//  OffcnQuestions
//
//  Created by 王史超 on 2017/8/11.
//  Copyright © 2017年 offcn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSAttributedString * _Nonnull (^OQAttributedFormatBlock)(CGFloat currentNumber);

@interface OQCircleProgressView : UIView

- (instancetype _Nullable)initWithRadius:(CGFloat)radius;

/**
 进度条背景颜色
 */
@property (nonatomic, strong) UIColor  * _Nullable backColor;
/**
 进度条颜色
 */
@property (nonatomic, strong) UIColor * _Nullable progressColor;
/**
 进度条宽度
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 进度
 */
@property (nonatomic, assign) CGFloat progress;

///**
// 设置进度
//
// @param to 进度终点
// @param format 格式
// */
//- (void)progressTo:(CGFloat)to format:(OQAttributedFormatBlock _Nonnull)format;
//
///**
// 设置进度
//
// @param to 进度终点
// @param animated 是否有动画
// @param format 格式
// */
//- (void)progressTo:(CGFloat)to animated:(BOOL)animated format:(OQAttributedFormatBlock _Nonnull)format;
//
///**
// 设置进度
//
// @param from 进度起始点
// @param to 进度终点
// @param end 进度总数
// @param duration 动画时长
// @param animated 是否有动画
// @param format 格式
// */
//- (void)progressFrom:(CGFloat)from to:(CGFloat)to end:(CGFloat)end duration:(CFTimeInterval)duration animated:(BOOL)animated format:(OQAttributedFormatBlock _Nonnull)format;

@end

