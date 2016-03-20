//
//  LLXMPPManager.h
//  test_xmpp
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 youshixiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageModel.h"
#import "GetXmppMessageProtocol.h"

@interface LLXMPPManager : NSObject
@property(nonatomic,weak) id<GetXmppMessageProtocol> delegete;

-(NSString *)jidString;

@property(nonatomic,strong) NSMutableArray *userListS;
//获取单例方法
+(id)sharedInstance;

//连接服务器
-(BOOL)connectToServer:(NSString *)host
               success:(void (^)())sucess
               failure:(void(^)())failure;
//注册账号
-(BOOL)registWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(void (^)())success
                  failure:(void (^)())failure;

-(BOOL)loginWithUsername:(NSString *)userId
                password:(NSString *)password
                 success:(void (^)())success
                 failure:(void (^)())failure;
//获取用户列表
-(void)getUserListSuccess:(void(^)(NSMutableArray *userlistS))success
                 failture:(void(^)())failture;
//发送消息
- (void)sendMessage:(NSString *)message toUser:(NSString *) jid;
//接受消息的block
- (void)monitorReciveMessage:(void(^)(MessageModel *model))dealReciveFunc;
//发送添加好友
-(void)sendAddFriendRequestWithJidString:(NSString *)jidString;

@end
