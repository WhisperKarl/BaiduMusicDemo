//
//  MusicAPlayer.h
//  TingIPhone
//
//  Created by cokuzhang on 13-8-27.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APlayerDefs.h"
#import "PlayItem.h"
#import "MusicAPlayerDefs.h"
#import "MusicAPlayerDelegate.h"

/*!
 *  播放功能配置:
 *
 *  1、添加如下Framework:
 *
 *      MediaPlayer.framework
 *
 *      AudioToolobx.framework
 *
 *      CoreMedia.framework
 *
 *      AVFoundation.framework
 *
 *      SystemConfiguration.framework
 *
 *  2、工程的Target的Build Settings添加如下配置
 *
 *      Other Linker Flags:     -ObjC
 *
 *      Compile Sources As:     Objectview-C++
 *
 *      C++ Standard Library:   libstdc++(GNU C++ standard library)
 *
 *  3、支持后台播放：工程Target的Capability中, 打开Background Modes, 勾选Audio And Airplay
 *
 *  4、支持iOS 5以上系统
 */

#define SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(SS_CLASSNAME)	\
\
+ (SS_CLASSNAME*) sharedInstance;	\
+ (void) purgeSharedInstance;

@class PlayStrategy;

@interface MusicAPlayer : NSObject

/**播放代理 MusicAPlayerDelegate*/
@property (nonatomic, weak) id <MusicAPlayerDelegate> delegate;

/**播放策略 PlayStrategy，可以重载 */
@property (nonatomic, strong) PlayStrategy *playStrategy;

/**播放模式*/
@property (nonatomic, assign) APlayerMode playMode;

/**播放器状态*/
@property (nonatomic, readonly) APlayerState playState;

/**当前播放在列表中的位置*/
@property (nonatomic, readonly) NSUInteger currentPlayIndex;

/**播放列表*/
@property (weak, nonatomic, readonly) NSArray *playList;

/**当前播放记录*/
@property (weak, nonatomic, readonly) id <PlayItem> currentPlayItem;

/**正在播放标志*/
@property (nonatomic, readonly, getter=isPlaying) BOOL playing;

/**当前播放时间*/
@property(nonatomic, assign) NSTimeInterval currentTime;

/**当前播放音频总时长*/
@property(nonatomic, readonly) NSTimeInterval duration;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(MusicAPlayer);

/**判断单例是否为空*/
+ (id)isInstanceNull;

/**初始广告策略*/
- (void)initAdTactics;

/**发起播放入口：播放列表初始化，播放发起入口，初始化为播放状态*/
- (void)playWithItems:(NSArray *)playItems atPlayIndex:(NSUInteger)playIndex withPlayType:(APlayerType)playType;

/**发起播放入口：播放列表初始化，播放发起入口，初始化为暂停状态*/
- (void)pauseWithItems:(NSArray *)playItems atPlayIndex:(NSUInteger)playIndex withPlayType:(APlayerType)playType;

/**更新播放列表，如果playList包含当前正在播的歌曲，继续播放该首歌曲*/
- (void)updatePlayList:(NSArray *)playList; //更新播放列表，如果playList包含当前正在播的歌曲，继续播放该首歌曲

/**删除播放列表指定index歌曲*/
- (void)deleteAtPlayIndex:(NSUInteger)playIndex;

/**从播放列表中删除playItem*/
- (void)deleteItem:(id)playItem;

/**添加播放歌曲到播放列表最后*/
- (void)addPlayItems:(NSArray *)playItems;

/**停止并清空播放列表*/
- (void)removeAllItems;

/**播放播放列表指定index歌曲*/
- (void)playAtIndex:(NSUInteger)playIndex;

/**播放控制：播放*/
- (void)play;

/**播放控制：重新播放当前记录*/
- (void)replay;

/**播放控制：恢复播放，同play*/
- (void)resume;

/**播放控制：暂停*/
- (void)pause;

/**播放控制：退出播放*/
- (void)stop;

/**播放控制：下一曲*/
- (void)next;

/**播放控制：上一曲*/
- (void)prev;

/**播放控制：循环切换播放模式*/
- (APlayerMode)changePlayMode;

/**从index开始向后第offset个记录位置（已考虑到随机播放）*/
- (int)getItemIndexAtIndex:(NSInteger)index offset:(NSInteger)offset;

/**播放控制：改变音量. 0.0~1.0*/
- (void)changeVolume:(NSNumber *)value;

/**播放控制：递减控制音量*/
- (void)fadeVolumeWithProgress:(BOOL)bProgress;

/**播放控制：递增控制音量*/
- (void)resumeVolumeWithProgress:(BOOL)bProgress;

/**设置代理，帐号和密码可为空*/
+ (BOOL)setProxyHost:(NSString *)strHost andPort:(int)nPort andUser:(NSString *)strUser andPasswd:(NSString *)strPwd enabled:(BOOL)enabled;

/**set user agent, strUA will apend to default user agent string*/
+ (BOOL) setUserAgent:(NSString*)strUA;

@end
