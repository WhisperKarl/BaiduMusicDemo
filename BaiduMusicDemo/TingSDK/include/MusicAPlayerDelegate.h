//
//  MusicAPlayerDelegate.h
//  TingIPhone
//
//  Created by cokuzhang on 13-9-8.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  播放代理
 */

/** 广告状态 */
typedef NS_ENUM(NSInteger, EAdvertiseStatus){
    /** 未知*/
    kAdvertistStatusUnknown,
    /** 通知广告已下载并且时间已到，将在最近锚点开始播放*/
    kAdvertistStatusWillPlay,
    /** 广告开始播放*/
    kAdvertistStatusPlaying,
    /** 广告播放完成*/
    kAdvertistStatusFinished,
    /** 一个点加入多个广告时多个广告均播放完毕*/
    kAdvertistStatusAllFinished,
    /** 广告播放中被中断*/
    kAdvertistStatusInterrupt
};

@class MusicAPlayer;
@protocol MusicAPlayerDelegate <NSObject>

@optional

/**歌曲playItem开始播放，还没有prepare成功*/
- (void)player:(MusicAPlayer *)player readyToPlay:(id)playItem;

/**歌曲playItem prepare成功*/
- (void)player:(MusicAPlayer *)player didBecomeAvailable:(id)playItem;

/**缓存进度0.0~1.0*/
- (void)player:(MusicAPlayer *)player cacheProgress:(float)progress;

/**播放时间*/
- (void)player:(MusicAPlayer *)player playedTime:(NSTimeInterval)time;

/**playItem自然播放结束*/
- (void)player:(MusicAPlayer *)player playItemEnd:(id)playItem;

/**两个错误方法只响应一个，先判断代理是否响应带错误码方法，响应则执行，如果代理不响应，再判断是否响应不带错误码的，如果代理响应不带错误码，执行不带错误码方法*/
/**播放出错，本地或iPod或服务器出错（非网络问题）*/
- (void)player:(MusicAPlayer *)player didFail:(id)playItem;

/**播放出错，本地或iPod或服务器出错（非网络问题）*/
- (void)player:(MusicAPlayer *)player didFail:(id)playItem errorType:(MusicAPlayerErrorType)errorType aPlayerErrorType:(APlayerErrorCode)aPlayerErrorCode;

/**顺序播放模式播放完所有歌曲后播放结束*/
- (void)playerFlowDidEnd:(MusicAPlayer *)player;

/**播放停止*/
- (void)playerDidStop:(MusicAPlayer *)player;

/**定时播放时间到*/
- (void)sleepTimer;

/**广告相关状态变化*/
- (void)playerAdvertisementChange:(MusicAPlayer *)player newStatus:(EAdvertiseStatus)status;

@end
