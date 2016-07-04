//
//  TingGlobalUtility.h
//  SDK
//
//  Created by Libra on 14-8-27.
//  Copyright (c) 2014年 Libra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIDevice.h>

/**
 *  system version
 */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/**
 *  App & Api version
 */
#define API_VERSION @"1"
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define SYSTEM_VERSION   [[UIDevice currentDevice] systemVersion]

/**
 * Channel
 */
#define CHANNEL @"AppStore"

/**
 * self 构造一个id
 */
#define SELF_ID(self) [NSString stringWithFormat:@"%p", self]

/**
 *  只有Debug版本输出Log信息
 */
#ifdef DEBUG
#define DLog( s, ... ) NSLog( @"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif

/**
 * try-catch
 */
#define Try(Stuff)\
@try { \
Stuff \
} \
@catch (NSException *exception) {}

#define PLSafeRelease(_obj_) _obj_ = nil;

//默认均衡器的曲风值
#define kEQStyleDefault 99

typedef enum{
    ResourceCopyright = 0,//有版权
    ResourceWhite = 1,//白色资源
    ResourceGray = 2,//灰色资源
    ResourceBlack = 3//黑色资源
}TrackResourceType;

typedef enum{
    TrackCopyrightUnknow = 0,//unknow
    TrackCopyrightAll = 1,//全部版权
    TrackCopyrightOnlyDownload = 2,//仅下载权
    TrackCopyrightOnlyPlay = 3//仅播放权
}TrackCopyType;

typedef enum{
    ResourceDefault = 0,   //非音乐人资源
    ResourceMusicianFree,
    ResourceMusicianCharge
}TrackChargeType;

typedef enum{
    TrackTypeDefault = 0,
    TrackTypeDownloaded = 1,
    TrackTypeDownloadWaitting = 2,
    TrackTypeDownloading = 3,
    TrackTypePaused = 4,
    TrackTypeDownloadFailed = 5,
    TrackTypeFavorited = 6,     //deprecated。弃用此种类型， 用isFavorited标志位
    TrackTypeIPod = 7,
    TrackTypeInIPodLibrary = 8, //直接从ipod里取的Track信息
    TrackTypeItunesImported = 9,
    TrackTypeOfflined = 10,
    TrackTypeLocal = 11,
    TrackTypeValidating,
    TrackTypeBrowserImport,
    TrackTypeMusicPCImport,
    TrackTypeDeleting
}TrackType;

typedef enum {
    TrackDownloadTotalFree,
    TrackDownloadTotalCharge,
    TrackDownloadLimitedFree
}TrackDownloadChargeType;

typedef enum{
    FavTypeLocalFav = 1 << 1,   // 本地收藏
    FavTypeCloudFav = 1,        // 云收藏
    FavTypeNon = 0              // 未收藏
}FavType;

typedef enum{
    kNetWorkWarningNone,
    kWWANButOnlyWIFI,
    kWIFIToWWAN,
    kWWANUNICOM,
    kWWANMusicDownload,
    kWWANOffline,
    kWWANOfflineSetting,
    kWWANListenSetting,
    kWWANMV_MusicDownload,
    kWWANMVDownload,
    kWWANMVPlay,
    kWWANCompanyDownload,
    kWWANShareCompanyDownload,
    KWWAN10MUnicom,
    KWWANBcsUpload,
    kWWANRINGPLAY
}NetWorkWarningType;

typedef enum {
    eSuggestion = 1,
    eSearchResult,
    eTrackInfo,
    eBillboardList,
    eBillboardDetail,
    eNewSongs,
    eRegister,
    eActivate,
    eAlbum,
    eAlbumDetail,//10
    eRecommendAlbum,
    eHotSinger,
    eArtistDetailInfo,
    eArtistSongs,
    eArtistAlbums,
    eDiyAlbum,
    eDiyAlbumDetail,
    eLogin,
    eUserInfo,
    eAddFavSong,//20
    eRemoveFavSong,
    eAddFavAlbum,
    eRemoveFavAlbum,
    eCloudSongList,
    eFavSongList,
    eFavAlbumList,
    eRadioCategoryList,
    ePubRadioSongList,
    eArtistSongList,
    eRadioSongListByName,//30
    eUserRadioList,
    eLogout,
    eTingAlbum,
    eTingAlbumDetail,
    eVerifyCode,
    eRegisterCodePhone,
    eRegisterDeviceToken,
    ePlazaColumns,
    eAlbumDetailV2,
    eGetPhotoInfo, // 获取图片信息 40
    eGetVersionInfoFromAPI, //从api获取版本信息
    eTingList, // 在线列表
    eTingListDetail, // 歌单详情
    eGetFocusPic, // 首页焦点图
    eRedheartRadioSongList, // 获取红心电台
    eCommitRadioPlayAction,//电台播放行为包括：歌曲扔到垃圾桶
    eAppRecommendASI,   // 获取appStore的推荐应用
    eSearchLrcPic,      //搜索词图
    eFetchVoteScenarioIndex, //投票首页信息  50
    eFetchVoteScenarioDetail, //投票详情页信息
    eCommitVote, //发起投票
    eTrackInfoForDownload, //下载新接口
    eUserFeedBack, //用户反馈
    eFestivalActivity,  //春节活动
    eWebSuggestion, //大搜索Sug
    eAddFavTingList,  //保存歌单
    eRemoveFavTingList, //删除歌单
    eRemoveFavTingListSong, //删除歌单中歌曲
    eGetHomepageDailyRec,  //获取首页推荐 60
    eGetHotSongMenu,   //收取首页热门歌单
    eGetSongMenu,   //收取歌单列表
    eGetSongMenuInfo,//从歌单listid获取songid
    eGetSongMenuCategory, //获取歌单筛选字段
    eGetSongBaseInfo, //获取歌曲基本信息，不选链
    eGetADActivityImage, //获取广告活动的图片
    eVoiceList, // 获取好声音试听唱列表
    eVoicePhaseList, // 获取好声音期列表
    eVoiceResult, // 获取好声音结果页
    eGetRecMVList, //获取mv推荐列表
    eGetMVDetail, //获取MV详情
    eGetMVListWithNewQuery, // 根据query获取MV new列表
    eGetMVListWithHotQuery, // 根据query获取MV hot列表
    eGetMVMenuCategory, //获取歌单筛选字段
    eGetMVInfosWithSongids,   // 根据songid批量获取mv信息
    eTrackInfoForDownloadSize, //获取下载歌曲的文件大小信息
    eGetUserMessage,           //web发送下载到手机获取用户信息
    eToMylocalSong          // 进入本地歌曲页面
    
} APIType;

//对某种格式的音频文件的支持类型
typedef NS_ENUM(NSUInteger, SupportedType){
    SupportedNone,
    SupportedSystem,
    SupportedAudioCore,
};

@interface TingSDKGlobalUtility : NSObject

+ (BOOL)skipICloud:(NSString*)filePath;

+ (SupportedType)supportedTypeForAudioFile:(NSString *)filePath;

+ (BOOL)isValidString:(NSString *)str;

@end
