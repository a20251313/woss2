//
//  WOSLogInViewController.m
//  DYiBan
//
//  Created by tom zeng on 13-12-24.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "WOSFeedbackViewController.h"
#import "DYBInputView.h"
#import "CALayer+Custom.h"
//#import "MagicRequest.h"
#import "NSObject+MagicDatabase.h"
#import "WOSFindMIMAViewController.h"
#import "DYBHttpMethod.h"
#import "JSONKit.h"
#import "JSON.h"
#import "Magic_Database.h"
#import "WOSRegisterViewController.h"
#import "user.h"
@interface WOSFeedbackViewController ()<UITextViewDelegate>{

    UITextView      *m_textView;
    UILabel         *labelCount;
}

@end

@implementation WOSFeedbackViewController

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
-(void)handleViewSignal_MagicViewController:(MagicViewSignal *)signal{
    
    DLogInfo(@"name -- %@",signal.name);
    
    if ([signal is:[MagicViewController LAYOUT_VIEWS]])
    {
        [self.headview setTitle:@"意见反馈"];
        
        [self setButtonImage:self.leftButton setImage:@"返回键"];
        [self.headview setTitleColor:[UIColor colorWithRed:193.0f/255 green:193.0f/255 blue:193.0f/255 alpha:1.0f]];
        [self.headview setBackgroundColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
       [self.view setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0f]];
//      40 191 140
        [self.leftButton setHidden:NO];
        [self.rightButton setHidden:YES];
        

    }
    else if ([signal is:[MagicViewController CREATE_VIEWS]]) {

        
        m_textView = [[UITextView alloc] initWithFrame:CGRectMake(0, self.headHeight+10, 320, 140)];
        [m_textView setDelegate:self];
        
        [self.view addSubview:m_textView];
        
        
        labelCount = [[UILabel alloc] initWithFrame:CGRectMake(m_textView.frame.size.width-30, m_textView.frame.size.height+m_textView.frame.origin.y-20, 30, 20)];
        [labelCount setBackgroundColor:[UIColor clearColor]];
        [labelCount setText:@"200"];
        [labelCount setTextColor:[UIColor grayColor]];
       // [m_textView addSubview:labelCount];
        
        
        [self.view addSubview:labelCount];
        
        
        
        UIButton *btnBack= [[UIButton alloc]initWithFrame:CGRectMake((320 - 44)/2, m_textView.frame.origin.y+m_textView.frame.size.height+20, 44, 44)];
        [btnBack setBackgroundColor:[UIColor clearColor]];
        [btnBack setImage:[UIImage imageNamed:@"剪头"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(doFeedBack:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnBack];
        [btnBack release];
        

    }
    
    else if ([signal is:[MagicViewController DID_APPEAR]]) {
        
        DLogInfo(@"rrr");
    } else if ([signal is:[MagicViewController DID_DISAPPEAR]]){
        
        
    }
}




-(void)doFeedBack:(id)sender
{
    MagicRequest *request = [DYBHttpMethod wosSuggest:SHARED.userId suggestion:m_textView.text suggestType:@"1" sAlert:YES receive:self];
    [request setTag:3];
}






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
                    
                    [DYBShareinstaceDelegate popViewText:@"发送成功，谢谢您的反馈!" target:self hideTime:1.0f isRelease:YES mode:MagicPOPALERTVIEWINDICATOR];
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



- (void)handleViewSignal_DYBBaseViewController:(MagicViewSignal *)signal
{
    if ([signal is:[DYBBaseViewController BACKBUTTON]])
    {
        [self.drNavigationController popViewControllerAnimated:YES];
    }else if ([signal is:[DYBBaseViewController NEXTSTEPBUTTON]]){
        
        
        
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    [labelCount setText:[NSString stringWithFormat:@"%d",200-textView.text.length]];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
 
    RELEASE(labelCount);
    RELEASE(m_textView);
    [super dealloc];
}
@end
