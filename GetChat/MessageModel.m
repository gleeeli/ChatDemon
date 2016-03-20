//
//  MessageModel.m
//  GetChat
//
//  Created by luoluo on 16/3/17.
//  Copyright © 2016年 luolei. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _type = [aDecoder decodeIntegerForKey:@"type"];
        _from = [aDecoder decodeObjectForKey:@"from"];
        _to = [aDecoder decodeObjectForKey:@"to"];
        _message = [aDecoder decodeObjectForKey:@"message"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_type forKey:@"type"];
    [aCoder encodeObject:_from forKey:@"from"];
    [aCoder encodeObject:_to forKey:@"to"];
    [aCoder encodeObject:_from forKey:@"from"];
}

@end
