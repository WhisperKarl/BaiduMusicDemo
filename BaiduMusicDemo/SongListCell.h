//
//  SongListCell.h
//  BaiduMusicDemo
//
//  Created by Karl on 16/7/5.
//  Copyright © 2016年 Karl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bigImage;

@property (weak, nonatomic) IBOutlet UILabel *songName;

@property (weak, nonatomic) IBOutlet UILabel *singerName;

@property (weak, nonatomic) IBOutlet UILabel *songLength;


@end
