//
//  ZXMaskTipObj.h
//  ZXMaskTipView
//
//  Created by Zhang, Xiang(Xiang) on 8/5/16.
//  Copyright © 2016 xiangzhangkg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    // for action blend mode
    ZXMaskTipType_Blend,
    // for action cover mode
    ZXMaskTipType_Cover,
    // for page mode
    ZXMaskTipType_Page,
} ZXMaskTipType;

@interface ZXMaskTipObj : NSObject

// required
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *tip;
// required when ZXMaskTipType_Blend or ZXMaskTipType_Cover
@property (nonatomic, strong) UIView *view;
// optional
@property (nonatomic, assign) ZXMaskTipType type;
// customize coverView different from view when SkyMaskTipType_Cover if necessary
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *maskColor;
@property (nonatomic, strong) UIColor *tipBgColor;
@property (nonatomic, strong) UIColor *tipColor;
@property (nonatomic, strong) UIFont *tipFont;

@end
