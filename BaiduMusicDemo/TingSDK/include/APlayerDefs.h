//
//  APlayerDefs.h
//  TingIPhone
//
//  Created by linsong on 13-8-27.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#ifndef TingIPhone_APlayerDefs_h
#define TingIPhone_APlayerDefs_h

typedef enum {
    APlayerModeNone = -1,
	APlayerModeShuffle = 0,
	APlayerModeAllLoop = 1,
	APlayerModeOneLoop = 2,
    APlayerModeFlow = 3,
    APlayerModeIgnoreMode = 100,
} APlayerMode;

typedef enum {
	APlayerTypeCommon = 0,
	APlayerTypeRadio = 1,
    APlayerTypeScene
} APlayerType;

typedef enum {
    APlayerItemOnline = 0,
    APlayerItemiPod = 1,
    APlayerItemLocal = 2,
} APlayerItemType;

typedef enum {
    APlayerStateIdle = 0,
    APlayerStatePlaying = 1,
    APlayerStatePause = 2,
    APlayerStateInterrupted = 3,
    APlayerStateWaiting = 4,
} APlayerState;

#define kAPlayerErrorDomain @"com.baidu.TingIPhone.APlayer"

typedef enum {
    APlayerErrorNone = 0,
    APlayerErrorInitFailed = 1,
    APlayerErrorDecodeFailed = 2,
    APlayerErrorPrepareFailed = 3,
    APlayerErrorInvalidiPodUrl = 4,
    APlayerErrorInvalidiCloudItem = 5,
} APlayerErrorCode;

// 均衡器

typedef enum{
    APlayerEffectTypeDefault = 0,
    APlayerEffectTypeCustom = 1,
    APlayerEffectTypeNone = 2,
    APlayerEffectTypeIntelligent = 3,
}APlayerEffectType;

#define BAND_NUM 10
#define EQ_FOR_CUSTOM 10

#define kAPlayerNotificationKeyObject @"APlayerNotificationKeyObject"

#endif
