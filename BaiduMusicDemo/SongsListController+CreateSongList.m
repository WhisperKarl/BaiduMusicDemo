//
//  SongsListController+CreateSongList.m
//  BaiduMusicDemo
//
//  Created by Karl on 16/7/5.
//  Copyright © 2016年 Karl. All rights reserved.
//

#import "SongsListController+CreateSongList.h"
#import <objc/runtime.h>
#define selectionTag 1000
#define tableviewTag 2000
static const void *ListArrayKey = &ListArrayKey;
@implementation SongsListController (CreateSongList)
@dynamic listArray;

- (NSMutableArray *)listArray{
    return objc_getAssociatedObject(self, ListArrayKey);
}

- (void)setListArray:(NSMutableArray *)listArray{
    objc_setAssociatedObject(self, ListArrayKey, listArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)createSongsListView{
    
    self.listArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.models.scene_info.count; i++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [self.listArray addObject:array];
    }
    
    for (NSInteger i = 0; i < self.models.scene_info.count; i++) {
        UITableView *view = [[UITableView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44) style:UITableViewStylePlain];
        view.delegate = self;
        view.dataSource = self;
        view.tag = i + tableviewTag;
        [self.mainScrollView addSubview:view];
    }

}

- (void)fetchListDataWithSceneID:(NSInteger)sceneID tag:(NSInteger)tag{
    
    UITableView *tableView = [self.mainScrollView viewWithTag:tag + tableviewTag];
    [TingApiDataRequest getSmartSongList:sceneID
                                   subId:0
                                  pageNo:1
                                pageSize:40
                                  taskId:SELF_ID(self)
                              completion:^(NSArray *response) {
                                
                                  NSArray *array = [TingApiDataRequest createTracksForPlayer:response];
                                  if (array.count) {
                                      [self.listArray insertObject:array atIndex:tag];
                                  }
                                  [tableView reloadData];
                              } failure:^(NSError *error) {
                                  
                              }];
}

#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

#pragma mark - tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}
@end
