//
//  ZXMaskTipView.h
//  ZXMaskTipView
//
//  Created by Zhang, Xiang(Xiang) on 8/5/16.
//  Copyright © 2016 xiangzhangkg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXMaskTipObj;

@interface ZXMaskTipView : UIView

@property (nonatomic, strong, nonnull) UIColor *maskColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong, nonnull) UIColor *tipBgColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong, nonnull) UIColor *tipColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong, nonnull) UIFont *tipFont UI_APPEARANCE_SELECTOR;

#pragma mark - Convenience Init

/**
 *  show mask for blend mode
 *
 *  @param aView       action view
 *  @param aIdentifier identifier
 *  @param aTip        tip
 */
+ (void)showBlendMaskWithView:(UIView *_Nonnull)aView
                andIdentifier:(NSString *_Nonnull)aIdentifier
                       andTip:(NSString *_Nonnull)aTip;

/**
 *  show mask for blend mode
 *
 *  @param aViewArr       action view array
 *  @param aIdentifierArr identifier array
 *  @param aTipArr        tip array
 */
+ (void)showBlendMaskWithViewArr:(NSArray <UIView *> *_Nonnull)aViewArr
                andIdentifierArr:(NSArray <NSString *> *_Nonnull)aIdentifierArr
                       andTipArr:(NSArray <NSString *> *_Nonnull)aTipArr;

#pragma mark - Init

/**
 *  show mask
 *
 *  @param aMaskTipObj ZXMaskTipObj
 */
+ (void)showMaskWithMaskTipObj:(ZXMaskTipObj *_Nonnull)aMaskTipObj;

/**
 *  show mask
 *
 *  @param aMaskTipArr ZXMaskTipObj array
 */
+ (void)showMaskWithMaskTipObjArr:(NSArray <ZXMaskTipObj *> *_Nonnull)aMaskTipArr;

#pragma mark - Page mode init

/**
 *  show mask for page mode
 *
 *  @param aIdentifier identifier
 *  @param aTip        tip
 */
+ (void)showPageMaskWithIdentifier:(NSString *_Nonnull)aIdentifier
                            andTip:(NSString *_Nonnull)aTip;

@end
