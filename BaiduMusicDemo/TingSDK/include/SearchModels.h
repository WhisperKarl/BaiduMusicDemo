//
//  SearchModel.h
//  TingIPhone
//
//  Created by wanghq on 15-4-21.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "JSONModel_Ting.h"

@interface SearchSceneItemModel : JSONModel_Ting

@property (strong, nonatomic) NSString *scene_id;
@property (strong, nonatomic) NSString *scene_name;

@end

@protocol SearchSceneItemModel <NSObject>


@end

@protocol NSDictionary <NSObject>

@end


@interface SearchInfoModel : JSONModel_Ting

@property (strong, nonatomic) NSString<Optional> *total;
@property(strong, nonatomic) NSArray<SearchSceneItemModel, Optional> *scene_list;
@property(strong, nonatomic) NSArray<NSDictionary, Optional> *song_list;

@end


@interface SearchResultModel : JSONModel_Ting

@property (strong, nonatomic) NSString<Optional> *rqt_type;
@property (strong, nonatomic) SearchInfoModel<Optional> *scene_info;

@end


