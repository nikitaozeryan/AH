//
//  XHWaterfallContainerView.h
//  PinterestExample
//
//  Created by dw_iOS on 14-7-24.
//  Copyright (c) 2014年 广州华多网络科技有限公司 多玩事业部 iOS软件工程师 曾宪华. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XHPinterest;

@interface XHWaterfallContainerView : UIView

/**
 *  圆角半径
 */
@property (nonatomic, assign) CGFloat cornerRadii;

/**
 *  需要展示和绑定的数据Model
 */
@property (nonatomic, strong) XHPinterest *displayPinterest;

- (instancetype)initWithFrame:(CGRect)frame
                  cornerRadii:(CGFloat)cornerRadii;


@end
