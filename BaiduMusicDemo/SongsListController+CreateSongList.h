//
//  SongsListController+CreateSongList.h
//  BaiduMusicDemo
//
//  Created by Karl on 16/7/5.
//  Copyright © 2016年 Karl. All rights reserved.
//

#import "SongsListController.h"

@interface SongsListController (CreateSongList)<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *listArray;
- (void)createSongsListView;

- (void)fetchListDataWithSceneID:(NSInteger)sceneID tag:(NSInteger)tag;

@end
