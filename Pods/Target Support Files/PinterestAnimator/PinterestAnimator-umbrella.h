#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "UICollectionView+XHIndexPath.h"
#import "UIView+XHViewFrame.h"
#import "XHBaseCollectionViewController.h"
#import "XHHorizontalPageViewController.h"
#import "XHNavigationController.h"
#import "XHWaterfallViewController.h"
#import "XHTransitionProtocol.h"
#import "XHPinterestPopTransition.h"
#import "XHPinterestPushTransition.h"
#import "XHPinterestTransition.h"
#import "XHNavigationControllerDelegate.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "XHUIKitMacro.h"
#import "XHPinterest.h"
#import "XHHorizontalPageViewCell.h"
#import "XHWaterfallCollectionViewCell.h"
#import "XHWaterfallContainerView.h"

FOUNDATION_EXPORT double PinterestAnimatorVersionNumber;
FOUNDATION_EXPORT const unsigned char PinterestAnimatorVersionString[];

