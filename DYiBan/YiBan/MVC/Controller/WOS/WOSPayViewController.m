//
//  WOSPayViewController.m
//  WOS
//
//  Created by axingg on 14-5-22.
//  Copyright (c) 2014年 ZzL. All rights reserved.
//

#import "WOSPayViewController.h"
#import "WOSPayTableViewCell.h"
#import "APPDELEGATE.h"
#import "WOSMakeSurePayTableViewCell.h"
#import "JSONKit.h"
#import "JSON.h"
#import "WOSPayCardTableViewCell.h"
#import "WOSLogInViewController.h"
#import "WOSAddrViewController.h"
#import "WOSOrderLostViewController.h"

#define NORMALBORDORCOLOR   [UIColor grayColor]
#define HIGHLIGHTBORDORCOLOR   [UIColor yellowColor]
#define TEXTCOLOR               [UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]

@interface WOSPayViewController ()<UITextFieldDelegate>{
    NSMutableDictionary *dictOrder;
    AppDelegate *appde;
    NSArray *arrayCard;
    UITableView *_tableView1;
    
    UITextField *_textaddress;
    UITextField *_textremark;
    UIScrollView  *scrollView;
    int             dealsIndex;     //优惠劵index
    BOOL            m_bUserDeal;
}

@property(nonatomic,retain)NSDictionary *dicAddInfo;
@end

@implementation WOSPayViewController
@synthesize dicAddInfo;
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
    
//    dictOrder = [[NSMutableDictionary alloc]init];
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.dicAddInfo = nil;
    [scrollView release];
    scrollView = nil;
    [super dealloc];

}

-(void)handleViewSignal_MagicViewController:(MagicViewSignal *)signal{
    
    DLogInfo(@"name -- %@",signal.name);
    
    if ([signal is:[MagicViewController LAYOUT_VIEWS]])
    {
        //        [self.rightButton setHidden:YES];
        [self.headview setTitle:@"确认订单"];
        

        dealsIndex = -1;
        [self.headview setTitleColor:[UIColor whiteColor]];
        [self setButtonImage:self.leftButton setImage:@"返回键"];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [self.headview setBackgroundColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];

        
    }
    else if ([signal is:[MagicViewController CREATE_VIEWS]]) {
          appde= appDelegate;
        [self.rightButton setHidden:YES];
//        arrayCard = [[NSArray alloc]init];
       
        if (scrollView)
        {
            [scrollView release];
            scrollView = nil;
        }
       scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f,self.headHeight+10, 320.0f, self.view.frame.size.height)];
        [self.view addSubview:scrollView];
        RELEASE(scrollView);
        
        
        dictOrder = [[NSMutableDictionary alloc]init];
        
        UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake(10.0f,10, 250.0, 30.0f)];
        [labelName setBackgroundColor:[UIColor clearColor]];
        NSString *strName = [[NSUserDefaults standardUserDefaults]objectForKey:@"shopname"];
        [labelName setText:strName];
        
        [labelName setTextColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
        [scrollView addSubview:labelName];
        RELEASEOBJ(labelName);
        
        [self getData];
        
        UITableView *_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f,40, 320.0f, 100)];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        [_tableView setTag:101];
        [scrollView addSubview:_tableView];
       RELEASEOBJ(_tableView);
        
        
        
        CGFloat    fypoint = _tableView.frame.origin.y+100;
        UILabel *labelSave = [[UILabel alloc]initWithFrame:CGRectMake(10.0f,fypoint,60, 20.0f)];
        [labelSave setBackgroundColor:[UIColor clearColor]];
        [labelSave setText:@"优惠:"];
        [scrollView addSubview:labelSave];
        RELEASEOBJ(labelSave);
        
        
        UILabel *labelYouhui = [[UILabel alloc]initWithFrame:CGRectMake(250.0f, fypoint, 70.0, 20.0f)];
        [labelYouhui setBackgroundColor:[UIColor clearColor]];
        [labelYouhui setTextColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];

        [labelYouhui setText:[NSString stringWithFormat:@"%.2f",[self getYouhui]]];
        [scrollView addSubview:labelYouhui];
        labelYouhui.tag = 2000;
        RELEASEOBJ(labelYouhui);
        
        
        fypoint += 30;
        UILabel *labelSave2 = [[UILabel alloc]initWithFrame:CGRectMake(10.0f,fypoint, 250.0, 20.0f)];
        [labelSave2 setBackgroundColor:[UIColor clearColor]];
        [labelSave2 setText:@"总计:"];
        [scrollView addSubview:labelSave2];
       RELEASEOBJ(labelSave2);
        
        
        UILabel *labelTotal = [[UILabel alloc]initWithFrame:CGRectMake(250.0f,fypoint, 250.0, 20.0f)];
        [labelTotal setBackgroundColor:[UIColor clearColor]];
        [labelTotal setText:[NSString stringWithFormat:@"%0.2f",[self getTotal]]];
        [labelTotal setTextColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
        labelTotal.tag = 3000;
        [scrollView addSubview:labelTotal];
        RELEASEOBJ(labelTotal);

        fypoint += 40;
        UILabel *labelUserFree = [[UILabel alloc]initWithFrame:CGRectMake(10.0f,fypoint, 250.0, 30.0f)];
        [labelUserFree setBackgroundColor:[UIColor clearColor]];
        [labelUserFree setText:@"使用优惠券"];
        [labelUserFree setTextColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
        [labelUserFree setFont:[UIFont systemFontOfSize:20]];

 
        [scrollView addSubview:labelUserFree];
        RELEASEOBJ(labelUserFree);
        
        UISwitch *switchFree = [[UISwitch alloc]initWithFrame:CGRectMake(250.0f,fypoint, 50.0f, 30.0f)];
        [switchFree addTarget:self action:@selector(doSwith:) forControlEvents:UIControlEventTouchUpInside];
        switchFree.tag = 300;
        [scrollView addSubview:switchFree];
        RELEASEOBJ(switchFree);
        
        
        
        
        fypoint += 30;
        
        
        _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0.0f,fypoint, 320.0f, 90)];
        [_tableView1 setDataSource:self];
        [_tableView1 setDelegate:self];
        [_tableView1 setBackgroundColor:[UIColor whiteColor]];
        [_tableView1 setTag:102];
        [scrollView addSubview:_tableView1];
        RELEASEOBJ(_tableView1);
        
        
        fypoint += 10+90;
        UIImage *image = [UIImage imageNamed:@"jianhao"];
        UIButton *btnAddress = [[UIButton alloc]initWithFrame:CGRectMake(20,  fypoint+2, image.size.width/2, image.size.height/2)];
        //        [btnMakeSuerOrder setBackgroundColor:[UIColor redColor]];
        [btnAddress addTarget:self action:@selector(doaddress:) forControlEvents:UIControlEventTouchUpInside];
        [btnAddress setImage:image forState:UIControlStateNormal];
        //        [btnEnter setTitle:@"提交订单" forState:UIControlStateNormal];
        [scrollView addSubview:btnAddress];
        
        
        
        _textaddress = [[UITextField alloc] initWithFrame:CGRectMake(20+image.size.width/2+20, fypoint, 200, 30)];
        _textaddress.borderStyle = UITextBorderStyleNone;
        _textaddress.layer.borderWidth = 1;
        _textaddress.layer.borderColor = NORMALBORDORCOLOR.CGColor;
        _textaddress.placeholder = @"请选择地址";
        _textaddress.enabled = NO;
        [scrollView addSubview:_textaddress];
        
        
        
        
        fypoint += 30+10;
        UILabel *labelRemark = [[UILabel alloc]initWithFrame:CGRectMake(10.0f,fypoint, 80.0, 30.0f)];
        [labelRemark setBackgroundColor:[UIColor clearColor]];
        [labelRemark setText:@"备注:"];
        [labelRemark setTextColor:[UIColor blackColor]];
        [labelRemark setFont:[UIFont systemFontOfSize:15]];
        [scrollView addSubview:labelRemark];
        
        
        
        _textremark = [[UITextField alloc] initWithFrame:CGRectMake(20+image.size.width/2+20, fypoint, 200, 30)];
        _textremark.borderStyle = UITextBorderStyleNone;
        _textremark.layer.borderWidth = 1;
        _textremark.layer.borderColor = NORMALBORDORCOLOR.CGColor;
        _textremark.placeholder = @"请输入您的要求";
        [scrollView addSubview:_textremark];
        _textremark.delegate =  self;
        
        
        fypoint += 30+10;
        UIImage *i = [UIImage imageNamed:@"组 5.png"];
        UIButton *btnMakeSuerOrder = [[UIButton alloc]initWithFrame:CGRectMake((320 - i.size.width/2)/2,  fypoint, i.size.width/2, i.size.height/2)];
        [btnMakeSuerOrder addTarget:self action:@selector(dobtnMakeSuerOrder) forControlEvents:UIControlEventTouchUpInside];
        [btnMakeSuerOrder setImage:i forState:UIControlStateNormal];
        [scrollView addSubview:btnMakeSuerOrder];
        RELEASEOBJ(btnMakeSuerOrder);

   
        [scrollView setContentSize:CGSizeMake(320.0f,  fypoint+btnMakeSuerOrder.frame.size.height)];
        
        NSString *index = [[NSUserDefaults standardUserDefaults]objectForKey:@"kitchenIndex"];
    
        
               
        MagicRequest *request11 = [DYBHttpMethod wosKitchenInfo_medeals_userIndex:SHARED.userId kitchenIndex:index sAlert:YES receive:self];
        [request11 setTag:4];
        
        
        [self requestPrice];
/*
        MagicUITableView *tabelViewList = [[MagicUITableView alloc]initWithFrame:CGRectMake(0.0f, self.headHeight, 320.0f, self.view.frame.size.height - self.headHeight)];
        
        [self.view addSubview:tabelViewList];
        RELEASE(tabelViewList)
        

        MagicRequest *request = [DYBHttpMethod wosKitchenInfo_kitchenIndex:index userIndex:SHARED.userId hotFoodCount:@"4" sAlert:YES receive:self];
                [request setTag:3];*/
        
        
        
        
    }
    
    
    else if ([signal is:[MagicViewController WILL_APPEAR]]) {
        
        DLogInfo(@"rrr");
        
        
    } else if ([signal is:[MagicViewController DID_DISAPPEAR]]){
        
        
    }
    
}



-(void)setAddress:(NSDictionary*)addInfo
{
    _textaddress.textColor = TEXTCOLOR;
    [_textaddress setText:[addInfo valueForKey:@"receiverAddress"]];
    self.dicAddInfo = addInfo;
}

-(void)doaddress:(id)sender
{
    
    WOSAddrViewController *controller = [[WOSAddrViewController alloc] init];
    controller.payController = self;
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(void)dobtnMakeSuerOrder{


    
    if (!self.dicAddInfo)
    {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示"
                                                     message:@"请选择送货地址"
                                                    delegate:nil
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    
    NSString *addIndex = [self.dicAddInfo valueForKey:@"addrIndex"];
    NSString *remaek = _textremark.text;
    
    if (!remaek.length)
    {
        remaek = nil;
    }

    NSString *strFoodIndex = nil;
    NSString *strCountIndex = nil;
    
    
    NSArray *array = [dictOrder allValues];
    for (NSArray *arrayTemp in array)
    {
     
        NSDictionary   *dic = [arrayTemp firstObject];
        
        NSString *index = [dic objectForKey:@"foodIndex"];
    
        if (strFoodIndex == nil)
        {
            strFoodIndex = index;
        }else
        {
            strFoodIndex = [NSString stringWithFormat:@"%@,%@",strFoodIndex,index];
        }
        
        int count = 0;
        for (NSDictionary *dicTemp  in arrayTemp)
        {
            if (dicTemp.count)
            {
                count++;
            }
        }
        if (strCountIndex == nil)
        {
            strCountIndex = [NSString stringWithFormat:@"%d",count];
        }else
        {
            strCountIndex = [NSString stringWithFormat:@"%@,%d",strCountIndex,count];
        }
        
    }
    
    
    
    id  strKitch = @([[[NSUserDefaults standardUserDefaults]objectForKey:@"kitchenIndex"] intValue]);
 

    
    MagicRequest *request = [DYBHttpMethod wosKitchenInfo_orderadd_userIndex:SHARED.userId kitchenIndex:strKitch userAddrIndex:addIndex persons:nil remarks:remaek dealsIndexs:nil foodIndexs:strFoodIndex countIndexs:strCountIndex sAlert:YES receive:self];
    request.tag = 200;
    
    
}

-(void)requestPrice
{
    NSString *strFoodIndex = nil;
    NSString *strCountIndex = nil;
    
    NSArray *array = [dictOrder allValues];
    for (NSArray *arrayTemp in array)
    {
        
        NSDictionary   *dic = [arrayTemp firstObject];
        
        NSString *index = [dic objectForKey:@"foodIndex"];
        
        if (strFoodIndex == nil)
        {
            strFoodIndex = index;
        }else
        {
            strFoodIndex = [NSString stringWithFormat:@"%@,%@",strFoodIndex,index];
        }
        
        int count = 0;
        for (NSDictionary *dicTemp  in arrayTemp)
        {
            if (dicTemp.count)
            {
                count++;
            }
        }
        if (strCountIndex == nil)
        {
            strCountIndex = [NSString stringWithFormat:@"%d",count];
        }else
        {
            strCountIndex = [NSString stringWithFormat:@"%@,%d",strCountIndex,count];
        }
        
    }
    
    
    
        NSString  *strKitch = [[NSUserDefaults standardUserDefaults]objectForKey:@"kitchenIndex"];
        MagicRequest *request = [DYBHttpMethod wosFoodInfo_calculate_userIndex:SHARED.userId kitchenIndex:strKitch foodIndexs:strFoodIndex countIndexs:strCountIndex sAlert:YES receive:self];
        [request setTag:3];
    
}

-(void)doSwith:(id)sender{

 //   NSString *index = [[NSUserDefaults standardUserDefaults]objectForKey:@"kitchenIndex"];

    

    
    

    
    

    UISwitch *s = (UISwitch *)sender;
    if (s.on) {
        m_bUserDeal = YES;
        
    }else {
    
       m_bUserDeal = NO;
    }
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 101) {
         return [dictOrder allKeys].count;
    }else{
    
        return  arrayCard.count;
    }
   
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 101) {
        
    
        static NSString *CellIdentifier = @"dd";
        WOSMakeSurePayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[WOSMakeSurePayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
        }else {
            
            for (UIView *view in [cell.contentView subviews]) {
                [view removeFromSuperview];
            }
        }
        
        NSArray *array = [dictOrder allValues];
        [cell creatCell:[array objectAtIndex:indexPath.row]];
        return cell;
        
    }else if (tableView.tag == 102){
    
    
        static NSString *CellIdentifier = @"ddw";
        WOSPayCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[WOSPayCardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
        }else {
            
            for (UIView *view in [cell.contentView subviews]) {
                [view removeFromSuperview];
            }
        }
        
        [cell ceatCell:[arrayCard objectAtIndex:indexPath.row]];
        return cell;

    
    
    }
    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 102)
    {
        NSDictionary  *dicInfo = arrayCard[indexPath.row];
        NSString    *strdelaIndex = [dicInfo valueForKey:@"dealsIndex"];
        dealsIndex = [strdelaIndex intValue];
        
    }
}

-(float )getYouhui{
    
    
    float total = 0;

    return  total;
    
}

-(float )getTotal{

    
    float total = 0;
    for (NSDictionary *dic in appde.arrayOrderList) {
    
      NSString *index = [dic objectForKey:@"foodPrice"];
        total = total + [index floatValue];
    }
    return  total;

}

-(void)getData{
    
 
    
    for (NSDictionary *dic in appde.arrayOrderList) {
        
        NSString *index = [dic objectForKey:@"foodIndex"];
        NSMutableArray *arrayTemp = [dictOrder objectForKey:index];
        if (!arrayTemp  ) { //不存在
            
            NSMutableArray *array = [[NSMutableArray alloc]init];
            [array addObject:dic];
            [dictOrder setValue:array forKey:index];
            RELEASE(array);
            
        }else{ //已经有了，
            
            [arrayTemp addObject:dic];
            [dictOrder setValue:arrayTemp forKey:index];
        }
        
    }
    
}




#pragma mark- 只接受HTTP信号
- (void)handleRequest:(MagicRequest *)request receiveObj:(id)receiveObj
{
    if ([request succeed])
    {
        //        JsonResponse *response = (JsonResponse *)receiveObj;
        if (request.tag == 2) {
            
            
            NSDictionary *dict = [request.responseString JSONValue];
            
            if (dict) {
                BOOL result = [[dict objectForKey:@"result"] boolValue];
                if (!result) {
                    
                    //                    _dictInfo = dict;
                    //                    [DYBShareinstaceDelegate popViewText:@"收藏成功！" target:self hideTime:.5f isRelease:YES mode:MagicPOPALERTVIEWINDICATOR];
                    //
                }else{
                    NSString *strMSG = [dict objectForKey:@"message"];
                    
                    [DYBShareinstaceDelegate popViewText:strMSG target:self hideTime:.5f isRelease:YES mode:MagicPOPALERTVIEWINDICATOR];
                    
                    
                }
            }
        }else if(request.tag == 3){
            
            NSDictionary *dict = [request.responseString JSONValue];
            
            if (dict) {
                
                BOOL result = [[dict objectForKey:@"result"] boolValue];
                if (!result) {
//
                    NSString    *strTotal = [[dict valueForKey:@"total"] description];
                    NSString    *strYouhui = [[dict valueForKey:@"discount"] description];
                    
                    UILabel *labelTotal = (UILabel*)[scrollView viewWithTag:3000];
                    [labelTotal setText:strTotal];
                    UILabel *labelYouhui = (UILabel*)[scrollView viewWithTag:2000];
                    [labelYouhui setText:strYouhui];

                }
                else{
                    NSString *strMSG = [dict objectForKey:@"message"];
                    
                    [DYBShareinstaceDelegate popViewText:strMSG target:self hideTime:.5f isRelease:YES mode:MagicPOPALERTVIEWINDICATOR];
                    
                    
                }
            }
            
        }else if(request.tag == 4){
            
            NSDictionary *dict = [request.responseString JSONValue];
            
            if (dict) {
                
                BOOL result = [[dict objectForKey:@"result"] boolValue];
                if (!result) {
                    //                    arrayCard = [dict iboΩ];
                    arrayCard = [[NSArray alloc]initWithArray:[dict objectForKey:@"dealsList"]];
                    [_tableView1 reloadData];
                }
                else{
                    NSString *strMSG = [dict objectForKey:@"message"];
                    
                    [DYBShareinstaceDelegate popViewText:strMSG target:self hideTime:.5f isRelease:YES mode:MagicPOPALERTVIEWINDICATOR];
                    
                    
                }
            }
            
        } else if(request.tag == 200){
            
            NSDictionary *dict = [request.responseString JSONValue];
            
            if (dict) {
                
                BOOL result = [[dict objectForKey:@"result"] boolValue];
                if (!result) {
                    
                    WOSOrderLostViewController  *controller = [[WOSOrderLostViewController alloc] init];
                    [self.drNavigationController pushViewController:controller animated:YES];
                    
                }
                else{
                    NSString *strMSG = [dict objectForKey:@"message"];
                    
                    [DYBShareinstaceDelegate popViewText:strMSG target:self hideTime:.5f isRelease:YES mode:MagicPOPALERTVIEWINDICATOR];
                    
                    
                }
            }
            
        }else{
            NSDictionary *dict = [request.responseString JSONValue];
            NSString *strMSG = [dict objectForKey:@"message"];
            
            [DYBShareinstaceDelegate popViewText:strMSG target:self hideTime:.5f isRelease:YES mode:MagicPOPALERTVIEWINDICATOR];
            
            
        }
    }
}


#pragma mark UITextFielddelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.layer.borderColor = HIGHLIGHTBORDORCOLOR.CGColor;
    textField.textColor = TEXTCOLOR;
    CGRect frame = scrollView.frame;
    frame.origin.y -= 100;
    [UIView animateWithDuration:0.3 animations:^{scrollView.frame = frame;}];
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    textField.textColor = TEXTCOLOR;
    CGRect frame = scrollView.frame;
    frame.origin.y += 100;
    [UIView animateWithDuration:0.3 animations:^{scrollView.frame = frame;}];
    [textField resignFirstResponder];
    return YES;
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
