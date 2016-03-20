//
//  MessageModel.h
//  GetChat
//
//  Created by luoluo on 16/3/17.
//  Copyright © 2016年 luolei. All rights reserved.
//

#import "BaseModel.h"

typedef enum MessageType{
    MessageTypeSend,
    MessageTypeRevice
}MessageType;

@interface MessageModel : BaseModel

@property (assign,nonatomic) MessageType type;
@property (copy,nonatomic) NSString *message;
@property (copy,nonatomic) NSString *from;
@property (copy,nonatomic) NSString *to;
@end
