//
//  JADSKScrollingNode.m
//  FirstLetters
//
//  Created by Jennifer Dobson on 7/25/14.
//  Copyright (c) 2014 Jennifer Dobson. All rights reserved.
//

#import "Crealings-Bridging-Header.h"


@interface JADSKScrollingNode()

@property (nonatomic) CGFloat minXPosition;
@property (nonatomic) CGFloat maxXPosition;
@property (nonatomic, strong) UIPanGestureRecognizer *gestureRecognizer;
@property (nonatomic) CGFloat xOffset;

@end


static const CGFloat kScrollDuration = .3;

@implementation JADSKScrollingNode

-(id)initWithSize:(CGSize)size
{
    self = [super init];
    
    if (self)
    {
        _size = size;
        _xOffset = [self calculateAccumulatedFrame].origin.x;
       
    }
    return self;
    
}

-(void)addChild:(SKNode *)node
{
    [super addChild:node];
    _xOffset = [self calculateAccumulatedFrame].origin.x;
}


-(CGFloat) minXPosition
{
    CGSize parentSize = self.parent.frame.size;
    
  
    CGFloat minPosition =(parentSize.height - [self calculateAccumulatedFrame].size.width - _xOffset);
    
    return minPosition;
    
    
}

-(CGFloat) maxXPosition
{
    return 0;
}

-(void)scrollToBottom
{
    self.position = CGPointMake(0, self.maxXPosition);
    
}

-(void)scrollToTop
{
    self.position = CGPointMake(0, self.minXPosition);
    
}

-(void)enableScrollingOnView:(UIView*)view
{
    if (!_gestureRecognizer) {
        _gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
        _gestureRecognizer.delegate = self;
        [view addGestureRecognizer:self.gestureRecognizer];
        }
}

-(void)disableScrollingOnView:(UIView*)view
{
    if (_gestureRecognizer) {
        [view removeGestureRecognizer:_gestureRecognizer];
        _gestureRecognizer = nil;
    }
}

-(void)handlePanFrom:(UIPanGestureRecognizer*)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = CGPointMake(translation.x, -translation.y);
        [self panForTranslation:translation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [recognizer velocityInView:recognizer.view];
        CGPoint pos = self.position;
        CGPoint p = mult(velocity, kScrollDuration);
        
        CGPoint newPos = CGPointMake(pos.x - p.x, pos.y);
        newPos = [self constrainStencilNodesContainerPosition:newPos];
        
        SKAction *moveTo = [SKAction moveTo:newPos duration:kScrollDuration];
        //SKAction *moveMask = [SKAction moveTo:[self maskPositionForNodePosition:newPos] duration:kScrollDuration];
        [moveTo setTimingMode:SKActionTimingEaseOut];
        //[moveMask setTimingMode:SKActionTimingEaseOut];
        [self runAction:moveTo];
        //[self.maskNode runAction:moveMask];
        
    }
    
}



-(void)panForTranslation:(CGPoint)translation
{
    self.position = CGPointMake(self.position.x + translation.x, self.position.y);
}

- (CGPoint)constrainStencilNodesContainerPosition:(CGPoint)position {
    
    CGPoint retval = position;
    
    retval.x = self.position.x;
    
    retval.x = MAX(retval.x, self.minXPosition);
    retval.x = MIN(retval.x, self.maxXPosition);
    
    
    return retval;
}


CGPoint mult(const CGPoint v, const CGFloat s) {
	return CGPointMake(v.x*s, v.y*s);
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    SKNode* grandParent = self.parent.parent;
    
    if (!grandParent) {
        grandParent = self.parent;
    }
    CGPoint touchLocation = [touch locationInNode:grandParent];
    
    if (!CGRectContainsPoint(self.parent.frame,touchLocation)){
        return NO;
    }
    
    return YES;
}

@end
