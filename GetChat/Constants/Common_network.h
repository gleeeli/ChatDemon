//
//  Common_network.h
//  testMkNetWork
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 youshixiu. All rights reserved.
//

#ifndef Common_network_h
#define Common_network_h

//https or http
#define kHttps @"https"
#define kHttp @"http"
#define isHttps 0

#define isTrueEnvironment 0
//后缀
#define kServerHostSuffix @"api"


#if isTrueEnvironment

#define kServerHost         @"www.xiaozibo.com:9000/xzbAppApiRest"
#define kIPHostArray @[]

#else

#define kIPHostArray @[@"192.168.1.104:8080"]

#define kServerResourceHost  [NetConfigure getIPResourceHost]
#define kServerHost [NetConfigure getIPHost]

#endif

#endif /* Common_network_h */
