//

//  WOSPersonInfoViewController.m

//  DYiBan

//

//  Created by tom zeng on 13-11-28.

//  Copyright (c) 2013年 ZzL. All rights reserved.

//



#import "WOSPersonInfoViewController.h"

#import "WOSAddrViewController.h"

#import "WOSALLOrderViewController.h"

#import "WOSCollectViewController.h"

#import "WOSPersonInfoViewController.h"

#import "WOSPreferentialCardViewController.h"

#import "WOSMoreInfoViewController.h"
#import "WOSFindFoodViewController.h"
#import "Cell2.h"
#import "WOSLogInViewController.h"
#import "WOSOrderLostViewController.h"
#import "WOSFindMIMAViewController.h"
#import "NSString+SBJSON.h"
#import "user.h"
@interface WOSPersonInfoViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate>{
    
    
    
    DYBUITableView *tbDataBank1;
    
    NSArray *arrayTitle;
    
}


@property(nonatomic,strong)UIImagePickerController  *controller;
@end



@implementation WOSPersonInfoViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil

{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        // Custom initialization
        
    }
    
    return self;
    
}



-(void)handleViewSignal_MagicViewController:(MagicViewSignal *)signal{
    
    
    
    DLogInfo(@"name -- %@",signal.name);
    
    
    
    if ([signal is:[MagicViewController LAYOUT_VIEWS]])
        
    {
        
        //        [self.rightButton setHidden:YES];
        
        
        [self.headview setTitle:@"我的账户"];
        [self setButtonImage:self.leftButton setImage:@"返回键"];
        [self.headview setTitleColor:[UIColor colorWithRed:193.0f/255 green:193.0f/255 blue:193.0f/255 alpha:1.0f]];
        
         [self.headview setBackgroundColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
      //  [self.view setBackgroundColor:ColorBG];
        self.view.layer.contents = (id)[UIImage imageNamed:@"gray_bg"].CGImage;
                
    }
    
    else if ([signal is:[MagicViewController CREATE_VIEWS]]) {
        
        
        
        CGFloat fypoint = self.headHeight+10;
        CGFloat fysep = 10;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-74)/2, fypoint, 74, 70)];
        UIImage *imageNew = [UIImage imageNamed:@"log"];
        [imageView setImage:imageNew];
        UIImage *storeImage = [SHARED getUserImage];
        if (storeImage)
        {
            imageView.image = storeImage;
        }
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 35;
        imageView.userInteractionEnabled = YES;
        imageView.tag = 2000;
        
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseHeadImage:)];
        [imageView addGestureRecognizer:tap];
        [self.view addSubview:imageView];
        RELEASE(imageView);
            
        
        [self.rightButton setHidden:YES];

        
        
        fypoint += fysep+70;
        
        UILabel *labelsethead = [[UILabel alloc]initWithFrame:CGRectMake(0, fypoint, 320, 21)];
        [labelsethead setText:@"点击设置头像"];
        [labelsethead setBackgroundColor:[UIColor clearColor]];
        [labelsethead setTextColor:[UIColor whiteColor]];
        [labelsethead setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:labelsethead];
        [labelsethead release];
        
        fypoint += fysep+21;
        
        
        
        UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake(0,fypoint,320,30)];
        
        [labelName setText:@"tomgg"];
        
        [labelName setBackgroundColor:[UIColor clearColor]];
        
        [labelName setTextColor:ColorGreen];
        
        [self.view addSubview:labelName];
        labelName.tag = 1000;
        
        [labelName setTextAlignment:NSTextAlignmentCenter];
        
        [labelName release];
        
        
        fypoint += fysep+30+10;
        
        UILabel *labelScore = [[UILabel alloc]initWithFrame:CGRectMake(0,fypoint,320,30)];
    
        [labelScore setText:@"我的积分：0"];
        
        [labelScore setBackgroundColor:[UIColor clearColor]];
        
        [labelScore setTextColor:ColorGray];
        
        [self.view addSubview:labelScore];
        
        labelScore.tag = 1001;
        [labelScore setTextAlignment:NSTextAlignmentCenter];
        
        [labelScore release];
        
        
        fypoint += fysep+30;
        UILabel *labelPhone = [[UILabel alloc]initWithFrame:CGRectMake(0,fypoint,320,30)];
        
        [labelPhone setText:@"绑定手机:"];
        
        [labelPhone setBackgroundColor:[UIColor clearColor]];
        
        [labelPhone setTextColor:ColorGray];
        
        [self.view addSubview:labelPhone];
        
        labelPhone.tag = 1002;
        [labelPhone setTextAlignment:NSTextAlignmentCenter];
        
        [labelPhone release];
        
        
        fypoint +=  fysep+20+30;
        
        UIButton *btnModifiedPwd = [[UIButton alloc]initWithFrame:CGRectMake((320-80)/2, fypoint, 80,30)];
        
        [self.view addSubview:btnModifiedPwd];
        [btnModifiedPwd setBackgroundColor:[UIColor clearColor]];
        [btnModifiedPwd setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
       
        
        [btnModifiedPwd addTarget:self action:@selector(modifiedPwd:) forControlEvents:UIControlEventTouchUpInside];
      //  [btnModifiedPwd setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        [self addlabel_title:@"更改密码" frame:btnModifiedPwd.frame view:btnModifiedPwd];
        [btnModifiedPwd release];
                
        
        
        fypoint += 30+fysep;
        
        UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake((320-80)/2, fypoint, 80,30)];
        
        [self.view addSubview:btnBack];
        [btnBack setBackgroundColor:[UIColor clearColor]];
        
        [btnModifiedPwd setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(backMan) forControlEvents:UIControlEventTouchUpInside];
              [btnBack release];
       // [btnBack setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        [self addlabel_title:@"退出登陆" frame:btnBack.frame view:btnBack];
        
        [self getAllInfo];

    }
    
    
    else if ([signal is:[MagicViewController DID_APPEAR]]) {
        
        
        
        DLogInfo(@"rrr");
        
    } else if ([signal is:[MagicViewController DID_DISAPPEAR]]){
 
        
    }
    
}


-(void)getAllInfo
{
    MagicRequest    *request = [DYBHttpMethod wosAllINfo:SHARED.userId isAlert:YES receive:self];
    request.tag = 100;
}

-(void)modifiedPwd:(id)sender
{
    
    DLogInfo(@"modifiedPwd:%@",sender);
    
}

-(void)chooseHeadImage:(id)sender
{
    
    UIActionSheet   *sheet = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"照相" otherButtonTitles:@"来自相册", nil];
    [sheet showInView:self.view];
    
    
}

-(void)addlabel_title:(NSString *)title frame:(CGRect)frame view:(UIView *)view{
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
    [label1 setText:title];
    [label1 setTag:100];
    [label1 setTextAlignment:NSTextAlignmentCenter];
    [view bringSubviewToFront:label1];
    [label1 setTextColor:[UIColor blackColor]];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [view addSubview:label1];
    RELEASE(label1);
    
}



-(void)backMan{
      DLogInfo(@"backMan:");
    return;
    
    WOSLogInViewController *login = [[WOSLogInViewController alloc]init];
    [self.drNavigationController pushViewController:login animated:YES];
    RELEASE(login);
    
    
    
}



#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        UIImagePickerController *pick = [[UIImagePickerController alloc] init];
        pick.delegate = self;
        pick.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:pick animated:YES];
        pick.allowsEditing = YES;
        self.controller = pick;
    }else if(buttonIndex == 1)
    {
        UIImagePickerController *pick = [[UIImagePickerController alloc] init];
        pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pick.allowsEditing = YES;
        pick.delegate = self;
        [self presentModalViewController:pick animated:YES];
        self.controller = pick;
        
    }
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo;
{
    
    UIImageView *imageHead = (UIImageView*)[self.view viewWithTag:2000];
    if ([editingInfo valueForKey:UIImagePickerControllerEditedImage])
    {
        imageHead.image = [editingInfo valueForKey:UIImagePickerControllerEditedImage];
    }else
    {
        imageHead.image = image;
    }
    
    [self dismissModalViewControllerAnimated:YES];
    [SHARED storeUserImage:image];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImageView *imageHead = (UIImageView*)[self.view viewWithTag:2000];
    if ([info valueForKey:UIImagePickerControllerEditedImage])
    {
        imageHead.image = [info valueForKey:UIImagePickerControllerOriginalImage];
          [SHARED storeUserImage:imageHead.image];
    }else
    {
       // imageHead.image = nil;
    }
      [self dismissModalViewControllerAnimated:YES];
  
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
      [self dismissModalViewControllerAnimated:YES];
}



- (void)handleViewSignal_MagicUITableView:(MagicViewSignal *)signal{
    
    
    
    
    
    if ([signal is:[MagicUITableView TABLENUMROWINSEC]])//numberOfRowsInSection
        
    {
        
        NSNumber *s = [NSNumber numberWithInteger:arrayTitle.count];
        
        [signal setReturnValue:s];
        
        
        
    }else if ([signal is:[MagicUITableView TABLENUMOFSEC]])//numberOfSectionsInTableView
        
    {
        
        NSNumber *s = [NSNumber numberWithInteger:1];
        
        [signal setReturnValue:s];
        
        
        
    }
    
    else if ([signal is:[MagicUITableView TABLEHEIGHTFORROW]])//heightForRowAtIndexPath
        
    {        
                
        [signal setReturnValue:[NSNumber numberWithInteger:40]];
        
    }
    
    else if ([signal is:[MagicUITableView TABLETITLEFORHEADERINSECTION]])//titleForHeaderInSection
        
    {
        
        [signal setReturnValue:nil];
        
        
        
    }
    
    else if ([signal is:[MagicUITableView TABLEVIEWFORHEADERINSECTION]])//viewForHeaderInSection
        
    {
        
        [signal setReturnValue:nil];
        
        
        
    }
    
    else if ([signal is:[MagicUITableView TABLETHEIGHTFORHEADERINSECTION]])//heightForHeaderInSection
        
    {
        
        [signal setReturnValue:[NSNumber numberWithFloat:0.0]];
        
    }
    
    else if ([signal is:[MagicUITableView TABLECELLFORROW]])//cell
        
    {
        
        NSDictionary *dict = (NSDictionary *)[signal object];
        
        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
        
        UITableView *tableView = [dict objectForKey:@"tableView"];
        
        static NSString *CellIdentifier = @"Cell2";
        
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        [cell setBackgroundColor:[UIColor clearColor]];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc]init];
            
        }
        
        cell.textLabel.text = [arrayTitle objectAtIndex:indexPath.row];
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setTextColor:ColorGryWhite];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [cell setBackgroundColor:[UIColor clearColor]];
        
        
        UIImageView *imageViewSep = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 39, 280, 1)];
        [imageViewSep setImage:[UIImage imageNamed:@"个人中心_line"]];
        [cell addSubview:imageViewSep];
        RELEASE(imageViewSep);
        
        [signal setReturnValue:cell];
        
        
        
        
        
    }else if ([signal is:[MagicUITableView TABLEDIDSELECT]])//选中cell
        
    {
        
        
        
        NSDictionary *dict = (NSDictionary *)[signal object];
        
        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
        
        
        
        switch (indexPath.row) {
                
            case 0:
                
            {
                
                WOSOrderLostViewController *order = [[WOSOrderLostViewController alloc]init];
                
                [self.drNavigationController pushViewController:order animated:YES];
                
                RELEASE(order);
                
            }
                
                break;
                
            case 1:
                
            {
                
                WOSAddrViewController *addr = [[WOSAddrViewController alloc]init];
                
                [self.drNavigationController pushViewController:addr animated:YES];
                
                RELEASE(addr);
                
            }
                
                break;
                
            case 2:
                
            {
                
                WOSCollectViewController *collect = [[WOSCollectViewController alloc]init];
                
                [self.drNavigationController pushViewController:collect animated:YES];
                
                RELEASE(collect);
                
            }
                
                break;
                
            case 3:
                
            {
                
                WOSPreferentialCardViewController *card = [[WOSPreferentialCardViewController alloc]init];
                
                [self.drNavigationController pushViewController:card animated:YES];
                
                RELEASE(card);
                
            }
                
                break;
                
            case 4:
                
            {
                
                WOSFindMIMAViewController *find = [[WOSFindMIMAViewController alloc]init];
                [self.drNavigationController pushViewController:find animated:YES];
                RELEASE(find);
                
            }
                
                break;
                
                
                
            default:
                
                break;
                
        }
        
        
        
        
        
    }else if([signal is:[MagicUITableView TABLESCROLLVIEWDIDENDDRAGGING]])/*滚动停止*/{
        
        
        
        
        
    }else if([signal is:[MagicUITableView TABLESCROLLVIEWDIDSCROLL]])/*滚动*/{
        
        
        
    }else if ([signal is:[MagicUITableView TABLEVIEWUPDATA]]) //刷新
        
    {
        
        //        MagicUIUpdateView *uptableview = (MagicUIUpdateView *)[signal object];
        
        
        
        
        
    }else if([signal is:[MagicUITableView TAbLEVIEWLODATA]]) //加载更多
        
    {
        
        
        
        
        
    }else if ([signal is:[MagicUITableView TAbLEVIEWSCROLLUP]]){ //上滑动
        
        
        
        //        [tbDataBank StretchingUpOrDown:0];
        
        //        [DYBShareinstaceDelegate opeartionTabBarShow:YES];
        
        
        
    }else if ([signal is:[MagicUITableView TAbLEVIEWSCROLLDOWN]]){ //下滑动
        
        
        
        //        [tbDataBank StretchingUpOrDown:1];
        
        //        [DYBShareinstaceDelegate opeartionTabBarShow:NO];
        
    }
    
    
    
}



- (void)handleViewSignal_DYBBaseViewController:(MagicViewSignal *)signal

{
    
    if ([signal is:[DYBBaseViewController BACKBUTTON]])
        
    {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    if ([signal is:[DYBBaseViewController NEXTSTEPBUTTON]])
        
    {
        
        WOSMoreInfoViewController *more = [[WOSMoreInfoViewController alloc]init];
        
        [self.drNavigationController pushViewController:more animated:YES];
        
        RELEASE(more);
        
    }
    
}



-(void)refrshWithUserInfo:(DYBShareinstaceDelegate*)myuser
{
    UILabel *labelName = (UILabel*)[self.view viewWithTag:1000];
    [labelName setText:myuser.username];
    
    
    UILabel *labelScore = (UILabel*)[self.view viewWithTag:1001];
    [labelScore setText:[NSString stringWithFormat:@"我地积分:%@",myuser.points]];
    
    UILabel *labelPhone = (UILabel*)[self.view viewWithTag:1002];
    [labelPhone setText:[NSString stringWithFormat:@"绑定手机:%@",myuser.phone]];
    
    
}

#pragma mark- 只接受HTTP信号
- (void)handleRequest:(MagicRequest *)request receiveObj:(id)receiveObj
{
    
    if ([request succeed])
    {
        //        JsonResponse *response = (JsonResponse *)receiveObj;
        if (request.tag == 100) {
            
            
            NSDictionary *dict = [request.responseString JSONValue];
            
            if (dict) {
                BOOL result = [[dict objectForKey:@"result"] boolValue];
                if (!result) {
                    
                    SHARED.userId = [dict objectForKey:@"userIndex"]; //设置userid 全局变量
                    
                    [SHARED setUserInfoFromLoginDic:dict];
                    [self refrshWithUserInfo:SHARED];
                    
                }else{
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


- (void)dealloc

{
    
    self.controller = nil;
    
    [arrayTitle release];
    
    [super dealloc];
    
}



@end