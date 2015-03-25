//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#if TARGET_OS_IPHONE
#define DSMultiLineLabelImage UIImage
#define DSMultiLineLabelFont UIFont
#else
#define DSMultiLineLabelImage NSImage
#define DSMultiLineLabelFont NSFont
#endif


#import <SpriteKit/SpriteKit.h>

@interface DSMultilineLabelNode : SKSpriteNode

@property(retain, nonatomic) SKColor *fontColor;
@property(copy, nonatomic) NSString *fontName;
@property(nonatomic) CGFloat fontSize;
@property(nonatomic) SKLabelHorizontalAlignmentMode horizontalAlignmentMode;
@property(copy, nonatomic) NSString *text;
@property(nonatomic) SKLabelVerticalAlignmentMode verticalAlignmentMode;
@property(nonatomic, assign) CGFloat paragraphWidth;

+ (instancetype)labelNodeWithFontNamed:(NSString *)fontName;
- (instancetype)initWithFontNamed:(NSString *)fontName;


@end

@interface JADSKScrollingNode : SKNode <UIGestureRecognizerDelegate>


@property (nonatomic) CGSize size;

-(id)initWithSize:(CGSize)size;
-(void)scrollToTop;
-(void)scrollToBottom;
-(void)enableScrollingOnView:(UIView*)view;
-(void)disableScrollingOnView:(UIView*)view;

@end