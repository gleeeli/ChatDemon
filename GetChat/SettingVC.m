//
//  SettingVC.m
//  GetChat
//
//  Created by luoluo on 16/3/14.
//  Copyright © 2016年 luolei. All rights reserved.
//

#import "SettingVC.h"

@interface SettingVC ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UIButton *addFriendB;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LLXMPPManager *manger = [[LLXMPPManager alloc]init];
    [manger monitorReciveMessage:^(MessageModel *model) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDManager showHUD:MBProgressHUDModeIndeterminate hide:YES afterDelay:1 enabled:YES message:@"add friend success"];
        });
        NSLog(@"接受好友请求成功");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnClick:(id)sender {
    LLXMPPManager *manger = [[LLXMPPManager alloc]init];
    [manger sendAddFriendRequestWithJidString:[NSString stringWithFormat:@"%@@1000phone.net",self.userNameTF.text]];
}

@end
