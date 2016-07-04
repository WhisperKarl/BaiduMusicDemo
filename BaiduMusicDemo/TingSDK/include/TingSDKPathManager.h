//
//  TingSDKPathManager.h
//  SDK
//
//  Created by wanghq on 14-11-23.
//  Copyright (c) 2014年 wanhq. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString* LIBRARY_PLIST_PATH();       // library下得plist文件夹

NSString* APlAYER_STORAGE_PATH();     // 旧的Document路径
NSString* APlAYER_STORAGE_LIB_PATH(); // 新的Lib路径

//图片缓存
NSString* IMAGE_CACHE_PATH();
NSString* IMAGE_CACHE_PATH_URLSTR(NSString *URLStr);
