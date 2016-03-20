//
//  LoginVC.m
//  GetChat
//
//  Created by luoluo on 16/3/14.
//  Copyright © 2016年 luolei. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *UserNameTF;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UIButton *LoginStartB;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 luoluo3 password=123456  ios1407 zq123456
 */
- (IBAction)LogingStartAction:(id)sender {
    
    LLXMPPManager *manager = [LLXMPPManager sharedInstance];
    if (_UserNameTF.text.length >0 && _Password.text.length >0) {
        
        [manager loginWithUsername:self.UserNameTF.text password:_Password.text success:^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDManager showHUD:MBProgressHUDModeIndeterminate hide:YES afterDelay:1 enabled:YES message:@"login success"];
            });
            //获取好友列表
            [self getUserListData];
            NSLog(@"login success");
            
        } failure:^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDManager showHUD:MBProgressHUDModeIndeterminate hide:YES afterDelay:2 enabled:YES message:@"login failture"];
            });
            
            NSLog(@"login failture");
        }];
    }
   
    
    NSLog(@"开始登录");
}

-(void)getUserListData
{
    LLXMPPManager *manager = [LLXMPPManager sharedInstance];
    [manager getUserListSuccess:^(NSMutableArray *userlistS) {
        
        NSLog(@"get userList success");
    } failture:^{
        NSLog(@"get userList faiture");
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
