//
//  SongsListController.m
//  BaiduMusicDemo
//
//  Created by Karl on 16/7/5.
//  Copyright © 2016年 Karl. All rights reserved.
//

#import "SongsListController.h"
#import "SongsListController+CreateSongList.h"
#define titleButtonTag 1000
#define tableViewTag 2000
@interface SongsListController ()<UIScrollViewDelegate>{
    
    UIScrollView *_titleScrollView;
    UIButton *_lastSelectedBtn;         //选中的button
    UIView *_titleBottomView;           //滑块
}

@end

@implementation SongsListController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"歌曲列表";
    [self prepareData];
}
- (void)prepareData{
    
    [TingApiDataRequest getConstantScene:SELF_ID(self) completion:^(SceneModels *response) {
        _models = response;
        [self configureUI];
    } failure:^(NSError *error) {
        
    }];
}

- (void)configureUI{
    
    //创建顶部选择view
    CGFloat width = SCREEN_WIDTH / 6;
    _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44)];

    _titleScrollView.bounces = NO;
    _titleScrollView.showsVerticalScrollIndicator = NO;
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _titleScrollView.contentSize = CGSizeMake(_models.scene_info.count * width, 44);
    [self.view addSubview:_titleScrollView];
    
    for (NSInteger i = 0 ; i < _models.scene_info.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * width, 0, width, 44);
        [btn setTitle:[[_models.scene_info objectAtIndex:i] scene_name] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(TitleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        if (i == 0) {
            _lastSelectedBtn = btn;
            [btn setTitleColor:Green_Color forState:UIControlStateNormal];
        }
        btn.tag = titleButtonTag + i;
        [_titleScrollView addSubview:btn];
    }
    
    _titleBottomView = [[UIView alloc] init];
    _titleBottomView.frame = CGRectMake(0, _titleScrollView.bounds.size.height - 1.5, width, 1.5);
    _titleBottomView.backgroundColor = Green_Color;
    [_titleScrollView addSubview:_titleBottomView];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + _titleScrollView.bounds.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - _titleScrollView.bounds.size.height)];
    self.mainScrollView.delegate = self;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.bounces = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _models.scene_info.count, SCREEN_HEIGHT - 64 - 44);
    self.mainScrollView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.mainScrollView];
    
    [self createSongsListView];
    
    
    SceneBaseModel *base = [_models.scene_info objectAtIndex:0];
    [self fetchListDataWithSceneID:base.scene_id tag:0];
    
}

#pragma mark -- 选择按钮点击事件
- (void)TitleBtnAction:(UIButton *)btn{
    
    if (btn == _lastSelectedBtn) {
        return;
    }
    //改变button状态
    [_lastSelectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:Green_Color forState:UIControlStateNormal];
    _lastSelectedBtn = btn;
    CGFloat buttonWidth = SCREEN_WIDTH / 6;
    NSInteger tag = btn.tag - titleButtonTag;
    
    [_titleScrollView scrollRectToVisible:CGRectMake((tag) * buttonWidth - CGRectGetMidX(self.view.bounds) + CGRectGetWidth(btn.bounds)/2, 0, _titleScrollView.bounds.size.width, _titleScrollView.bounds.size.height) animated:YES];
    //滑块滑动
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center = _titleBottomView.center;
        center.x = _lastSelectedBtn.center.x;
        _titleBottomView.center = center;
    }];
    //scrollView 联动
    CGFloat offsetX = tag * SCREEN_WIDTH;
    CGPoint scrPoint = _mainScrollView.contentOffset;
    scrPoint.x = offsetX;
    [_mainScrollView setContentOffset:scrPoint animated:YES];

    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if ([scrollView isKindOfClass:[UITableView class]]) {
        
    }else{
        
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if ([scrollView isKindOfClass:[UITableView class]]) {
        
    } else if([scrollView isKindOfClass:[_mainScrollView class]]) {
        
        NSInteger page = scrollView.contentOffset.x / SCREEN_WIDTH;
        UIButton *btn = (UIButton *)[self.view viewWithTag:page + titleButtonTag];
        SceneBaseModel *base = [_models.scene_info objectAtIndex:page];
        [self fetchListDataWithSceneID:base.scene_id tag:page];
        [self TitleBtnAction:btn];
        
    }

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if ([scrollView isKindOfClass:[UITableView class]]) {
        
    }else if ([scrollView isKindOfClass:[_mainScrollView class]]) {
        
        NSInteger page = scrollView.contentOffset.x / SCREEN_WIDTH;
        UIButton *btn = (UIButton *)[self.view viewWithTag:page + titleButtonTag];
        SceneBaseModel *base = [_models.scene_info objectAtIndex:page];
        [self fetchListDataWithSceneID:base.scene_id tag:page];
        [self TitleBtnAction:btn];
        
    }
}
@end
