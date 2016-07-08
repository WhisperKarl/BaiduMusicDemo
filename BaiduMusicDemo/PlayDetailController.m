//
//  PlayDetailController.m
//  BaiduMusicDemo
//
//  Created by Karl on 16/7/6.
//  Copyright © 2016年 Karl. All rights reserved.
//

#import "PlayDetailController.h"
#import "MusicAPlayer.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
@interface PlayDetailController ()<MusicAPlayerDelegate,UIGestureRecognizerDelegate>{
    
    UIButton *_pauseBtn;
    UIButton *_nextBtn;
    UIButton *_lastBtn;
    UISlider *_progressSlider;
    UILabel *_songNameLabel;
    UILabel *_singerNameLabel;
    UILabel *_currentTimeLabel;
    UILabel *_totalTimeLabel;
    MusicAPlayer *_player;
    UIImageView *_backView;
    UIButton *_backBtn;
    UIProgressView *_catchProgress;             //缓存进度条
    UIPanGestureRecognizer *_panGesture;        //拖动手势
    UISlider *_volumeSlider;                    //系统音量
}

@end

@implementation PlayDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _player = [MusicAPlayer sharedInstance];
    _player.delegate = self;
    [self configureUI];
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    
    for (UIView *view in volumeView.subviews) {
        if ([view isKindOfClass:[UISlider class]]) {
            _volumeSlider = (UISlider *)view;
        }
    }

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)configureUI{
    
    _backView = [[UIImageView alloc] init];
    _backView.image = [UIImage imageNamed:@"背景"];
    _backView.userInteractionEnabled = YES;
    [self.view addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view);
        make.center.mas_equalTo(self.view);
    }];
    
    _pauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_pauseBtn setImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:UIControlStateNormal];
    [_pauseBtn setImage:[UIImage imageNamed:@"player_btn_pause_highlight"] forState:UIControlStateHighlighted];
    [_pauseBtn addTarget:self action:@selector(pauseAction:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_pauseBtn];
    [_pauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-40);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    _lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_lastBtn setImage:[UIImage imageNamed:@"hp_player_btn_pre_normal"] forState:UIControlStateNormal];
    [_lastBtn setImage:[UIImage imageNamed:@"hp_player_btn_pre_highlight"] forState:UIControlStateHighlighted];
    [_lastBtn addTarget:self action:@selector(swhichToLastSong:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_lastBtn];
    [_lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_pauseBtn.mas_left).with.offset(-20);
        make.centerY.mas_equalTo(_pauseBtn);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setImage:[UIImage imageNamed:@"hp_player_btn_next_normal"] forState:UIControlStateNormal];
    [_nextBtn setImage:[UIImage imageNamed:@"hp_player_btn_next_highlight"] forState:UIControlStateHighlighted];
    [_nextBtn addTarget:self action:@selector(swhichToNextSong:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_nextBtn];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_pauseBtn.mas_right).with.offset(20);
        make.centerY.mas_equalTo(_pauseBtn);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    
    _progressSlider = [[UISlider alloc] init];
    _progressSlider.maximumValue = 1;
    _progressSlider.minimumValue = 0;
    UIImage *image = [UIImage imageNamed:@"mvplayer_progress_thumb_mini"];
    [_progressSlider setThumbImage:image forState:UIControlStateNormal];
    [_progressSlider setThumbImage:image forState:UIControlStateHighlighted];
    [_progressSlider setMinimumTrackTintColor:[UIColor colorWithRed:0.149 green:0.733 blue:0.400 alpha:1.000]];
    [_progressSlider setMaximumTrackTintColor:[UIColor clearColor]];
    [_progressSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    _progressSlider.value = _player.currentTime / _player.duration;
    [_backView addSubview:_progressSlider];
    [_progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_backView);
        make.bottom.mas_equalTo(_pauseBtn.mas_top).with.offset(-20);
        make.width.mas_equalTo(SCREEN_WIDTH - 100);
    }];
    
    _catchProgress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _catchProgress.trackTintColor = [UIColor lightGrayColor];
    _catchProgress.progressTintColor = [UIColor whiteColor];
    [_backView insertSubview:_catchProgress belowSubview:_progressSlider];
    [_catchProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_backView);
        make.centerY.mas_equalTo(_progressSlider).with.offset(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH - 100);
        
    }];

    
    _currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, SCREEN_HEIGHT-40 ,40, 20)];
    _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    _currentTimeLabel.font = [UIFont systemFontOfSize:12];
    _currentTimeLabel.textColor = [UIColor whiteColor];
    _currentTimeLabel.text = @"00:00";
    [_backView addSubview:_currentTimeLabel];
    [_currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backView.mas_left).with.offset(5);
        make.centerY.mas_equalTo(_progressSlider);
        make.width.mas_equalTo(40);
    }];
    
    _totalTimeLabel = [[UILabel alloc] init];
    _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    _totalTimeLabel.font = [UIFont systemFontOfSize:12];
    _totalTimeLabel.textColor = [UIColor whiteColor];
    _totalTimeLabel.text = @"00:00";
    [_backView addSubview:_totalTimeLabel];
    [_totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_progressSlider.mas_right).with.offset(5);
        make.centerY.mas_equalTo(_progressSlider);
        make.width.mas_equalTo(40);
    }];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_backView).with.offset(40);
        make.left.mas_equalTo(_backView).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    _songNameLabel = [[UILabel alloc] init];
    _songNameLabel.text = _infoDic[@"title"];
    _songNameLabel.font = [UIFont systemFontOfSize:18];
    _songNameLabel.textColor = [UIColor whiteColor];
    [_backView addSubview:_songNameLabel];
    [_songNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_backBtn);
        make.centerX.mas_equalTo(_backView);
    }];
    
    _singerNameLabel = [[UILabel alloc] init];
    _singerNameLabel.font = [UIFont systemFontOfSize:15];
    _singerNameLabel.textColor = [UIColor whiteColor];
    _singerNameLabel.text = [NSString stringWithFormat:@"—— %@ ——",_infoDic[@"author"]];
    [_backView addSubview:_singerNameLabel];
    [_singerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_songNameLabel);
        make.top.mas_equalTo(_songNameLabel.mas_bottom).with.offset(20);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_infoDic[@"pic_huge"]] placeholderImage:[UIImage imageNamed:@"封面.jpg"]];
    [_backView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(SCREEN_WIDTH - 40);
        make.centerY.mas_equalTo(_backView);
        make.centerX.mas_equalTo(_backView);
    }];
    
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    _panGesture.delegate = self;
    _panGesture.minimumNumberOfTouches = 1;
    _panGesture.maximumNumberOfTouches = 1;
    [_backView addGestureRecognizer:_panGesture];
    
}

- (void)gestureAction:(UIPanGestureRecognizer *)gesture{
    
    CGPoint velocity = [gesture velocityInView:_backView];
    
    static int direction = 1;
    
    NSLog(@"喝喝");
    if (gesture.state == UIGestureRecognizerStateChanged) {
        if (direction == 1) {
            if (fabs(velocity.x) > fabs(velocity.y)) {
                //横向
                direction = 2;
            }else if (fabs(velocity.x) < fabs(velocity.y)){
                //纵向
                direction = 3;
            }
        }else if (direction == 2){
            //快进快退
            CGPoint location = [gesture translationInView:_backView];
            
            NSLog(@"%f",location.x);
            
            if (location.x > 0) {
                _progressSlider.value = _progressSlider.value + 0.01;
            }else{
                _progressSlider.value = _progressSlider.value - 0.01;
            }
            
            NSTimeInterval newTime = [MusicAPlayer sharedInstance].duration * _progressSlider.value;
            
            _player.currentTime = newTime;


            
        }else if (direction == 3){
            //音量调节
            CGPoint location = [gesture translationInView:_backView];
            if (location.y > 0) {
                _volumeSlider.value = _volumeSlider.value - 0.03;
            }else{
                _volumeSlider.value = _volumeSlider.value + 0.03;
            }
            
        }
    }else if (gesture.state == UIGestureRecognizerStateEnded){

        
        direction = 1;
    }
    
    
}

- (void)backAction:(UIButton *)btn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)swhichToNextSong:(UIButton *)btn{
    
    [_player next];
    NSLog(@"%ld",_player.currentPlayIndex);
    NSLog(@"%@",_player.playList);
    /**
     *  更新歌曲名
     */
    NSDictionary *dic = [_listArray objectAtIndex:_player.currentPlayIndex];
    _songNameLabel.text = dic[@"title"];
    _singerNameLabel.text = [NSString stringWithFormat:@"—— %@ ——",dic[@"author"]];
    _catchProgress.progress = 0;
}

- (void)swhichToLastSong:(UIButton *)btn{
    
    if (_player.currentPlayIndex == 0) {
        return;
    }
    [_player prev];
    /**
     *  更新歌曲名
     */
    NSDictionary *dic = [_listArray objectAtIndex:_player.currentPlayIndex];
    _songNameLabel.text = dic[@"title"];
    _singerNameLabel.text = [NSString stringWithFormat:@"—— %@ ——",dic[@"author"]];
    _catchProgress.progress = 0;

}

- (void)pauseAction:(UIButton *)btn{
    
    if (_player.playState == APlayerStatePlaying) {
        //播放中 --> 暂停
        [_player pause];
        [_pauseBtn setImage:[UIImage imageNamed:@"player_btn_play_normal"] forState:UIControlStateNormal];
        [_pauseBtn setImage:[UIImage imageNamed:@"player_btn_play_highlight"] forState:UIControlStateHighlighted];
    }else if (_player.playState == APlayerStatePause){
        //暂停 --> 恢复播放
        [_player play];
        [_pauseBtn setImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:UIControlStateNormal];
        [_pauseBtn setImage:[UIImage imageNamed:@"player_btn_pause_highlight"] forState:UIControlStateHighlighted];
    }
}

- (void)updatePlayProgress:(NSTimeInterval)time
{
    
    NSInteger duration = _player.duration;
    _totalTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",duration/60, duration%60];
    
    NSInteger current = _player.currentTime;
    _currentTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",current/60, current%60];
    
    if(!_progressSlider.tracking) {
        _progressSlider.value = time / [MusicAPlayer sharedInstance].duration;
    }
}

- (void)sliderValueChanged:(UISlider *)slider{
    
    NSTimeInterval curtime = [MusicAPlayer sharedInstance].duration * _progressSlider.value;
    [MusicAPlayer sharedInstance].currentTime = curtime;
}

#pragma mark - play delegate

/**歌曲playItem开始播放，还没有prepare成功*/
- (void)player:(MusicAPlayer *)player readyToPlay:(id)playItem{
    
}

/**歌曲playItem prepare成功*/
- (void)player:(MusicAPlayer *)player didBecomeAvailable:(id)playItem{

}

/**缓存进度0.0~1.0*/
- (void)player:(MusicAPlayer *)player cacheProgress:(float)progress{
    [_catchProgress setProgress:progress animated:YES];
}

/**播放时间*/
- (void)player:(MusicAPlayer *)player playedTime:(NSTimeInterval)time{
    
    [self updatePlayProgress:time];
}

/**playItem自然播放结束*/
- (void)player:(MusicAPlayer *)player playItemEnd:(id)playItem{

}


@end
