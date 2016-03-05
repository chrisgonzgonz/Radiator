//
//  RadiatorView.m
//  Radiator
//
//  Created by Chris Gonzales on 3/4/16.
//  Copyright © 2016 GNZ. All rights reserved.
//

#import "RadiatorView.h"

@interface RadiatorView ()
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSDate *baseDate;
@end
@implementation RadiatorView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor grayColor];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0 target:self selector:@selector(setNeedsDisplay) userInfo:self repeats:YES];
    self.baseDate = [NSDate new];
}

- (void)drawRect:(CGRect)rect
{
    CGFloat numCircles = 3;
    CGFloat baseStrokeWidth = 20;
    CGFloat size = rect.size.height;
    NSTimeInterval time = -[self.baseDate timeIntervalSinceNow]*10;
    for (NSUInteger x = 1; x<= numCircles; x++) {
        CGFloat unboundRadius = (x/numCircles)*size/2.0+time;
        CGFloat radius = (int)unboundRadius % (int)(size/2);
        radius += unboundRadius-floor(unboundRadius);

        CGFloat percent = MAX(0,(1-radius/(size/2)));
        NSLog(@"Radius: %f", percent);

        CGFloat strokeWidth = baseStrokeWidth*percent;
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(ctx, strokeWidth);
        CGContextAddEllipseInRect(ctx, CGRectMake(size/2.0-radius, size/2.0-radius, 2.0*radius, 2.0*radius));
        CGContextSetStrokeColor(ctx, CGColorGetComponents([[[UIColor blueColor] colorWithAlphaComponent:percent] CGColor]));
        CGContextStrokePath(ctx);
    }
}


@end
