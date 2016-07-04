//
//  PlayItem.h
//  TingIPhone
//
//  Created by linsong on 13-8-27.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@protocol PlayItem <NSObject>

@property(nonatomic, copy) NSString* trackID;
@property(nonatomic, strong) NSNumber* musicType; // 本地、在线及iPod类型
@property(nonatomic, copy) NSString* localFilePath;
@property(nonatomic, strong) NSNumber* iPodPersistentID;
@property(nonatomic, copy) NSURL* trackURL;
@property(nonatomic, strong) MPMediaItem* mediaItem;
@property(nonatomic, strong) NSNumber* style;
@property(nonatomic, strong) NSNumber *replayGain;
@property(nonatomic, assign) NSTimeInterval duration;
@property(nonatomic, copy) NSString* fileFormat;
@property(nonatomic, copy) NSString* bitRate;
@property(nonatomic, assign) BOOL isLebo;
@property(nonatomic, strong) NSDate* urlExpireDate;

@end
