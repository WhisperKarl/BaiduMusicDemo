//
//  PlayStrategy.h
//  TingIPhone
//
//  Created by cokuzhang on 13-8-27.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicAPlayer.h"

/*!
 *  播放策略
 */

@class MusicAPlayer;

@interface PlayStrategy : NSObject

@property (nonatomic, weak) MusicAPlayer *musicAPlayer;

@property (nonatomic, copy) ContinuePlayBlock continuePlayBlock;

@property (nonatomic, assign) NSInteger continuousFailureCount;

- (void)reset;

/**
 *  检查两个曲目是否相等
 */
- (BOOL)checkItem:(id)playItem1 isEqualTo:(id)playItem2;

/**
 *  检查两个播放列表是否相同
 */
- (BOOL)checkPlayList:(NSArray *)playList1 isEqualTo:(NSArray *)playList2;

/**
 *  在列表中查找歌曲
 *
 *  @return 歌曲所在的下标
 */
- (int)findItem:(id)item indexInPlayList:(NSArray *)playList;

- (NSArray *)configPlayItems:(NSArray *)playItems;

/**
 *  配置playItem的参数。比如：需要同步数据库， 查询本地文件是否存在等等
 */
- (BOOL)configItem:(id <PlayItem>)playItem;

/**
 * playitem的本地文件格式是否被支持
 */
- (BOOL)canSupportLocalFileTypeWithItem:(id <PlayItem>)playItem;

/**
 *  playItem的本地文件是否存在
 */
- (BOOL)hasLocalFileWithItem:(id <PlayItem>)playItem;

/**
 *  是否可以播放
 */
- (BOOL)canPlayWithItem:(id <PlayItem>)playItem;

/**
 *  是否为在线歌曲
 */
- (BOOL)isOnlineItem:(id <PlayItem>)playItem;

- (BOOL)hasLocalItemWithPlayItems:(NSArray *)playItems;

- (void)fetchOnlineTrackInfo:(id <PlayItem>)playItem;

- (void)cancelFetchOnlineTrackInfo;

- (void)removeItemFromDB:(id <PlayItem>)playItem;

/**
 *  检查网络，是否允许播放在线歌曲。 默认所有联网条件下允许播放
 */
- (BOOL)checkNetworkCanContinue;

/**
 *  检查网络，是否允许选链。 默认所有联网条件下允许播放
 */
- (BOOL)checkNetworkCanFetchTrackInfo;

/**
 *  检查网络，是否允许播放。 默认所有联网条件下允许播放
 */
- (BOOL)checkNetworkCanPlay;

/**
 *  检查网络，是否允许预下载下一首歌曲。默认仅支持wifi下预下载
 */
- (BOOL)checkNetworkCanPreloadNext;

/**
 *  播放完成
 */
- (void)playFinishedWithItem:(id <PlayItem>)playItem;

/**
 *  播放失败
 */
- (void)playFailedWithItem:(id <PlayItem>)playItem errorType:(MusicAPlayerErrorType)errorType aPlayerErrorType:(APlayerErrorCode)aPlayerErrorCode;

/**
 *  在线歌曲播放前， 询问是否继续播放. 默认调用checkNetworkCanContinue检查网络条件，如果允许则调用continuePlayBlock(yes), 否则调用continuePlayBlock(no)
 */
- (void)checkContinuePlayBlock:(void(^)(BOOL isContinue))continuePlayBlock;

- (NSUInteger)redirectPlayIndexWithPlayIndex:(NSUInteger)playIndex;

/**
 *  在线歌曲下载完成
 */
- (void)downloadDidFinishWithTaskId:(NSInteger)taskId urlString:(NSString *)urlString;

@end
