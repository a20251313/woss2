//
//  WOSAddrViewController.m
//  DYiBan
//
//  Created by tom zeng on 13-11-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "WOSAboutSoftViewController.h"
#import "WOSAddrCell.h"
#import "WOSAddAddrViewController.h"
#import "JSONKit.h"
#import "JSON.h"
#import "WOSAdrrDrtailView.h"
#import "WOSAboutCell.h"
#import "WOSFeedbackViewController.h"


@interface WOSAboutSoftViewController ()
{
    NSMutableArray *arrayDataList;
    UITableView *tableView1;


}
@end

@implementation WOSAboutSoftViewController

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
        [self.headview setTitle:@"关于馋猫"];
        
        [self.headview setTitleColor:[UIColor whiteColor]];
        
        [self.view setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
        
        [self setButtonImage:self.leftButton setImage:@"返回键"];
        
        [self.headview setBackgroundColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
    }
    else if ([signal is:[MagicViewController CREATE_VIEWS]]) {
        
      // [self.view setBackgroundColor:[UIColor redColor]];
       
        
        tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(.0f, self.headHeight , 320,self.view.frame.size.height - self.headHeight)];
        [tableView1 setBackgroundColor:[UIColor clearColor]];
        [tableView1 setDelegate:self];
        [tableView1 setDataSource:self];
        [tableView1 setSeparatorColor:[UIColor clearColor]];
        [self.view addSubview:tableView1];
        [self addDataSource];

    }
    
    else if ([signal is:[MagicViewController DID_APPEAR]]) {
        
        DLogInfo(@"rrr");
    } else if ([signal is:[MagicViewController DID_DISAPPEAR]]){
        
        
    }
}


-(void)addDataSource
{
    if (!arrayDataList)
    {
        arrayDataList = [[NSMutableArray alloc] init];
       
        WOSAboutModel *model = [WOSAboutModel modelWithType:WOSAboutCellIcon mainName:@"馋猫外卖" mainContent:@"V1.0.0"];
        model.iconName = @"60pt";
         WOSAboutModel *mode2 = [WOSAboutModel modelWithType:WOSAboutCellNormal mainName:@"版本更新" mainContent:@"最新版本"];
        WOSAboutModel *mode3 = [WOSAboutModel modelWithType:WOSAboutCellNormal mainName:@"企业邮箱" mainContent:@"chanmaowaimai@163.com"];
          WOSAboutModel *mode4 = [WOSAboutModel modelWithType:WOSAboutCellIndicate mainName:@"客服电话" mainContent:@"0371-66618606"];
          WOSAboutModel *mode5 = [WOSAboutModel modelWithType:WOSAboutCellNormal mainName:@"意见反馈" mainContent:@""];
        [arrayDataList addObjectsFromArray:@[model,mode2,mode3,mode4,mode5]];
        
    }
    [tableView1 reloadData];
}

-(void)addlabel_title:(NSString *)title frame:(CGRect)frame view:(UIView *)view{
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
    [label1 setText:title];
    [label1 setTag:100];
    [label1 setTextAlignment:NSTextAlignmentCenter];
    [view bringSubviewToFront:label1];
    [label1 setTextColor:[UIColor whiteColor]];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [view addSubview:label1];
    RELEASE(label1);
    
}






#pragma mark - tableviewdelete
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section/*第一次回调时系统传的section是数据源里section数量的最大值-1*/
{
    
    return arrayDataList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    if (indexPath.row == 0)
    {
        return 140;
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseIdetify = @"WOSAboutCell";
    WOSAboutCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
 
    
    
    if (!cell)
    {
        cell = [[WOSAboutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];

    }
    
    [cell setDataModel:arrayDataList[indexPath.row]];


    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 3)
    {
        
        WOSAboutCell    *cell = (WOSAboutCell*)[tableView cellForRowAtIndexPath:indexPath];
        WOSAboutModel   *model = cell.dataModel;
        NSString    *strUrl = [NSString stringWithFormat:@"tel://%@",model.mainContent];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strUrl]];
    }else if(indexPath.row == 4)
    {
        WOSFeedbackViewController *feed = [[WOSFeedbackViewController alloc] init];
        [self.drNavigationController pushViewController:feed animated:YES];
        [feed release];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    RELEASE(tableView1);
    [super dealloc];
}







@end
