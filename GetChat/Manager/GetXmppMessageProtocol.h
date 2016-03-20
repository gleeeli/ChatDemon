//
//  GetXmppMessageProtocol.h
//  GetChat
//
//  Created by luoluo on 16/3/18.
//  Copyright © 2016年 luolei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMPPStream;
@class XMPPPresence;
@protocol GetXmppMessageProtocol <NSObject>

@optional
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence;

@end
