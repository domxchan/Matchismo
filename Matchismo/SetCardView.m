//
//  SetCardView.m
//  Matchismo
//
//  Created by Dominic Chan on 3/3/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "SetCardView.h"
#import "SetCard.h"

@implementation SetCardView

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:12.0];
    
    [roundedRect addClip];

    if (self.faceUp){
        [[UIColor yellowColor] setFill];
    } else {
        [[UIColor clearColor] setFill];
    }
    UIRectFill(self.bounds);
    
    if (self.number == 1 || self.number == 3) {
        [self drawSymbol];
    }
    
    CGFloat hoffset;
    if (self.number == 2) {
        hoffset = self.bounds.size.height/16*3;
        [self drawSymmetryWithHOffset:hoffset];
    }
    
    if (self.number == 3) {
        hoffset = self.bounds.size.height/8*3;
        [self drawSymmetryWithHOffset:hoffset];
    }
}

- (void) drawSymmetryWithHOffset: (CGFloat) hoffset {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, -hoffset, 0);
    [self drawSymbol];
    CGContextTranslateCTM(context, hoffset*2, 0);
    [self drawSymbol];
    CGContextRestoreGState(context);
}

- (void)drawSymbol
{
    if (self.symbol == 0) {
        [self drawDiamond];
    } else if (self.symbol == 1) {
        [self drawOval];
    } else if (self.symbol == 2) {
        [self drawSquiggle];
    }
}

- (CGFloat)setAlpha {
    CGFloat alpha = 0;
    if (self.shading == 0) {  //solid
        alpha = 1;
    } else if (self.shading == 1) {  //stripped
        alpha = 0.2;
    } else if (self.shading == 2) {  //clear
        alpha = 0;
    }
    return alpha;
}

- (void)drawSquiggle
{
    CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat height = self.bounds.size.height;
    CGFloat hoffset1 = height/8;
    CGFloat voffset1 = height/8;
    [path moveToPoint:CGPointMake(middle.x-hoffset1, middle.y-voffset1)];
    [path addCurveToPoint:CGPointMake(middle.x+hoffset1/2, middle.y+voffset1/2)
            controlPoint1:CGPointMake(middle.x-hoffset1, middle.y-voffset1*2)
            controlPoint2:CGPointMake(middle.x+hoffset1*2, middle.y-voffset1*3)];
    [path addQuadCurveToPoint:CGPointMake(middle.x+hoffset1, middle.y+voffset1)
            controlPoint:CGPointMake(middle.x+hoffset1/2, middle.y+voffset1)];
    [path addCurveToPoint:CGPointMake(middle.x-hoffset1/2, middle.y-voffset1/2)
            controlPoint1:CGPointMake(middle.x+hoffset1, middle.y+voffset1*2)
            controlPoint2:CGPointMake(middle.x-hoffset1*2, middle.y+voffset1*3)];
    [path addQuadCurveToPoint:CGPointMake(middle.x-hoffset1, middle.y-voffset1)
                 controlPoint:CGPointMake(middle.x-hoffset1/2, middle.y-voffset1)];
    [[SetCard validColors][self.color] setStroke];
    [[[SetCard validColors][self.color] colorWithAlphaComponent:[self setAlpha]] setFill];
    [path stroke]; [path fill];
}

- (void)drawOval
{
    CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat height = self.bounds.size.height;
    [path moveToPoint:CGPointMake(middle.x-height/8, middle.y-height/8)];
    [path addArcWithCenter:CGPointMake(middle.x, middle.y-height/8) radius: height/8 startAngle:M_PI endAngle:0.0 clockwise:YES];
    [path addLineToPoint:CGPointMake(middle.x+height/8, middle.y+height/8)];
    [path addArcWithCenter:CGPointMake(middle.x, middle.y+height/8) radius: height/8 startAngle:0.0 endAngle:M_PI clockwise:YES];
    [path closePath];
    
    [[SetCard validColors][self.color] setStroke];
    [[[SetCard validColors][self.color] colorWithAlphaComponent:[self setAlpha]] setFill];
    [path stroke]; [path fill];
}

- (void)drawDiamond
{
    CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat height = self.bounds.size.height;
    [path moveToPoint:CGPointMake(middle.x, middle.y-height/4)];
    [path addLineToPoint:CGPointMake(middle.x+height/8, middle.y)];
    [path addLineToPoint:CGPointMake(middle.x, middle.y+height/4)];
    [path addLineToPoint:CGPointMake(middle.x-height/8, middle.y)];
    [path closePath];
    
    [[SetCard validColors][self.color] setStroke];
    [[[SetCard validColors][self.color] colorWithAlphaComponent:[self setAlpha]] setFill];
    [path stroke]; [path fill];
}

- (NSAttributedString *)attrContents {
    NSString *text = [@"" stringByPaddingToLength:self.number withString:[SetCard validSymbols][self.symbol] startingAtIndex:0];
    CGFloat alpha_val = 0.0;
    if ([[SetCard validShadings][self.shading] isEqualToString:@"solid"]) {
        alpha_val = 1.0;
    } else if ([[SetCard validShadings][self.shading] isEqualToString:@"stripped"]) {
        alpha_val = 0.15;
    }
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [[SetCard validColors][self.color] colorWithAlphaComponent: alpha_val],
                                 NSStrokeWidthAttributeName: @-5,
                                 NSStrokeColorAttributeName: [SetCard validColors][self.color]};
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    return attrText;
}

- (void) setNumber:(NSUInteger)number
{
    _number = number;
    [self setNeedsDisplay];
}

- (void)setSymbol:(NSUInteger)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];
}

- (void)setShading:(NSUInteger)shading
{
    _shading = shading;
    [self setNeedsDisplay];
}

- (void)setColor:(NSUInteger)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}


#pragma mark - Initialization

- (void) setup
{
    // do initialisation here
}

- (void) awakeFromNib
{
    [self setup];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
