//
//  ZXMaskTipView.m
//  ZXMaskTipView
//
//  Created by Zhang, Xiang(Xiang) on 8/5/16.
//  Copyright © 2016 xiangzhangkg. All rights reserved.
//

#import "ZXMaskTipView.h"
#import "ZXMaskTipObj.h"
#import <AMPopTip/AMPopTip.h>

#define kZXMaskTipViewMaskColorDefault          [[UIColor blackColor] colorWithAlphaComponent:.5f]
#define kZXMaskTipViewTipBgColorDefault         [UIColor whiteColor]
#define kZXMaskTipViewTipColorDefault           [UIColor blackColor]
#define kZXMaskTipViewTipFontDefault            [UIFont systemFontOfSize:14.f]

#define kZXMaskTipViewMaskColorDefault_Page     [UIColor clearColor]
#define kZXMaskTipViewTipBgColorDefault_Page    [[UIColor blackColor] colorWithAlphaComponent:.8f]
#define kZXMaskTipViewTipColorDefault_Page      [UIColor whiteColor]
#define kZXMaskTipViewTipFontDefault_Page       [UIFont systemFontOfSize:14.f]

#define kZXMaskTipViewShowCachePath         @"Documents/ZXMaskTipViewShowCache.plist"

static NSMutableDictionary *cacheDic = nil;

@interface ZXMaskTipView () {
    // draw one by one, this is current obj
    ZXMaskTipObj *_currentMaskTipObj;
    // current obj is page mode
    BOOL _currentIsPage;
    NSArray <ZXMaskTipObj *> *_maskTipObjArr;
    AMPopTip *_popTip;
    __weak UIWindow *_window;
}

@end

@implementation ZXMaskTipView

#pragma mark - Blend mode init

/**
 *  show mask for blend mode
 *
 *  @param aView       action view
 *  @param aIdentifier identifier
 *  @param aTip        tip
 */
+ (void)showBlendMaskWithView:(UIView *_Nonnull)aView
                andIdentifier:(NSString *_Nonnull)aIdentifier
                       andTip:(NSString *_Nonnull)aTip {
    [self showBlendMaskWithViewArr:@[aView] andIdentifierArr:@[aIdentifier] andTipArr:@[aTip]];
}

/**
 *  show mask for blend mode
 *
 *  @param aViewArr       action view array
 *  @param aIdentifierArr identifier array
 *  @param aTipArr        tip array
 */
+ (void)showBlendMaskWithViewArr:(NSArray <UIView *> *_Nonnull)aViewArr
                andIdentifierArr:(NSArray <NSString *> *_Nonnull)aIdentifierArr
                       andTipArr:(NSArray <NSString *> *_Nonnull)aTipArr {
    NSAssert(aViewArr.count == aIdentifierArr.count, @"aViewArr.count must be equal to aIdentifierArr.count");
    NSAssert(aViewArr.count == aTipArr.count, @"aViewArr.count must be equal to aTipArr.count");
    NSMutableArray <ZXMaskTipObj *> *maskTipObjArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < aViewArr.count; i++) {
        ZXMaskTipObj *maskTipObj = [[ZXMaskTipObj alloc] init];
        maskTipObj.view = aViewArr[i];
        maskTipObj.identifier = aIdentifierArr[i];
        maskTipObj.tip = aTipArr[i];
        maskTipObj.type = ZXMaskTipType_Blend;
        [maskTipObjArr addObject:maskTipObj];
    }
    [self showMaskWithMaskTipObjArr:[NSArray arrayWithArray:maskTipObjArr]];
}

#pragma mark - Cover mode init

/**
 *  show mask for cover mode
 *
 *  @param aView       action view
 *  @param aIdentifier identifier
 *  @param aTip        tip
 */
+ (void)showCoverMaskWithView:(UIView *_Nonnull)aView
                andIdentifier:(NSString *_Nonnull)aIdentifier
                       andTip:(NSString *_Nonnull)aTip {
    [self showCoverMaskWithViewArr:@[aView] andIdentifierArr:@[aIdentifier] andTipArr:@[aTip]];
}

/**
 *  show mask for cover mode
 *
 *  @param aViewArr       action view array
 *  @param aIdentifierArr identifier array
 *  @param aTipArr        tip array
 */
+ (void)showCoverMaskWithViewArr:(NSArray <UIView *> *_Nonnull)aViewArr
                andIdentifierArr:(NSArray <NSString *> *_Nonnull)aIdentifierArr
                       andTipArr:(NSArray <NSString *> *_Nonnull)aTipArr {
    NSAssert(aViewArr.count == aIdentifierArr.count, @"aViewArr.count must be equal to aIdentifierArr.count");
    NSAssert(aViewArr.count == aTipArr.count, @"aViewArr.count must be equal to aTipArr.count");
    NSMutableArray <ZXMaskTipObj *> *maskTipObjArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < aViewArr.count; i++) {
        ZXMaskTipObj *maskTipObj = [[ZXMaskTipObj alloc] init];
        maskTipObj.view = aViewArr[i];
        maskTipObj.identifier = aIdentifierArr[i];
        maskTipObj.tip = aTipArr[i];
        maskTipObj.type = ZXMaskTipType_Cover;
        [maskTipObjArr addObject:maskTipObj];
    }
    [self showMaskWithMaskTipObjArr:[NSArray arrayWithArray:maskTipObjArr]];
}

#pragma mark - Page mode init

/**
 *  show mask for page mode
 *
 *  @param aIdentifier identifier
 *  @param aTip        tip
 */
+ (void)showPageMaskWithIdentifier:(NSString *_Nonnull)aIdentifier
                            andTip:(NSString *_Nonnull)aTip {
    __weak UIWindow *window = [[UIApplication sharedApplication].delegate window];
    ZXMaskTipObj *maskTipObj = [[ZXMaskTipObj alloc] init];
    maskTipObj.identifier = aIdentifier;
    maskTipObj.tip = aTip;
    maskTipObj.type = ZXMaskTipType_Page;
    maskTipObj.frame = CGRectMake(0.f, CGRectGetHeight(window.frame), CGRectGetWidth(window.frame), 1.f);
    [self showMaskWithMaskTipObj:maskTipObj];
}

#pragma mark - Custom mode init

/**
 *  show mask
 *
 *  @param aMaskTipObj ZXMaskTipObj
 */
+ (void)showMaskWithMaskTipObj:(ZXMaskTipObj *_Nonnull)aMaskTipObj {
    [self showMaskWithMaskTipObjArr:@[aMaskTipObj]];
}

/**
 *  show mask
 *
 *  @param aMaskTipArr ZXMaskTipObj array
 */
+ (void)showMaskWithMaskTipObjArr:(NSArray <ZXMaskTipObj *> *_Nonnull)aMaskTipArr {
    NSArray <ZXMaskTipObj *> *needShowMaskTipObjArr = [self filterForNeedShowMaskWithMaskTipObjArr:aMaskTipArr];
    if (needShowMaskTipObjArr.count > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __weak UIWindow *window = [[UIApplication sharedApplication].delegate window];
            ZXMaskTipView *maskTipView = [[ZXMaskTipView alloc] initWithFrame:window.frame andMaskTipObjArr:needShowMaskTipObjArr];
            [window addSubview:maskTipView];
        });
    }
}

#pragma mark - Private class method

/**
 *  filter need show mask
 *
 *  @param aMaskTipObjArr all origin ZXMaskTipObj array
 *
 *  @return need show ZXMaskTipObj array
 */
+ (NSArray <ZXMaskTipObj *> *)filterForNeedShowMaskWithMaskTipObjArr:(NSArray <ZXMaskTipObj *> *_Nonnull)aMaskTipObjArr {
    cacheDic = [self getCacheDic];
    NSMutableArray <ZXMaskTipObj *> *resultArr = [[NSMutableArray alloc] init];
    for (ZXMaskTipObj *aMaskTipObj in aMaskTipObjArr) {
        NSNumber *cached = cacheDic[aMaskTipObj.identifier];
        if (cached == nil || cached.boolValue == NO) {
            [resultArr addObject:aMaskTipObj];
        }
    }
    
    return [NSArray arrayWithArray:resultArr];
}

/**
 *  get showed mask cache dictionary
 *
 *  @return NSMutableDictionary
 */
+ (NSMutableDictionary *)getCacheDic {
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:kZXMaskTipViewShowCachePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createFileAtPath:path contents:nil attributes:nil];
        NSMutableDictionary *emptyCacheDic = [[NSMutableDictionary alloc] init];
        [emptyCacheDic writeToFile:path atomically:YES];
    }
    
    return [[NSMutableDictionary alloc] initWithContentsOfFile:path];
}

/**
 *  set mask has be showed
 *
 *  @param aMaskTipObj ZXMaskTipObj
 */
+ (void)setCacheDicWithMaskTipObj:(ZXMaskTipObj *)aMaskTipObj {
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:kZXMaskTipViewShowCachePath];
    [cacheDic setObject:@(YES) forKey:aMaskTipObj.identifier];
    [cacheDic writeToFile:path atomically:YES];
}

#pragma mark - Instance method

- (instancetype)initWithFrame:(CGRect)frame
             andMaskTipObjArr:(NSArray <ZXMaskTipObj *> *_Nonnull)aMaskTipObjArr {
    self = [super initWithFrame:frame];
    if (self) {
        // data
        _maskTipObjArr = [NSArray arrayWithArray:aMaskTipObjArr];
        _currentMaskTipObj = _maskTipObjArr[0];
        _currentIsPage = _currentMaskTipObj.type == ZXMaskTipType_Page;
        _window = [[UIApplication sharedApplication].delegate window];
        [self setupDefaultStyle];
        [self setupUI];
    }
    return self;
}

/**
 *  setup default style
 */
- (void)setupDefaultStyle {
    self.backgroundColor = [UIColor clearColor];
    _maskColor = _maskColor ? _maskColor : (_currentIsPage ? kZXMaskTipViewMaskColorDefault_Page : kZXMaskTipViewMaskColorDefault);
    _tipBgColor = _tipBgColor ? _tipBgColor : (_currentIsPage ? kZXMaskTipViewTipBgColorDefault_Page : kZXMaskTipViewTipBgColorDefault);
    _tipColor = _tipColor ? _tipColor : (_currentIsPage ? kZXMaskTipViewTipColorDefault_Page : kZXMaskTipViewTipColorDefault);
    _tipFont = _tipFont ? _tipFont : (_currentIsPage ? kZXMaskTipViewTipFontDefault_Page : kZXMaskTipViewTipFontDefault);
}

/**
 *  set up UI
 */
- (void)setupUI {
    // appearance
    AMPopTip *appearance = [AMPopTip appearance];
    appearance.popoverColor = _tipBgColor;
    appearance.textColor = _tipColor;
    // view
    _popTip = [AMPopTip popTip];
    _popTip.font = _tipFont;
    _popTip.shouldDismissOnTap = NO;
    _popTip.shouldDismissOnTapOutside = NO;
    _popTip.shouldDismissOnSwipeOutside = NO;
    _popTip.actionAnimation = _currentIsPage ? AMPopTipActionAnimationNone : AMPopTipActionAnimationBounce;
    if (_currentIsPage) {
        _popTip.radius = 0.f;
    }
    if (!_currentIsPage) {
        __weak __typeof(self) wSelf = self;
        
        _popTip.tapHandler = ^{
            [wSelf dismissMaskTipView];
        };
    }
}

/**
 *  duplicate view
 *
 *  @param aView origin view
 *
 *  @return new view
 */
- (UIView *)duplicateView:(UIView *)aView {
    // TODO: Survey reason. can not use archiver, because reset the duplicated view's frame will have no effect, the origin always be {0, 0}
    //    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:aView];
    //    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return [aView snapshotViewAfterScreenUpdates:NO];
}

/**
 *  add cover view
 */
- (void)addCoverView {
    UIView *coverView = [self duplicateView:_currentMaskTipObj.view];
    coverView.frame = _currentMaskTipObj.frame;
    coverView.userInteractionEnabled = NO;
    [self addSubview:coverView];
}

/**
 *  add close when page mode
 */
- (void)addCloseBtnOnPageMask {
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(CGRectGetWidth(_popTip.frame) - 12.f - 15.f, 10.f, 15.f, 15.f);
    [closeBtn setTitle:@"X" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(dismissMaskTipView) forControlEvents:UIControlEventTouchUpInside];
    [_popTip addSubview:closeBtn];
}

/**
 *  show pop tip
 */
- (void)showPopTipWithMaskTipObj {
    CGRect frame = _currentMaskTipObj.frame;
    CGFloat maxWidth;
    AMPopTipDirection direction;
    if (_currentIsPage) {
        // FIXME: a 3rdparty bug, can not place pop and text in center when maxWidth is window width
        maxWidth = CGRectGetWidth(_window.frame) - 64.f;
        //        maxWidth = CGRectGetWidth(_window.frame);
        direction = AMPopTipDirectionUp;
        _popTip.offset = -8.f;
        _popTip.edgeInsets = UIEdgeInsetsMake(15.f, 32.f, 15.f, 32.f);
    } else {
        maxWidth = CGRectGetWidth(_window.frame) / 2.f;
        CGFloat top = CGRectGetMinY(frame);
        CGFloat bottom = CGRectGetHeight(_window.frame) - CGRectGetMaxY(frame);
        CGFloat left = CGRectGetMinX(frame);
        CGFloat right = CGRectGetWidth(_window.frame) - CGRectGetMaxX(frame);
        CGFloat max = MAX(MAX(top, bottom), MAX(left, right));
        if (max == top) {
            direction = AMPopTipDirectionUp;
            _popTip.bubbleOffset = -25.f;
        } else if (max == bottom) {
            direction = AMPopTipDirectionDown;
            _popTip.bubbleOffset = 25.f;
        } else if (max == left) {
            direction = AMPopTipDirectionLeft;
            _popTip.bubbleOffset = -25.f;
        } else if (max == right) {
            direction = AMPopTipDirectionRight;
            _popTip.bubbleOffset = 25.f;
        }
        _popTip.offset = 10.f;
    }
    _popTip.popoverColor = _currentMaskTipObj.tipBgColor ? _currentMaskTipObj.tipBgColor : _tipBgColor;
    _popTip.textColor = _currentMaskTipObj.tipColor ? _currentMaskTipObj.tipColor : _tipColor;
    _popTip.font = _currentMaskTipObj.tipFont ? _currentMaskTipObj.tipFont : _tipFont;
    [_popTip showText:_currentMaskTipObj.tip direction:direction maxWidth:maxWidth inView:self fromFrame:frame];
}

/**
 *  dismiss mask
 */
- (void)dismissMaskTipView {
    [self.class setCacheDicWithMaskTipObj:_currentMaskTipObj];
    [_popTip hide];
    [self removeFromSuperview];
}

- (void)drawRect:(CGRect)rect {
    // need call show pop first, because close btn need pop's frame
    [self showPopTipWithMaskTipObj];
    
    // draw mask
    [_maskColor setFill];
    UIRectFill(rect);
    
    // draw one by one
    switch (_currentMaskTipObj.type) {
            // draw blend view
        case ZXMaskTipType_Blend: {
            CGRect intersectionRect = CGRectIntersection(_currentMaskTipObj.frame, self.frame);
            UIColor *blendColor = [UIColor clearColor];
            [blendColor setFill];
            UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:intersectionRect cornerRadius:_currentMaskTipObj.cornerRadius];
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetFillColorWithColor(context, blendColor.CGColor);
            CGContextAddPath(context, bezierPath.CGPath);
            CGContextSetBlendMode(context, kCGBlendModeClear);
            CGContextFillPath(context);
            
            break;
        }
            
        case ZXMaskTipType_Cover: {
            [self addCoverView];
            
            break;
        }
            
        case ZXMaskTipType_Page: {
            [self addCloseBtnOnPageMask];
            
            break;
        }
            
        default:
            break;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *resultView = [super hitTest:point withEvent:event];
    if (resultView == self) {
        if (!_currentIsPage) {
            [self dismissMaskTipView];
            for (ZXMaskTipObj *aMaskTipObj in _maskTipObjArr) {
                if (CGRectContainsPoint(aMaskTipObj.frame, point)) {
                    return aMaskTipObj.view;
                }
            }
        }
    }
    
    return resultView;
}

@end
