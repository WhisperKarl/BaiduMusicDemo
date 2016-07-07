//
//  SongsListController+CreateSongList.m
//  BaiduMusicDemo
//
//  Created by Karl on 16/7/5.
//  Copyright © 2016年 Karl. All rights reserved.
//

#import "SongsListController+CreateSongList.h"
#import "SongListCell.h"
#import "MusicAPlayer.h"
#import "PlayStrategy.h"
#import "PlayDetailController.h"
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
    
    if ([[self.listArray objectAtIndex:tag] count]) {
        return;
    }
    
    UITableView *tableView = [self.mainScrollView viewWithTag:tag + tableviewTag];
    [TingApiDataRequest getSmartSongList:sceneID
                                   subId:0
                                  pageNo:1
                                pageSize:40
                                  taskId:SELF_ID(self)
                              completion:^(NSArray *response) {
                                

                                  if (response.count) {
                                      [self.listArray replaceObjectAtIndex:tag withObject:response];
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
    return [[self.listArray objectAtIndex:tableView.tag - tableviewTag] count];
}

#pragma mark - tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"list"];
    }
    
    NSDictionary *dic = [[self.listArray objectAtIndex:tableView.tag - tableviewTag] objectAtIndex:indexPath.row];
    cell.textLabel.text = dic[@"title"];
    cell.detailTextLabel.text = dic[@"author"];
    NSLog(@"%@",dic[@"pic_premium"]);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [MusicAPlayer sharedInstance].playMode = APlayerModeAllLoop;
    
    NSArray *response = [self.listArray objectAtIndex:tableView.tag - tableviewTag];
    
    NSArray *array = [TingApiDataRequest createTracksForPlayer:response];
    
    [[MusicAPlayer sharedInstance] updatePlayList:array];
    
    [[MusicAPlayer sharedInstance] playAtIndex:indexPath.row];
    
    PlayDetailController *vc = [[PlayDetailController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
