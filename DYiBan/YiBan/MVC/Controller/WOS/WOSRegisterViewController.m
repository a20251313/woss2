//
//  WOSRegisterViewController.m
//  WOS
//
//  Created by apple on 14-5-11.
//  Copyright (c) 2014年 ZzL. All rights reserved.
//

#import "WOSRegisterViewController.h"
#import "DYBInputView.h"
#import "CALayer+Custom.h"
#import "NSString+SBJSON.h"



@interface WOSRegisterViewController (){

    DYBInputView    * _phoneInputName;
    UIScrollView    *scrollView;
}

@end

@implementation WOSRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)handleViewSignal_MagicViewController:(MagicViewSignal *)signal{
    
    DLogInfo(@"name -- %@",signal.name);
    
    if ([signal is:[MagicViewController LAYOUT_VIEWS]])
    {
        //        [self.rightButton setHidden:YES];
        [self.headview setTitle:@"注册"];
        //        [self.headview setBackgroundColor:[UIColor colorWithRed:97.0f/255 green:97.0f/255 blue:97.0f/255 alpha:1.0]];
        [self.headview setTitleColor:[UIColor colorWithRed:193.0f/255 green:193.0f/255 blue:193.0f/255 alpha:1.0f]];
        [self setButtonImage:self.leftButton setImage:@"返回键"];
        [self.view setBackgroundColor:ColorBG];
        [self.headview setBackgroundColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
    }
    else if ([signal is:[MagicViewController CREATE_VIEWS]]) {
        UIImage *imageK = [UIImage imageNamed:@"框"];
        
        UIImageView *imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake((320 - 0 - 60)/2 , self.headHeight + 20, 60.0f, 60.0f)];
        [imageViewIcon setImage:[UIImage imageNamed:@"log"]];
       
        
        [self.rightButton setHidden:YES];
        
        [self.view setBackgroundColor:[UIColor clearColor]];
        
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.view.frame.size.height)];
        [scrollView setContentSize: CGSizeMake(320.0f, self.view.frame.size.height * 1.5)];
        [self.view addSubview:scrollView];

        
        [scrollView addSubview:imageViewIcon];
        [imageViewIcon release];

        
        //        arrayTitle = [[NSArray alloc]initWithObjects:@"告诉朋友",@"意见反馈",@"常用问题",@"关于",@"访问订餐网站", nil];
        
        
//        圆角矩形 
        
        UIImage *iamge1 = [UIImage imageNamed:@"圆角矩形 "];
        UIImageView *imageViewName2 = [[UIImageView alloc]initWithFrame:CGRectMake((320-imageK.size.width/2)/2 ,self.headHeight + 60 + 30, imageK.size.width/2, iamge1.size.height/2)];
        [imageViewName2 setImage:[UIImage imageNamed:@"圆角矩形 "]];
        [imageViewName2 setUserInteractionEnabled:YES];
        [scrollView addSubview:imageViewName2];
        RELEASE(imageViewName2);
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 0.0f, 100, 40)];
        [label1 setBackgroundColor:[UIColor clearColor]];
        [label1 setText:@"姓名："];
        [label1 setTextColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];

        [imageViewName2 addSubview:label1];
        
     DYBInputView   *input1 = [[DYBInputView alloc]initWithFrame:CGRectMake(60, 0, INPUTWIDTH, INPUTHEIGHT) placeText:@"或其他个性用户名" textType:0];
        [input1.layer AddborderByIsMasksToBounds:YES cornerRadius:4 borderWidth:1 borderColor:[[UIColor clearColor] CGColor]];
//        [input1.nameField setText:@""];
        [input1.nameField setTextColor:[UIColor whiteColor]];
        input1.tag =  1000;
        [input1 setBackgroundColor:[UIColor clearColor]];
        [imageViewName2 addSubview:input1];
        RELEASE(input1)
        
        
//        DYBInputView *  _phoneInputAddr = [[DYBInputView alloc]initWithFrame:CGRectMake((320-INPUTWIDTH)/2,self.headHeight + 60, INPUTWIDTH, INPUTHEIGHT)placeText:@"请输入注册时填写的电子邮箱" textType:0];
//        [_phoneInputAddr.layer AddborderByIsMasksToBounds:YES cornerRadius:4 borderWidth:1 borderColor:[[UIColor clearColor] CGColor]];
//        [_phoneInputAddr.nameField setText:@"1"];
//        [_phoneInputAddr.nameField setTextColor:[UIColor whiteColor]];
//        [_phoneInputAddr setBackgroundColor:[UIColor clearColor]];
//        [self.view addSubview:_phoneInputAddr];
//        RELEASE(_phoneInputAddr);
       
        
        UIImageView *imageViewName = [[UIImageView alloc]initWithFrame:CGRectMake((320-imageK.size.width/2)/2, CGRectGetHeight(imageViewName2.frame) + CGRectGetMinY(imageViewName2.frame) + 10, imageK.size.width/2, imageK.size.height/2 )];
        [imageViewName setUserInteractionEnabled:YES];
        [imageViewName setImage:imageK];
        [scrollView addSubview:imageViewName];
        RELEASE(imageViewName);
        
        UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake(5.0f, 0.0f,  70 , imageK.size.height/2/2)];
       [labelName setText:@"密码："];
        [labelName setBackgroundColor:[UIColor clearColor]];
        [labelName setTextColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
        [imageViewName addSubview:labelName];
        RELEASE(labelName);
        
        
        _phoneInputName = [[DYBInputView alloc]initWithFrame:CGRectMake(60, 0, INPUTWIDTH, INPUTHEIGHT) placeText:@"请设置密码" textType:0];
        [_phoneInputName.layer AddborderByIsMasksToBounds:YES cornerRadius:4 borderWidth:1 borderColor:[[UIColor clearColor] CGColor]];
        [_phoneInputName.nameField setText:@"zxw1"];
        _phoneInputName.nameField.secureTextEntry = YES;
        _phoneInputName.tag = 1001;
        [_phoneInputName.nameField setTextColor:[UIColor whiteColor]];
        [_phoneInputName setBackgroundColor:[UIColor clearColor]];
        [imageViewName addSubview:_phoneInputName];
        RELEASE(_phoneInputName)
        
        UILabel *labelmima = [[UILabel alloc]initWithFrame:CGRectMake(5.0f, imageK.size.height/2/2, 70 , imageK.size.height/2/2)];
        [labelmima setText:@"确认："];
        [labelmima setTextColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
        [labelmima setBackgroundColor:[UIColor clearColor]];
        [imageViewName addSubview:labelmima];
        RELEASE(labelmima);
        
      DYBInputView*  _phoneInputAddr = [[DYBInputView alloc]initWithFrame:CGRectMake(60, imageK.size.height/2/2/2+ 15, INPUTWIDTH, INPUTHEIGHT) placeText:@"请再次输入密码" textType:0];
        [_phoneInputAddr.layer AddborderByIsMasksToBounds:YES cornerRadius:4 borderWidth:1 borderColor:[[UIColor clearColor] CGColor]];
        [_phoneInputAddr.nameField setText:@"zxw1"];
        _phoneInputAddr.tag = 1002;
        _phoneInputAddr.nameField.secureTextEntry = YES;
        [_phoneInputAddr.nameField setTextColor:[UIColor whiteColor]];
        [_phoneInputAddr setBackgroundColor:[UIColor clearColor]];
        [imageViewName addSubview:_phoneInputAddr];
        RELEASE(_phoneInputAddr);
        
        
        UIImageView *imageViewName22 = [[UIImageView alloc]initWithFrame:CGRectMake((320-imageK.size.width/2)/2 ,CGRectGetHeight(imageViewName.frame) + CGRectGetMinY(imageViewName.frame) + 10, imageK.size.width/2, iamge1.size.height/2)];
        [imageViewName22 setImage:[UIImage imageNamed:@"圆角矩形 "]];
        [imageViewName22 setUserInteractionEnabled:YES];

        [scrollView addSubview:imageViewName22];
        RELEASE(imageViewName22);
        
        UILabel *label11 = [[UILabel alloc]initWithFrame:CGRectMake(5.0f, 0.0f, 100, 40)];
        [label11 setBackgroundColor:[UIColor clearColor]];
        [label11 setText:@"手机："];
        [label11 setTextColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];

        [imageViewName22 addSubview:label11];
        
        DYBInputView   *input11 = [[DYBInputView alloc]initWithFrame:CGRectMake(60, 0, INPUTWIDTH, INPUTHEIGHT) placeText:@"方便确认订单" textType:0];
        [input11.layer AddborderByIsMasksToBounds:YES cornerRadius:4 borderWidth:1 borderColor:[[UIColor clearColor] CGColor]];
        //        [input1.nameField setText:@""];
        [input11.nameField setTextColor:[UIColor whiteColor]];
        [input11 setBackgroundColor:[UIColor clearColor]];
        input11.tag = 1003;
        [imageViewName22 addSubview:input11];
        RELEASE(input11)
        
        
        UIImageView *imageViewName222 = [[UIImageView alloc]initWithFrame:CGRectMake((320-imageK.size.width/2)/2 ,CGRectGetHeight(imageViewName22.frame) + CGRectGetMinY(imageViewName22.frame) + 10, imageK.size.width/2, iamge1.size.height/2)];
        [imageViewName222 setImage:[UIImage imageNamed:@"圆角矩形 "]];
        [imageViewName222 setUserInteractionEnabled:YES];

        [scrollView addSubview:imageViewName222];
        RELEASE(imageViewName222);
        
        UILabel *label111 = [[UILabel alloc]initWithFrame:CGRectMake(5.0f, 0.0f, 100, 40)];
        [label111 setBackgroundColor:[UIColor clearColor]];
        [label111 setText:@"邮箱："];
        [label111 setTextColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
        
        [imageViewName222 addSubview:label111];
        
        DYBInputView   *input111 = [[DYBInputView alloc]initWithFrame:CGRectMake(60, 0, INPUTWIDTH, INPUTHEIGHT) placeText:@"方便确认订单" textType:0];
        [input111.layer AddborderByIsMasksToBounds:YES cornerRadius:4 borderWidth:1 borderColor:[[UIColor clearColor] CGColor]];
        //        [input1.nameField setText:@""];
        [input111.nameField setTextColor:[UIColor whiteColor]];
        input111.tag = 1004;
        [input111 setBackgroundColor:[UIColor clearColor]];
        [imageViewName222 addSubview:input111];
        RELEASE(input111)

        
        
        UIButton *btnBack= [[UIButton alloc]initWithFrame:CGRectMake((320 - 44)/2, CGRectGetHeight(imageViewName222.frame) + CGRectGetMinY(imageViewName222.frame) + 20, 44, 44)];
        [btnBack setBackgroundColor:[UIColor clearColor]];
        [btnBack setImage:[UIImage imageNamed:@"剪头"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(addOK) forControlEvents:UIControlEventTouchUpInside];
        //        [self addlabel_title:@"登陆" frame:btnBack.frame view:btnBack];
        [scrollView addSubview:btnBack];
        [btnBack release];
        


    }
    
    
    else if ([signal is:[MagicViewController DID_APPEAR]]) {
        
        DLogInfo(@"rrr");
    } else if ([signal is:[MagicViewController DID_DISAPPEAR]]){
        
        
    }
}



- (void)handleViewSignal_MagicUITextField:(MagicViewSignal *)signal
{
    if ([signal is:[MagicUITextField TEXTFIELDDIDBEGINEDITING]])
    {
        
        CGRect frame =  scrollView.frame;
        frame.origin.y = -80;
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.frame = frame;
        }];
      //  [signal setCenter:CGPointMake(160.0f, 140.0)]; //test
        
    }else if ([signal is:[MagicUITextField TEXTFIELDSHOULDRETURN]])
    {
        [self.view endEditing:YES];
        
        CGRect frame =  scrollView.frame;
        frame.origin.y = 0;
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.frame = frame;
        }];
    }
}

-(void)addOK{

    if ([self checkInputIsValid])
    {
        
        DYBInputView    *name = (DYBInputView*)[scrollView viewWithTag:1000];
        DYBInputView    *pwd = (DYBInputView*)[scrollView viewWithTag:1001];
        DYBInputView    *phone = (DYBInputView*)[scrollView viewWithTag:1003];
        DYBInputView    *email = (DYBInputView*)[scrollView viewWithTag:1004];
        
        NSString    *strName = name.nameField.text;
        NSString    *strpwd = pwd.nameField.text;
        NSString    *strPhone = phone.nameField.text;
        NSString    *strEmail = email.nameField.text;
        
        
        
        MagicRequest *request = [DYBHttpMethod wosRegion_nickName:strName  passwd:strpwd sex:@"1" email:strEmail phone:strPhone sAlert:YES receive:self];
        [request setTag:3];
        
    }

}


-(BOOL)checkInputIsValid
{
    DYBInputView    *name = (DYBInputView*)[scrollView viewWithTag:1000];
    DYBInputView    *pwd = (DYBInputView*)[scrollView viewWithTag:1001];
    DYBInputView    *secpwd = (DYBInputView*)[scrollView viewWithTag:1002];
    DYBInputView    *phone = (DYBInputView*)[scrollView viewWithTag:1003];
    DYBInputView    *email = (DYBInputView*)[scrollView viewWithTag:1004];
    
    NSString    *strName = name.nameField.text;
    NSString    *strpwd = pwd.nameField.text;
    NSString    *strSecpwd = secpwd.nameField.text;
    NSString    *strPhone = phone.nameField.text;
    NSString    *strEmail = email.nameField.text;
    
    
    if ([strName length] < 1)
    {
        [self popText:@"昵称不能为空"];
        return NO;
    }
    if ([strpwd length] < 6)
    {
        [self popText:@"密码长度不合法，必须大于6位"];
        return NO;
    }
    if ([strSecpwd length] < 6)
    {
        [self popText:@"请重新输入确认密码"];
        return NO;
    }
    if (![strSecpwd isEqualToString:strpwd])
    {
        [self popText:@"两次输入密码不一致"];
        return NO;
    }
    if ([strPhone length] < 11)
    {
        [self popText:@"手机号码不合法"];
        return NO;
    }
    if ([strEmail length] < 1)
    {
        [self popText:@"请输入邮箱"];
        return NO;
    }
    
    if (![self isMobileNumber:strPhone])
    {
        [self popText:@"手机号码不合法"];
        return NO;
        
    }
    
    if (![self checkEmailFormat:strEmail])
    {
        [self popText:@"请输入邮箱"];
        return NO;
    }
    
    return YES;
}



- (BOOL)checkEmailFormat:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}




-(BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)popText:(NSString*)popText
{
    [DYBShareinstaceDelegate popViewText:popText target:self hideTime:1.0f isRelease:YES mode:MagicPOPALERTVIEWINDICATOR];
}
-(void)dealloc
{
    [scrollView release];
    scrollView = nil;
    [super dealloc];
}



#pragma mark- HTTP
#pragma mark- 只接受HTTP信号
- (void)handleRequest:(MagicRequest *)request receiveObj:(id)receiveObj
{
    
    if ([request succeed])
    {
        //        JsonResponse *response = (JsonResponse *)receiveObj;
        if(request.tag == 3){
            
            NSDictionary *dict = [request.responseString JSONValue];
            
            if (dict) {
                BOOL result = [[dict objectForKey:@"result"] boolValue];
                if (!result) {
                     [DYBShareinstaceDelegate popViewText:@"注册成功" target:self hideTime:.5f isRelease:YES mode:MagicPOPALERTVIEWINDICATOR];
                  
                    [self.drNavigationController popViewControllerAnimated:YES];
                }
                else{
                    NSString *strMSG = [dict objectForKey:@"message"];
                    
                    [DYBShareinstaceDelegate popViewText:strMSG target:self hideTime:.5f isRelease:YES mode:MagicPOPALERTVIEWINDICATOR];
                    
                    
                }
            }
            
        } else{
            NSDictionary *dict = [request.responseString JSONValue];
            NSString *strMSG = [dict objectForKey:@"message"];
            
            [DYBShareinstaceDelegate popViewText:strMSG target:self hideTime:.5f isRelease:YES mode:MagicPOPALERTVIEWINDICATOR];
            
            
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
