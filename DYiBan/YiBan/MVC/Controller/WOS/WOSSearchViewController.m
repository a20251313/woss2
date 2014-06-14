//
//  WOSSearchViewController.m
//  WOS
//
//  Created by apple on 14-6-8.
//  Copyright (c) 2014年 ZzL. All rights reserved.
//

#import "WOSSearchViewController.h"
#import "WOSShopsListTableViewCell.h"
#import "WOShopDetailViewController.h"
#import "NSString+SBJSon.h"
@interface WOSSearchViewController ()
{
    NSMutableArray      *arrayShopList;
    int                 page;
    int                 count;
    MagicUITableView         *tbleView;
}

@end

@implementation WOSSearchViewController
@synthesize searkey;
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



// Dispose of any resources that can be recreated.


-(void)handleViewSignal_MagicViewController:(MagicViewSignal *)signal{
    
    DLogInfo(@"name -- %@",signal.name);
    
    if ([signal is:[MagicViewController LAYOUT_VIEWS]])
    {
        
        page = 1;
        count = 20;
        //        [self.rightButton setHidden:YES];
        [self.headview setTitle:@"搜索"];
        
        
        
        [self.headview setTitleColor:[UIColor whiteColor]];
        [self setButtonImage:self.leftButton setImage:@"返回键"];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [self.headview setBackgroundColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
        
        
    }
    else if ([signal is:[MagicViewController CREATE_VIEWS]]) {
        
        
        
        [self resolutionRequest];
        
        
    }
    
    
    else if ([signal is:[MagicViewController WILL_APPEAR]]) {
        
        DLogInfo(@"rrr");
        
        
    } else if ([signal is:[MagicViewController DID_DISAPPEAR]]){
        
        
    }
    
}


-(void)resolutionRequest
{
    
    MagicRequest *request = [DYBHttpMethod wosKitchenInfo_searchKitch_keywords:self.searkey page:[NSString stringWithFormat:@"%d",page] count:[NSString stringWithFormat:@"%d",count] sAlert:YES receive:self];
    [request setTag:3];
    
}


//static NSString *cellName = @"cellName";//

- (void)handleViewSignal_MagicUITableView:(MagicViewSignal *)signal{
    
    
    if ([signal is:[MagicUITableView TABLENUMROWINSEC]])//numberOfRowsInSection
    {
        NSNumber *s = [NSNumber numberWithInteger:arrayShopList.count];
        [signal setReturnValue:s];
        
    }else if ([signal is:[MagicUITableView TABLENUMOFSEC]])//numberOfSectionsInTableView
    {
        NSNumber *s = [NSNumber numberWithInteger:1];
        [signal setReturnValue:s];
        
    }
    else if ([signal is:[MagicUITableView TABLEHEIGHTFORROW]])//heightForRowAtIndexPath  暂时把每个cell保存,后期有时间优化为只保存高度,返回cell时再异步计算cell的视图,目前刷新后所有cell的view都要重新创建
    {
        //NSDictionary *dict = (NSDictionary *)[signal object];
        
        
        NSNumber *s = [NSNumber numberWithInteger:70];
        
        
        [signal setReturnValue:s];
        
    }
    else if ([signal is:[MagicUITableView TABLETITLEFORHEADERINSECTION]])//titleForHeaderInSection
    {
        
    }
    else if ([signal is:[MagicUITableView TABLEVIEWFORHEADERINSECTION]])//viewForHeaderInSection
    {
        
    }//
    else if ([signal is:[MagicUITableView TABLETHEIGHTFORHEADERINSECTION]])//heightForHeaderInSection
    {
        
        [signal setReturnValue:[NSNumber numberWithFloat:0]];
        
    }
    else if ([signal is:[MagicUITableView TABLECELLFORROW]])//cell  只返回显示的cell
    {
        NSDictionary *dict = (NSDictionary *)[signal object];
     //   UITableView *tableView = [dict objectForKey:@"tableView"];
        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
        
        //        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
        
        WOSShopsListTableViewCell *cell = [[WOSShopsListTableViewCell alloc]init];
        [cell creatCell:[arrayShopList objectAtIndex:indexPath.row]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [signal setReturnValue:cell];
        
    }else if ([signal is:[MagicUITableView TABLEDIDSELECT]])//选中cell
    {
        NSDictionary *dict = (NSDictionary *)[signal object];
      //  UITableView *tableview = [dict objectForKey:@"tableView"];
        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
        
        
        WOShopDetailViewController *detail = [[WOShopDetailViewController alloc]init];
        NSDictionary *dictResult = [arrayShopList objectAtIndex:indexPath.row];
        detail.dictInfo = dictResult;
        [self.drNavigationController pushViewController:detail animated:YES];
        RELEASE(detail);
        

        
    }
    else if ([signal is:[MagicUITableView TABLESCROLLVIEWDIDSCROLL]])//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
    {
        
        
    }
    else if ([signal is:[MagicUITableView TABLESECTIONINDEXTITLESFORTABLEVIEW]])//右侧索引列表
    {
        
    }
    else if ([signal is:[MagicUITableView TAbLEVIEWLODATA]])//加载更多
    {
        
        
    }
    else if ([signal is:[MagicUITableView TABLEVIEWUPDATA]])//刷新
    {
        
        
    }
    
    else if ([signal is:[MagicUITableView TAbLEVIEWSCROLLUP]]){//上滑
        

        
    }else if ([signal is:[MagicUITableView TAbLEVIEWSCROLLDOWN]]){//下滑

        
    }
    else if ([signal is:[MagicUITableView TAbLEVIERELOADOVER]])//reload完毕
    {

    }
}


#pragma mark    HTTP
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
                    
                    arrayShopList = [[NSMutableArray alloc]initWithArray:[dict objectForKey:@"kitchenList"]];
                    
                    
                    
                    if (!tbleView)
                    {
                        tbleView = [[MagicUITableView alloc]initWithFrame:CGRectMake(0.0f,self.headHeight, 320.0f, self.view.frame.size.height)];
                      //  [tbleView setTableViewType:DTableViewSlime];
                        [self.view addSubview:tbleView];
                        
                    }
                   

                    
                    [tbleView reloadData];
                    
                    BOOL bHaveNext = [[dict objectForKey:@"havenext"] boolValue];
                    
                    if (bHaveNext == 1) {
                        [tbleView reloadData:NO];
                    }else{
                        [tbleView reloadData:YES];
                    }
                    
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
