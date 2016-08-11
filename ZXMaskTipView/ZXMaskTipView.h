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
                       andTip:(NSString *_Nonnull)aTip;

/**
 *  show mask for cover mode
 *
 *  @param aViewArr       action view array
 *  @param aIdentifierArr identifier array
 *  @param aTipArr        tip array
 */
+ (void)showCoverMaskWithViewArr:(NSArray <UIView *> *_Nonnull)aViewArr
                andIdentifierArr:(NSArray <NSString *> *_Nonnull)aIdentifierArr
                       andTipArr:(NSArray <NSString *> *_Nonnull)aTipArr;

#pragma mark - Page mode init

/**
 *  show mask for page mode, need call dismiss method
 *
 *  @param aIdentifier identifier
 *  @param aTip        tip
 */
+ (void)showPageMaskWithIdentifier:(NSString *_Nonnull)aIdentifier
                            andTip:(NSString *_Nonnull)aTip;

#pragma mark - Custom mode init

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

/**
 *  dismiss mask, will not mark has read
 */
+ (void)dismissMaskTipView;

@end
