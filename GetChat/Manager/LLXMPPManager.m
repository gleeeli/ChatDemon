//
//  LLXMPPManager.m
//  test_xmpp
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 youshixiu. All rights reserved.
//

#import "LLXMPPManager.h"
#import "XMPPFramework.h"
#import <XMPPFramework/XMPPReconnect.h>
#import <XMPPFramework/XMPPRoster.h>
#import <XMPPFramework/XMPPRosterCoreDataStorage.h>
#import "MessageModel.h"

#define TempHostName @"1000phone.net"

@implementation LLXMPPManager{
    XMPPStream *_xmppStream;
    XMPPReconnect *_xmppReconnect;
    XMPPRoster *_xmppRoster;
    XMPPRosterCoreDataStorage *_xmppRosterStorage;
    //连接
    void (^_connectSucess)();
    void (^_connectFailure)();
    
    //注册
    void (^_registerSuccess)();
    void (^_registerFailure)();
    
    
    //登陆
    void (^_loginSuccess)();
    void (^_loginFailure)();
    
    //列表
    void (^_getUserListSuccess)(NSMutableArray *);
    void (^_getUserListFailture)();
    //接受消息
     void(^_reciveMessage)(MessageModel *model);
    BOOL(^_reciveAddFriendRequest)();
     NSString *_password;
}

-(NSMutableArray *)userListS
{
    if (_userListS == nil) {
        _userListS = [[NSMutableArray alloc]init];
    }
    return _userListS;
}

+(id)sharedInstance
{
    static LLXMPPManager *xmppManager = nil;
    if(xmppManager == nil)
    {
        xmppManager = [[LLXMPPManager alloc] init];
        
        //初始化操作
    }
    return xmppManager;
}

-(id)init
{
    if (self = [super init]) {
        //初始化xmmpp
        [self setUpStream];
    }
    
    return self;
}
-(NSString *)jidString
{
    return [NSString stringWithFormat:@"%@@%@",_xmppStream.myJID.user,_xmppStream.myJID.domain];
}
//设置XMPPStream
-(void)setUpStream
{
    assert(_xmppStream == nil);
    _xmppStream = [[XMPPStream alloc]init];
    //此处代理相当于socket的代理
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
   //自动重新连接
    _xmppReconnect = [[XMPPReconnect alloc]init];
    //激活
    [_xmppReconnect activate:_xmppStream];
    
    //初始化花名册
    _xmppRosterStorage = [[XMPPRosterCoreDataStorage alloc]init];
    _xmppRoster = [[XMPPRoster alloc]initWithRosterStorage:_xmppRosterStorage];
    [_xmppRoster activate:_xmppStream];
    [_xmppRoster addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];

}
//销毁XMPPStream
-(void)teardownStream
{
    [_xmppStream removeDelegate:self];
    //取消注册的所有模块
    [_xmppReconnect deactivate];
    [_xmppStream disconnect];
    //释放内存
    _xmppStream = nil;
    _xmppReconnect = nil;
}

//通知服务器我上线了
-(void)goOnline
{
    //默认类型“available”
    XMPPPresence *presence = [XMPPPresence presence];
    //通知所有好友---无回调
    [_xmppStream sendElement:presence];
}
//通知服务器我下线了
-(void)goOffline
{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:presence];
}
//与服务器断开连接
-(void)disconnect
{
    [self goOffline];
    [_xmppStream disconnect];
}

//后台支持
-(void)BackgroundSuport
{
    
#if  !TARGET_IPHONE_SIMULATOR
    [_xmppStream setEnableBackgroundingOnSocket:YES];
#endif
}

#pragma mark 连接
-(BOOL)connectToServer:(NSString *)host
               success:(void (^)())sucess
               failure:(void(^)())failure
{
    _connectSucess=sucess;
    _connectFailure = failure;
    
    if ( [_xmppStream isConnected] || host.length <=0) {
        return NO;
    }
    
    /*
     @description 连接服务器 JID格式：用户名@服务器域名
     */
    NSString *jidString = [NSString stringWithFormat:@"%@@%@",@"anonymous",TempHostName];
    //此处jid设置了一个随意值 但是不能为空
    [_xmppStream setMyJID:[XMPPJID jidWithString:jidString]];
    //设置连接的服务器
    [_xmppStream setHostName:host];
    //开始连接
    [_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:nil];
    
    return YES;
    
}

- (void)xmppStreamDidConnect:(XMPPStream *)sender//登陆服务器成功
{
    
       _connectSucess();
}

-(void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    NSLog(@"disconnect error=%@",error);
    _connectFailure();
}

#pragma mark 注册

-(BOOL)registWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(void (^)())success
                  failure:(void (^)())failure;
{
    //如果没有连接则直接返回
    if(_xmppStream.isConnected == NO)
    {
        return NO;
    }
    
    _registerSuccess = success;
    _registerFailure = failure;
    
    NSString *jid = [[NSString alloc] initWithFormat:@"%@@%@", username,TempHostName];
    NSLog(@"jid = %@",jid);
    [_xmppStream setMyJID:[XMPPJID jidWithString:jid]];
    NSError *error=nil;
    if (![_xmppStream registerWithPassword:password error:&error])
    {
        NSLog(@"error=%@",error);
        return NO;
    }
    return YES;
}

-(void)xmppStreamDidRegister:(XMPPStream *)sender
{
    NSLog(@"register success =%@",sender.description);
    _registerSuccess();
}

- (void)xmppStream:(XMPPStream *)sender didNotRegister:(NSXMLElement *)error
{
    //注意: 如果错误码是 409, 说明这个用户已经注册
    NSString *errorCode = [[[error elementForName:@"error"] attributeForName:@"code"] stringValue];
    NSLog(@"error code = %@ description=%@",errorCode,[error description]);
    _registerFailure();
}

#pragma makrk - 登陆

//需要实现的操作
//登陆
//注意: 登陆的时候同时连接, 异步操作
-(BOOL)loginWithUsername:(NSString *)userId
                password:(NSString *)password
                 success:(void (^)())success
                 failure:(void (^)())failure
{
    //先检查是否登录(授权)
    if (_xmppStream.isAuthenticated) {
        return NO;
    }
    
    _password = password;
    _loginSuccess = success;
    _loginFailure = failure;
    
    //如果未传入用户名或密码, 直接返回
    if (userId == nil || password == nil) {
        return NO;
    }
    
    //验证帐户密码
    NSError *error = nil;
    NSString *jidString = [[NSString alloc] initWithFormat:@"%@@%@", userId, TempHostName];
    _xmppStream.myJID = [XMPPJID jidWithString:jidString];
    BOOL bRes =  [_xmppStream authenticateWithPassword:_password error:&error];
    
    return YES;
    
}

//验证成功的回调函数

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender

{
    XMPPPresence *presence = [XMPPPresence presence];
    //可以加上上线状态，比如忙碌，在线等
    [_xmppStream sendElement:presence];//发送上线通知
    
    //回调
    if(_loginSuccess)
    {
        _loginSuccess();
    }
}

//验证失败的回调

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    //NSLog(@"登陆失败 error = %@",error);
    
    //回调
    if(_loginFailure)
    {
        _loginFailure();
    }
}

#pragma mark 消息发送和接收
/*
<message chat=? to=?  >
 <body>   </body>
</message>
*/
- (void)sendMessage:(NSString *)message toUser:(NSString *) jid {
    
    NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
    [body setStringValue:message];
    NSXMLElement *messageElement = [NSXMLElement elementWithName:@"message"];
    [messageElement addAttributeWithName:@"type" stringValue:@"chat"];
    NSString *to = [NSString stringWithFormat:@"%@", jid];
    [messageElement addAttributeWithName:@"to" stringValue:to];
    [messageElement addChild:body];
    NSLog(@"messageElement = %@",messageElement);
    [_xmppStream sendElement:messageElement];
    
}
/*
 接收到的消息格式
 <message xmlns="jabber:client" from="liguangluo3@device.im/Spark" id="LbX30-51" to="liguangluo4@device.im/104993393-tigase-26" type="chat">
 <thread>hPQN417</thread>
 <active xmlns="http://jabber.org/protocol/chatstates"/>
 </message>
 */
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    NSLog(@"message=%@",message);
    NSString *messageBody = [[message elementForName:@"body"] stringValue];
    NSString *from = [[message attributeForName:@"from"] stringValue];
    NSLog(@"接收到 %@ 的消息 messageBody=%@",from, messageBody);
    
    MessageModel *model = [[MessageModel alloc]init];
    model.type = MessageTypeRevice;
    model.message = messageBody;
    
    XMPPJID *jid = [XMPPJID jidWithString:from];
    model.from = [NSString stringWithFormat:@"%@%@",jid.user,jid.domain];
    model.to = self.jidString;
    if(_reciveMessage)
    {
        _reciveMessage(model);
    }
}

- (void)monitorReciveMessage:(void(^)(MessageModel *model))dealReciveFunc
{
    _reciveMessage = dealReciveFunc;
}

- (void)xmppStream:(XMPPStream *)sender didFailToSendMessage:(XMPPMessage *)message error:(NSError *)error
{
    NSLog(@"send message fail error=%@",error);
}

#pragma mark 好友列表

-(void)getUserListSuccess:(void(^)(NSMutableArray *userlistS))success
                 failture:(void(^)())failture
{
    _getUserListSuccess = success;
    _getUserListFailture = failture;
    
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
    [iq addAttributeWithName:@"from" stringValue:_xmppStream.myJID.description];
    [iq addAttributeWithName:@"to" stringValue:_xmppStream.myJID.domain];
    [iq addAttributeWithName:@"id" stringValue:@"comomenID"];
    [iq addAttributeWithName:@"type" stringValue:@"get"];
    NSXMLElement *query = [NSXMLElement elementWithName:@"query" xmlns:@"jabber:iq:roster"];
    [iq addChild:query];
    [_xmppStream sendElement:iq];
    
}

-(BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
    NSLog(@"iq=%@",iq.description);
    NSMutableArray *userListS = [[NSMutableArray alloc]init];
    if ([iq.type isEqualToString:@"result"]) {
        NSXMLElement *query = iq.childElement;
        if ([query.name isEqualToString:@"query"]) {
            NSArray *items = [query children];
            for (NSXMLElement *item in items) {
                NSString *jid = [item attributeStringValueForName:@"jid"];
                NSString *name = [item attributeStringValueForName:@"name"];
                
                UserModel *model = [[UserModel alloc]init];
                model.jidS = jid;
                model.nameS = name;
                [userListS addObject:model];
                
            }
        }
    }
        _userListS = userListS;//保存在单列内
    if (_getUserListSuccess) {
        _getUserListSuccess(userListS);
    }
    return YES;
}

- (void)xmppStream:(XMPPStream *)sender didFailToSendIQ:(XMPPIQ *)iq error:(NSError *)error
{
    NSLog(@"did failt tosendIQ error=%@",error);
}

- (void)xmppStream:(XMPPStream *)sender didReceiveError:(NSXMLElement *)error
{
    NSLog(@"did receceive error=%@",error.description);
}

#pragma mark 发送添加好友
-(void)sendAddFriendRequestWithJidString:(NSString *)jidString
{
    // 判断是否已经是好友
    XMPPJID *jid = [XMPPJID jidWithString:jidString];
    if (![_xmppRosterStorage userExistsWithJID:jid xmppStream:_xmppStream]) {
        NSLog(@"send to add friend");
        // 发送好友订阅请求
        [_xmppRoster subscribePresenceToUser:jid];
    }else{
        NSLog(@"it is friend");
    }
    
   
}

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    
    // 1. 取得好友当前类型（状态）
    NSString *presenceType = [presence type];
    // 2. 如果是用户订阅，则添加用户
    if ([presenceType isEqualToString:@"subscribe"]) {
        NSLog(@"接收到好友请求");
        BOOL b = NO;
        if(_reciveAddFriendRequest){
            b = _reciveAddFriendRequest();
        }
        if(b){
            // 接收好友订阅请求
            [_xmppRoster acceptPresenceSubscriptionRequestFrom:[presence from] andAddToRoster:YES];
        }
    }
}

@end
