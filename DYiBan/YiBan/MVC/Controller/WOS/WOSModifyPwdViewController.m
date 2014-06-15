//
//  WOSRegisterViewController.m
//  WOS
//
//  Created by apple on 14-5-11.
//  Copyright (c) 2014年 ZzL. All rights reserved.
//

#import "WOSModifyPwdViewController.h"
#import "DYBInputView.h"
#import "CALayer+Custom.h"
#import "WOSFindMIMAViewController.h"
#import "NSString+SBJSON.h"



@interface WOSModifyPwdViewController (){

    DYBInputView    * _origionPwd;
    DYBInputView    * _newPwd;
    DYBInputView    * _confiromPwd;;
    UIScrollView    *scrollView;
}

@end

@implementation WOSModifyPwdViewController

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
        [self.headview setTitle:@"修改密码"];
        //        [self.headview setBackgroundColor:[UIColor colorWithRed:97.0f/255 green:97.0f/255 blue:97.0f/255 alpha:1.0]];
        [self.headview setTitleColor:[UIColor colorWithRed:193.0f/255 green:193.0f/255 blue:193.0f/255 alpha:1.0f]];
        [self setButtonImage:self.leftButton setImage:@"返回键"];
        [self.view setBackgroundColor:ColorBG];
        [self.headview setBackgroundColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
    }
    else if ([signal is:[MagicViewController CREATE_VIEWS]]) {
     
        
        UIImage *imageK = [UIImage imageNamed:@"圆角矩形 "];

        
        [self.rightButton setHidden:YES];
        
        [self.view setBackgroundColor:[UIColor clearColor]];
        
        
       
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.view.frame.size.height)];
        [scrollView setContentSize: CGSizeMake(320.0f, self.view.frame.size.height-50)];
        [self.view addSubview:scrollView];

  

        CGFloat fypoint = self.headHeight + 30;

        
        
        UIImageView *imageViewName2 = [[UIImageView alloc]initWithFrame:CGRectMake((320-imageK.size.width/2)/2 ,fypoint, imageK.size.width/2, imageK.size.height/2)];
        [imageViewName2 setImage:[UIImage imageNamed:@"圆角矩形 "]];
        [imageViewName2 setUserInteractionEnabled:YES];
        [scrollView addSubview:imageViewName2];
        RELEASE(imageViewName2);
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(5, -5, 100, 40)];
        [label1 setBackgroundColor:[UIColor clearColor]];
        [label1 setText:@"原密码："];
        [label1 setTextColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];

        [imageViewName2 addSubview:label1];
        
        _origionPwd = [[DYBInputView alloc]initWithFrame:CGRectMake(60, -5, INPUTWIDTH, INPUTHEIGHT) placeText:@"您的原密码" textType:0];
        [_origionPwd.layer AddborderByIsMasksToBounds:YES cornerRadius:4 borderWidth:1 borderColor:[[UIColor clearColor] CGColor]];
//        [input1.nameField setText:@""];
         _origionPwd.nameField.font = [UIFont systemFontOfSize:13];
        _origionPwd.nameField.secureTextEntry = YES;
        [_origionPwd.nameField setTextColor:[UIColor whiteColor]];
        _origionPwd.tag =  1000;
        [_origionPwd setBackgroundColor:[UIColor clearColor]];
        [imageViewName2 addSubview:_origionPwd];
     
        
        
        UIImage *image11 = [UIImage imageNamed:@"？"];
        UIButton *btnADD1 = [[UIButton alloc]initWithFrame:CGRectMake(imageViewName2.frame.size.width-image11.size.width/2-8, 10, image11.size.width/2, image11.size.height/2)];
        [btnADD1 setImage:[UIImage imageNamed:@"？"] forState:UIControlStateNormal];
        [btnADD1 addTarget:self action:@selector(forgotPwd:) forControlEvents:UIControlEventTouchUpInside];
        [imageViewName2 addSubview:btnADD1];
        [btnADD1 release];
        

       
        fypoint += imageK.size.height/2+30;
        UIImageView *imageViewName = [[UIImageView alloc]initWithFrame:CGRectMake((320-imageK.size.width/2)/2,fypoint, imageK.size.width/2, imageK.size.height/2 )];
        [imageViewName setUserInteractionEnabled:YES];
        [imageViewName setImage:imageK];
        [scrollView addSubview:imageViewName];
        RELEASE(imageViewName);
        
        UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake(5.0f, -5,  70 ,40)];
        [labelName setText:@"密码："];
        [labelName setBackgroundColor:[UIColor clearColor]];
        [labelName setTextColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
        [imageViewName addSubview:labelName];
        RELEASE(labelName);
        
        
        _newPwd = [[DYBInputView alloc]initWithFrame:CGRectMake(60, -5, INPUTWIDTH, INPUTHEIGHT) placeText:@"输入新密码" textType:0];
        [_newPwd.layer AddborderByIsMasksToBounds:YES cornerRadius:4 borderWidth:1 borderColor:[[UIColor clearColor] CGColor]];
        _newPwd.nameField.secureTextEntry = YES;
         _newPwd.nameField.font = [UIFont systemFontOfSize:13];
        _newPwd.tag = 1001;
        [_newPwd.nameField setTextColor:[UIColor whiteColor]];
        [_newPwd setBackgroundColor:[UIColor clearColor]];
        [imageViewName addSubview:_newPwd];

        
        
        
        
        
        fypoint += imageK.size.height/2+30;
        
        UIImageView *imageViewNew = [[UIImageView alloc]initWithFrame:CGRectMake((320-imageK.size.width/2)/2,fypoint, imageK.size.width/2, imageK.size.height/2 )];
        [imageViewNew setUserInteractionEnabled:YES];
        [imageViewNew setImage:imageK];
        [scrollView addSubview:imageViewNew];
        RELEASE(imageViewNew);
        
        
        UILabel *labelmima = [[UILabel alloc]initWithFrame:CGRectMake(5.0f, -5, 70 , 40)];
        [labelmima setText:@"新密码："];
        [labelmima setTextColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
        [labelmima setBackgroundColor:[UIColor clearColor]];
        [imageViewNew addSubview:labelmima];
        RELEASE(labelmima);
        
        _confiromPwd = [[DYBInputView alloc]initWithFrame:CGRectMake(60,-5, INPUTWIDTH, INPUTHEIGHT) placeText:@"确认新密码" textType:0];
        [_confiromPwd.layer AddborderByIsMasksToBounds:YES cornerRadius:4 borderWidth:1 borderColor:[[UIColor clearColor] CGColor]];
        _confiromPwd.tag = 1002;
        _confiromPwd.nameField.secureTextEntry = YES;
        _confiromPwd.nameField.font = [UIFont systemFontOfSize:13];
        [_confiromPwd.nameField setTextColor:[UIColor whiteColor]];
        [_confiromPwd setBackgroundColor:[UIColor clearColor]];
        [imageViewNew addSubview:_confiromPwd];

        
        


        
        fypoint += imageK.size.height/2+30;
        UIButton *btnBack= [[UIButton alloc]initWithFrame:CGRectMake((320 - 44)/2,fypoint, 44, 44)];
        [btnBack setBackgroundColor:[UIColor clearColor]];
        [btnBack setImage:[UIImage imageNamed:@"剪头"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(doModifiey:) forControlEvents:UIControlEventTouchUpInside];
        //        [self addlabel_title:@"登陆" frame:btnBack.frame view:btnBack];
        [scrollView addSubview:btnBack];
        [btnBack release];
        


    }
    
    
    else if ([signal is:[MagicViewController DID_APPEAR]]) {
        
        DLogInfo(@"rrr");
    } else if ([signal is:[MagicViewController DID_DISAPPEAR]]){
        
        
    }
}



-(void)forgotPwd:(id)sender
{
    WOSFindMIMAViewController *finde = [[WOSFindMIMAViewController alloc]init];
    [self.drNavigationController pushViewController:finde animated:YES];
    RELEASE(finde);
}

-(void)doModifiey:(id)sender
{
    
    if ([self checkInputIsValid])
    {
        
     
        
        NSString    *strOriginalPwd = _origionPwd.nameField.text;
        NSString    *strpwd = _newPwd.nameField.text;
      //  NSString    *strConforim = _confiromPwd.nameField.text;
 
        NSString    *strUserName = nil;
        if ([SHARED.username length] > 1)
        {
            strUserName = SHARED.username;
        }else if ([SHARED.phone length] > 10)
        {
            strUserName = SHARED.phone;
        }else if ([SHARED.email length])
        {
            strUserName = SHARED.email;
        }

        MagicRequest *request = [DYBHttpMethod wosChangePwd:strUserName oldPasswd:strOriginalPwd newPasswd:strpwd isAlert:YES receive:self];
        [request setTag:3];
        
    }
    
}

- (void)handleViewSignal_MagicUITextField:(MagicViewSignal *)signal
{
    if ([signal is:[MagicUITextField TEXTFIELDDIDBEGINEDITING]])
    {
        
        
        CGRect frame =  scrollView.frame;
        frame.origin.y = -40;
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




-(BOOL)checkInputIsValid
{
    NSString    *strOriginalPwd = _origionPwd.nameField.text;
    NSString    *strpwd = _newPwd.nameField.text;
    NSString    *strConforim = _confiromPwd.nameField.text;
    
    
    if (!strOriginalPwd)
    {
        [self popText:@"原密码不能为空"];
        return NO;
    }
    if (!strpwd)
    {
        [self popText:@"密码不能为空"];
        return NO;
    }
    if (!strConforim)
    {
        [self popText:@"确认密码不能为空"];
        return NO;
    }

    if ([strpwd length] < 6)
    {
        [self popText:@"密码长度不能小于6"];
        return NO;
    }
    if ([strConforim length] < 6)
    {
        [self popText:@"确认密码不能小于6"];
        return NO;
    }
    
    if (![strpwd isEqualToString:strConforim])
    {
        [self popText:@"密码与确认密码不一致!"];
        return NO;
    }
    
    return YES;
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
                     [DYBShareinstaceDelegate popViewText:@"修改密码成功" target:self hideTime:.5f isRelease:YES mode:MagicPOPALERTVIEWINDICATOR];
                  
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
