//
//  OQCircleProgressView.m
//  OffcnQuestions
//
//  Created by 王史超 on 2017/8/11.
//  Copyright © 2017年 offcn. All rights reserved.
//

#import "OQCircleProgressView.h"

static const CGFloat kCircleWidth = 8.0;

#define kBackColor [UIColor grayColor]
#define kProgressColor [UIColor blueColor]

@interface OQCircleProgressView ()

@property (nonatomic, strong) CAShapeLayer *backLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UIView *touchView;
@property (nonatomic, assign) BOOL canuse;

@end


@implementation OQCircleProgressView

- (instancetype _Nullable)initWithRadius:(CGFloat)radius {
    self = [super initWithFrame:CGRectMake(0, 0, radius * 2, radius * 2)];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    CGPoint center = CGPointMake(CGRectGetWidth(self.bounds) * 0.5, CGRectGetHeight(self.bounds) * 0.5);
    CGFloat radius = (CGRectGetWidth(self.bounds) - kCircleWidth) * 0.5;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:-M_PI_2 endAngle:M_PI_2 + M_PI clockwise:YES];
    
    self.backLayer = [self createCircleLayerWithPath:path strokeColor:kBackColor];
    self.progressLayer = [self createCircleLayerWithPath:path strokeColor:kProgressColor];
    self.progressLayer.strokeEnd = 0;
    
    self.touchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.touchView.center = CGPointMake(self.frame.size.width * 0.5, kCircleWidth * 0.5);
    self.touchView.backgroundColor = [UIColor redColor];
    [self addSubview:_touchView];
    
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)]];
    
}

- (void)panGesture:(UIPanGestureRecognizer *)gesture {
    
    CGPoint point = [gesture locationInView:self];
    NSLog(@"%@",NSStringFromCGPoint([gesture translationInView:self]));
    if (!self.canuse && CGRectContainsPoint(CGRectMake(self.bounds.size.width * 0.5, 0, self.bounds.size.width * 0.5, self.bounds.size.height), point)) {
        self.canuse = YES;
    }

    if (!self.canuse) {
        return;
    }
    
    if (self.progress <= 0.01 && [gesture translationInView:self].x <= 0) {
        return;
    }
    
    [gesture setTranslation:CGPointZero inView:self];
    
    switch (gesture.state) {
            case UIGestureRecognizerStateBegan:
            case UIGestureRecognizerStateChanged: {
                [self caculateProgressWithPoint:point];
            }
            break;
        default: {
            if (self.progress < 0.99) {
                [self caculateProgressWithPoint:CGPointMake(self.frame.size.width * 0.5, kCircleWidth * 0.5)];
            }
        }
            break;
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    UITouch *touch = touches.allObjects.firstObject;
    CGPoint point = [touch locationInView:self];
    self.canuse = CGRectContainsPoint(CGRectMake(self.bounds.size.width * 0.5, 0, self.bounds.size.width * 0.5, self.bounds.size.height), point);
    if (self.canuse) {
        [self caculateProgressWithPoint:point];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    NSLog(@"touchesEnded");
    if (self.progress < 0.99) {
        [self caculateProgressWithPoint:CGPointMake(self.frame.size.width * 0.5, kCircleWidth * 0.5)];
    }
}


- (void)caculateProgressWithPoint:(CGPoint)point {
    
    CGFloat radius = (CGRectGetWidth(self.bounds) - kCircleWidth) * 0.5;
    CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.width * 0.5);
    CGFloat angle = [self angleWithCenter:center currentPoint:point];
    self.progress = [self progressWithAngle:angle];
    self.touchView.center = [self circleRadius:radius center:center currentPoint:point];
}

- (CGFloat)angleWithCenter:(CGPoint)center currentPoint:(CGPoint)currentPoint {
    return atan2f(center.y - currentPoint.y, currentPoint.x - center.x);
}

- (CGPoint)circleRadius:(CGFloat)radius center:(CGPoint)center currentPoint:(CGPoint)currentPoint {
    
    // 圆心与触控点的距离（勾股定理）
    CGFloat distance = hypotf(currentPoint.x - center.x, currentPoint.y - center.y);
    // 圆心水平方向与转动按钮形成的夹角的cos值
    CGFloat cosθ = (currentPoint.x - center.x) / distance;
    // 圆心垂直方向与转动按钮形成的夹角的sin值
    CGFloat sinθ = (center.y - currentPoint.y) / distance;
    // 圆的X坐标轨迹
    CGFloat cX = center.x + cosθ * radius;
    //圆的Y坐标轨迹
    CGFloat cY = center.y - sinθ * radius;
    
    CGPoint cPoint = CGPointMake(cX, cY);
    
    return cPoint;
}

- (CGFloat)progressWithAngle:(CGFloat)angle {
    
    CGFloat progress = 0;
    
    if (floor(angle * 1000000) <= floor(M_PI_2 * 1000000)) {
        progress = (M_PI_2 - angle) / (M_PI * 2);
    }
    else {
        progress = (M_PI + M_PI_2 + M_PI - angle) / (M_PI * 2);
    }
    
    return progress;
}

// 绘制进度图
- (CAShapeLayer *)createCircleLayerWithPath:(UIBezierPath *)path
                                strokeColor:(UIColor *)strokeColor {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.contentsScale = [[UIScreen mainScreen] scale];
    shapeLayer.frame = self.bounds;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = strokeColor.CGColor;
    shapeLayer.lineWidth = kCircleWidth;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin = kCALineCapRound;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1;
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
    
    return shapeLayer;
}

- (void)setBackColor:(UIColor *)backColor {
    self.backLayer.strokeColor = backColor.CGColor;
}

- (void)setProgressColor:(UIColor *)progressColor {
    self.progressLayer.strokeColor = progressColor.CGColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    self.backLayer.lineWidth = lineWidth;
    self.progressLayer.lineWidth = lineWidth;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self startCircleAnimationWithDuration:0 toValue:progress];
}

- (void)startCircleAnimationWithDuration:(CGFloat)duration toValue:(CGFloat)toValue {
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.progressLayer.strokeEnd = toValue;
    [CATransaction commit];
}

@end

