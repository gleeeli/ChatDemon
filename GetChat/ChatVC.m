//
//  ChatVC.m
//  GetChat
//
//  Created by luoluo on 16/3/17.
//  Copyright © 2016年 luolei. All rights reserved.
//

#import "ChatVC.h"
#import "MessageModel.h"

@interface ChatVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *SendButton;
@property (weak, nonatomic) IBOutlet UITableView *ChatTableview;
@property(nonatomic,strong) NSMutableArray *messageListS;
@end

@implementation ChatVC{
    LLXMPPManager *_manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _manager = [LLXMPPManager sharedInstance];
    //实现接收消息
    [_manager monitorReciveMessage:^(MessageModel *model) {
        //判断是不是当前聊天者, 发给咱们的信息
        if([model.from isEqualToString:self.model.jidS])
        {
            [self.messageListS addObject:model];
            [self.ChatTableview reloadData];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)messageListS
{
    if (_messageListS == nil) {
        _messageListS = [[NSMutableArray alloc]init];
    }
    return _messageListS;
}
- (IBAction)sencClick:(id)sender {
    
    //干两件时间
    //1.显示到界面
    MessageModel *model = [[MessageModel alloc] init];
    model.type = MessageTypeSend;
    model.from = _manager.jidString;
    model.to = self.model.jidS;
    model.message = _inputTextField.text;
    
    [self.messageListS addObject:model];
    [self.ChatTableview reloadData];
    _inputTextField.text = @"";
    
    //2.利用xmpp把消息发送到服务器
    [_manager sendMessage:model.message toUser:model.to];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.messageListS.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0" forIndexPath:indexPath];
    
    // Configure the cell...
    
    MessageModel *messageModel = (MessageModel *)self.messageListS[indexPath.row];
    
    if (messageModel.type == MessageTypeSend) {
        
        cell.textLabel.textColor = [UIColor redColor];
    }else{
        cell.textLabel.textColor = [UIColor greenColor];
    }
    cell.textLabel.text = messageModel.from;
    cell.detailTextLabel.text = messageModel.message;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
