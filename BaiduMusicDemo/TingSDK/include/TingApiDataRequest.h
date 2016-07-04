//
//  TingApiDataRequest.h
//  TingSDK
//
//  Created by wanghq on 14-11-7.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TingApiDefine.h"

/**
 *  TingApiDataRequest是服务器API接口的工厂类
 */
@interface TingApiDataRequest : NSObject

/**
 *  请求任务是否已经发启
 *
 *  @param taskId 任务Id
 *
 *  @return 是否已经发启请求
 */
+ (BOOL)existsRequest:(NSString*)taskId;

/**
 *  结束API数据请求任务
 *
 *  @param taskId 任务Id
 */
+ (void)cancelRequest:(NSString*)taskId;


#pragma mark - 场景化接口

/**
 *  获取场景策略
 *
 *  @param taskId     任务Id，用于cancelRequest
 *  @param completion 成功回调block
 *  @param failure    失败回调block
 */
+ (void)getConstantScene:(NSString*)taskId
              completion:(void (^)(SceneModels* response))completion
                 failure:(void (^)(NSError* error))failure;

/**
 *  获取场景歌曲列表
 *
 *  @param sceneId    场景Id
 *  @param subId      场景二级类型Id
 *  @param pageNo     分页起始 1..n
 *  @param pageSize   每页数据的数量
 *  @param taskId     任务Id，用于cancelRequest
 *  @param completion 成功回调block
 *  @param failure    失败回调block
 */
+ (void)getSmartSongList:(NSInteger)sceneId
                   subId:(NSInteger)subId
                  pageNo:(NSInteger)pageNo
                pageSize:(NSInteger)pageSize
                  taskId:(NSString*)taskId
              completion:(void (^)(NSArray* response))completion
                 failure:(void (^)(NSError* error))failure;

/**
 *  构造播放器(MusicAPlayer)可以播放的数据
 *
 *  @param  arrSongs 接口getSmartSongList返回的response数据
 *
 *  @return MusicAPlayer->playWithItems传入此反回值发启播放
 */
+ (NSArray*)createTracksForPlayer:(NSArray*)arrSongs;


#pragma mark - 搜索接口

/**
 *  场景搜索
 *
 *  @param query      查询内容
 *  @param taskId     任务Id，用于cancelRequest
 *  @param completion 成功回调block
 *  @param failure    失败回调block
 */
+ (void)SearchScene:(NSString*)query
             taskId:(NSString*)taskId
         completion:(void (^)(SearchInfoModel* response))completion
            failure:(void (^)(NSError* error))failure;

/**
 *  搜索词图
 *
 *  @param trackName  歌曲名
 *  @param artistName 歌手名
 *  @param taskId     任务Id，用于cancelRequest
 *  @param completion 成功回调block
 *  @param failure    失败回调block
 */
+ (void)searchLrcPic:(NSString*)trackName
          artistName:(NSString*)artistName
              taskId:(NSString*)taskId
          completion:(void (^)(NSString* picUrl))completion
             failure:(void (^)(NSError* error))failure;

@end
