//
//  MainRecDefaultModel.h
//  TingIPhone
//
//  Created by lfli on 15-1-13.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "JSONModel_Ting.h"
#import "SceneBaseModel.h"

@protocol ScenePeriodModel <NSObject>

@end

@interface ScenePeriodModel : JSONModel_Ting

@property (strong, nonatomic) NSString *end_time;

@property (strong, nonatomic) NSString *start_time;

@property (strong, nonatomic) NSString *result;

@end

@interface SceneModels : JSONModel_Ting

@property(strong, nonatomic) NSArray<ScenePeriodModel> *scene_period;
@property(strong, nonatomic) NSArray<SceneBaseModel> *scene_info;
@property(assign, nonatomic) NSNumber<Optional> *scene_version;

@end


