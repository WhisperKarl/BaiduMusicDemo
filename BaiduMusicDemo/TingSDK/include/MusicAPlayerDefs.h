//
//  MusicAPlayerDefs.h
//  TingIPhone
//
//  Created by cokuzhang on 13-8-29.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#ifndef TingIPhone_MusicAPlayerDefs_h
#define TingIPhone_MusicAPlayerDefs_h


typedef enum {
	MusicAPlayerErrorTypeNone = 0,
    MusicAPlayerErrorTypeFetchTrackInfoError,
    MusicAPlayerErrorTypeNetworkError,
    MusicAPlayerErrorTypeAPlayerError,
    MusicAPlayerErrorTypeNotSupportLocalFileTypeError,  // 不支持的格式
    MusicAPlayerErrorTypeCloudMusicTranscodingError,    // 云音乐转码失败
    MusicAPlayerErrorTypeNotExistLocalFileError,        // 本地文件不存在
    
    MusicAPlayerErrorTypeOtherError = 100
} MusicAPlayerErrorType;

typedef void (^ContinuePlayBlock)(BOOL isContinue);     //播放是否继续block

#endif
