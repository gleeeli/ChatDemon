//
//  ResisterVC.m
//  GetChat
//
//  Created by luoluo on 16/3/14.
//  Copyright © 2016年 luolei. All rights reserved.
//

#import "ResisterVC.h"

@interface ResisterVC ()
@property (weak, nonatomic) IBOutlet UITextField *NameTF;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *ResisterB;

@end

@implementation ResisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ResisterStartAction:(id)sender {
    
    LLXMPPManager *manager = [LLXMPPManager sharedInstance];
    [manager registWithUsername:_NameTF.text password:_PasswordTF.text success:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [HUDManager showHUD:0 hide:YES afterDelay:1 enabled:YES message:@"register success"];
        });
        
        
        NSLog(@"register success");
    } failure:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDManager showHUD:0 hide:YES afterDelay:1 enabled:YES message:@"register failture"];
        });
        
        NSLog(@"register failture");
    }];
    NSLog(@"开始注册");
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
