//
//  SceneBaseModel.h
//  TingIPhone
//
//  Created by lfli on 15-1-15.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "JSONModel_Ting.h"

@protocol SceneBaseModel <NSObject>


@end

@interface SceneBaseModel : JSONModel_Ting

@property (strong, nonatomic) NSString *bgpic_ios;
@property (strong, nonatomic) NSString *icon_ios;
@property (strong, nonatomic) NSString *scene_desc;
@property (strong, nonatomic) NSString *scene_name;
@property (assign, nonatomic) NSInteger scene_id;
@property (assign, nonatomic) NSInteger scene_model;
@property (assign, nonatomic) NSInteger iTab;

@end
