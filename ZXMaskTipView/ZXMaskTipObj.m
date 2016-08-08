//
//  ZXMaskTipObj.m
//  ZXMaskTipView
//
//  Created by Zhang, Xiang(Xiang) on 8/5/16.
//  Copyright © 2016 xiangzhangkg. All rights reserved.
//

#import "ZXMaskTipObj.h"

@implementation ZXMaskTipObj

- (instancetype)init {
    self = [super init];
    if (self) {
        _frame = CGRectNull;
        _cornerRadius = -1.f;
    }
    return self;
}

#pragma mark = Getter

- (CGRect)frame {
    if (CGRectEqualToRect(_frame, CGRectNull)) {
        return [_view.superview convertRect:_view.frame toView:[[UIApplication sharedApplication].delegate window]];
    }
    
    return _frame;
}

- (CGFloat)cornerRadius {
    if (_cornerRadius == -1.f) {
        return _view.layer.cornerRadius;
    }
    
    return _cornerRadius;
}

@end
