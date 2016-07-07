//
//  PlayDetailController.m
//  BaiduMusicDemo
//
//  Created by Karl on 16/7/6.
//  Copyright © 2016年 Karl. All rights reserved.
//

#import "PlayDetailController.h"
#import "MusicAPlayer.h"
@interface PlayDetailController ()<MusicAPlayerDelegate>{
    
    UIButton *_pauseBtn;
    UIButton *_nextBtn;
    UIButton *_lastBtn;
    UISlider *_progressSlider;
    UILabel *_songNameLabel;
    UILabel *_singerNameLabel;
    UILabel *_currentTimeLabel;
    UILabel *_totalTimeLabel;
    MusicAPlayer *_player;
}

@end

@implementation PlayDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _player = [MusicAPlayer sharedInstance];
    _player.delegate = self;
    [self configureUI];
}



- (void)configureUI{
    
    _progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, SCREEN_HEIGHT-40, SCREEN_WIDTH-100, 20)];
    _progressSlider.maximumValue = 1;
    _progressSlider.minimumValue = 0;
    [_progressSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    _progressSlider.value = _player.currentTime / _player.duration;
    [self.view addSubview:_progressSlider];
    
    _currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, SCREEN_HEIGHT-40 ,40, 20)];
    _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    _currentTimeLabel.font = [UIFont systemFontOfSize:12];
    _currentTimeLabel.textColor = [UIColor colorWithRed:0.298 green:0.298 blue:0.294 alpha:1.000];
    [self.view addSubview:_currentTimeLabel];
    
    _totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40 - 5, SCREEN_HEIGHT-40, 40, 20)];
    _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    _totalTimeLabel.font = [UIFont systemFontOfSize:12];
    _totalTimeLabel.textColor = [UIColor colorWithRed:0.298 green:0.298 blue:0.294 alpha:1.000];
    
    [self.view addSubview:_totalTimeLabel];

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
    
}

/**播放时间*/
- (void)player:(MusicAPlayer *)player playedTime:(NSTimeInterval)time{
    NSLog(@"%f",time);
    NSLog(@"%f",_player.duration);
    [self updatePlayProgress:time];
}

/**playItem自然播放结束*/
- (void)player:(MusicAPlayer *)player playItemEnd:(id)playItem{

}


@end
