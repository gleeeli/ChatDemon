//
//  UserModel.h
//  GetChat
//
//  Created by luoluo on 16/3/16.
//  Copyright © 2016年 luolei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface UserModel : BaseModel
@property(nonatomic,copy) NSString *jidS;
@property(nonatomic,copy) NSString *nameS;

@end
