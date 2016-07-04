//
//  TingSDKManager.h
//  TingSDK
//
//  Created by wanghq on 14-12-9.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  SDK初始配置、认证、登录
 *
 *  工程配置：
 *
 *  1､播放器相关，请见 MusicAPlayer
 *
 *  2､添加如下系统库：
 *
 *     libz.dylib
 *
 */

//广告剩余时间消息
UIKIT_EXTERN NSString *const kAdvertiseRemainSecondChange;

@interface TingSDKManager : NSObject

///是否打开广告调试模式，调试模式下API不使用缓存,产品端禁止使用，默认为NO
@property (nonatomic, assign) BOOL sandbox;

///是否打开API调试模式，调试模式下API不使用缓存,产品端禁止使用，默认为NO
@property (nonatomic, assign) BOOL debugMode;

/**
 *  单例入口
 *
 *  @return 单例对象
 */
+ (instancetype)sharedInstance;

/**
 *  TingSDK初始化配置
 *
 *  @param APIKey     API Key
 *  @param appSecret  Secret Key
 *  @param scope      权限
 */
- (void)configuration:(NSString*)APIKey appSecret:(NSString*)appSecret scope:(NSString*)scope;

/**
 *  认证：获取在线资源需要先进行认证, app每次启动时调用
 *
 *  @param callback   认证回调
 */
- (void)authorize:(void (^)(int status))callback;

/**
 *  登录：获取用户相关的资源（用户信息及订阅信息）需要先进行登录授权
 *
 *  @param viewController  登录页的父页面
 *  @param callback        登录回调
 */
- (void)login:(UIViewController*)viewController callback:(void (^)(int status))callback;

/**
 *  注销用户的登录授权
 *
 */
- (void)logout;

/**
 *  判断用户的登录授权是否有效，如果有效，则可直接获取用户个人信息，否则，会弹出登录授权页面，让用户进行登录授权
 *
 */
- (BOOL)isUserTokenValid;

/**
 *  将广告图片显示页交给ＳＤＫ控制
 *
 *  @param viewAdv     广告页view
 *  @param imgViewAdv  广告图片显示
 *  @param btnCloseAdv 广告页关闭按钮
 */
- (void)setAdvertiseView:(UIView*)viewAdv imgViewAdv:(UIImageView*)imgViewAdv btnCloseAdv:(UIButton*)btnCloseAdv;

@end
