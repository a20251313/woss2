//
//  WOSHomeViewController.m
//  DYiBan
//
//  Created by tom zeng on 13-12-4.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "WOSHomeViewController.h"
#import "WOSGoodFoodViewController.h"
#import "WOSALLOrderViewController.h"
#import "WOSPersonInfoViewController.h"
#import "LLSplitViewController.h"
#import "WOSGoodPriceViewController.h"
#import "WOSMapViewController.h"
#import "WOSThinkYouLikeViewController.h"
#import "WOSFindFoodViewController.h"
#import "WOSActivityDetailViewController.h"
#import "JSONKit.h"
#import "JSON.h"
#import "Magic_Device.h"
#import "WOSShopsListTableViewCell.h"
#import "WOSShopDetail1ViewController.h"
#import "WOSPreferentialCardViewController.h"
#import "WOShopDetailViewController.h"

#import "WOSSearchViewController.h"

@interface WOSHomeViewController (){
    SGFocusImageFrame *bannerView;
    UIScrollView *scrollView;
    NSMutableArray *arrayResult;
    UISearchBar *searchBar;
    MagicUITableView *tabelViewList;
    NSMutableArray *arrayShopList;
    
    UIButton *btnLeft;
    UIButton *rightBtn;
    
    MapViewController*   _mapViewController;
    
    BOOL bMap;
    
    UIView *viewBG;
    UIView *viewBar1;
    UIView *viewBar2;
    
    UIView *viewBowwonView;
    
    
    UIView *viewPaiX;
    UIView *fenlei;
    UIView *youhui;
    
    int typeIndex;
    int orderType;
    BOOL hasDiscount ;
    BOOL freeDrink ;
    BOOL freeDeliver;
    int orderBy;
    
    
    CLLocationCoordinate2D coordinate2D;
    CLLocationManager *locManager;
    
    AppDelegate *app;
}
@property (nonatomic,retain)NSMutableArray *arrayShopList;
@end

@implementation WOSHomeViewController
@synthesize arrayShopList;

DEF_SIGNAL(TOUCHBUTTON)

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
    
//    DLogInfo(@"name -- %@",signal.name);
    
    if ([signal is:[MagicViewController LAYOUT_VIEWS]])
    {

        if (!btnLeft) {
            
            
        }
        
       

        
        [self setButtonImage:self.rightButton setImage:@"地图1.png"];
        [self.rightButton setHidden:YES];
        [self.leftButton setHidden:YES];
        
        
        [self.headview setTitleColor:[UIColor colorWithRed:193.0f/255 green:193.0f/255 blue:193.0f/255 alpha:1.0f]];
        [self.headview setBackgroundColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
        [self.view setBackgroundColor:ColorBG];
        DYBUITabbarViewController *tabBatC = [DYBUITabbarViewController sharedInstace];
        
        [tabBatC hideTabBar:YES animated:NO];

        if ([MagicDevice sysVersion] >= 7)
        {

        }

    }
    else if ([signal is:[MagicViewController CREATE_VIEWS]]) {
        
        app = appDelegate;
        
        [self doSure_getSource];
        
        bMap = NO;
        arrayShopList = [[NSMutableArray alloc]init];
        [self.headview setHidden:YES];
        [self.view bringSubviewToFront:btnLeft];
        
        typeIndex = 700;
        orderType = 2;
        orderBy = 1;
        
        viewBG = [[UIView alloc]initWithFrame:self.view.frame];
        [self.view addSubview:viewBG];
        RELEASE(viewBG);
        
        
        MagicRequest *request = [DYBHttpMethod wosKitchenInfo_activityList_count:@"4" sAlert:YES receive:self];
        [request setTag:3];
        
        [NSString stringWithFormat:@""];
        MagicRequest *request1 = [DYBHttpMethod wosgoodFood_typeIndex:[NSString stringWithFormat:@"%d",typeIndex] orderBy:[NSString stringWithFormat:@"%d",orderBy] page:@"0" count:@"1400" orderType:[NSString stringWithFormat:@"%d",orderType]  sAlert:YES receive:self];
        [request1 setTag:2];
        
       scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, self.headHeight- 44, 320, self.view.frame.size.height+ 44 - self.headHeight + 44)];
        [scrollView setBackgroundColor:[UIColor colorWithRed:61.0f/255 green:61.0f/255  blue:61.0f/255  alpha:1.0f]];
        [scrollView setBackgroundColor:[UIColor clearColor]];
        [viewBG addSubview:scrollView];
        RELEASE(scrollView);
        
        [self.rightButton setHidden:YES];
        
//        [self creatBowwon2];
        [self creatBowwonView];
        
        
    }
    
    
    else if ([signal is:[MagicViewController WILL_APPEAR]]) {
        
        if (!btnLeft) {
            
            btnLeft = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 20.0f, 40.0f, 40.0f)];
            [btnLeft setTitle:@"美食" forState:UIControlStateNormal];
            [btnLeft addTarget:self action:@selector(doLeft) forControlEvents:UIControlEventTouchUpInside];
            [btnLeft setBackgroundColor:[UIColor clearColor]];
//            [self.view addSubview:btnLeft];
//            RELEASE(btnLeft);

        }
        
        if (!rightBtn) {
            
            UIImage *image = [UIImage imageNamed:@"地图1"];
            rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(240, 20, image.size.width/2, image.size.height/2)];
            [rightBtn setImage:[UIImage imageNamed:@"地图1.png"] forState:UIControlStateNormal];
            [rightBtn addTarget:self action:@selector(doRight) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:rightBtn];
            RELEASE(rightBtn);
        }
        
        if (!searchBar) {
            
            searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(30, 20.0f, 200.0f, 30) ];
//        backgroundColor:[UIColor whiteColor] placeholder:@"" isHideOutBackImg:YES isHideLeftView:NO];
            [searchBar setShowsCancelButton:NO];
            [searchBar setPlaceholder:@"餐厅名字"];
            searchBar.delegate = self;
            [searchBar setBackgroundColor:[UIColor clearColor]];
            [self.view addSubview:searchBar];
            RELEASE(searchBar)
            
            /*UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 30.0f)];
            [searchBar addSubview:btn];

            [btn addTarget:self action:@selector(doSearch) forControlEvents:UIControlEventTouchUpInside];
            [btn release];*/
            float version = [[[ UIDevice currentDevice ] systemVersion ] floatValue ];
            
            if ([ searchBar respondsToSelector : @selector (barTintColor)]) {
                
                float  iosversion7_1 = 7.1 ;
                
                if (version >= iosversion7_1)
                    
                {
                    
                    //iOS7.1
                    
                    [[[[ searchBar . subviews objectAtIndex : 0 ] subviews ] objectAtIndex : 0 ] removeFromSuperview ];
                    
                    [ searchBar setBackgroundColor :[ UIColor clearColor ]];
                    
                }
                
                else
                    
                {
                    
                    //iOS7.0
                    
                    [ searchBar setBarTintColor :[ UIColor clearColor ]];
                    
                    [ searchBar setBackgroundColor :[ UIColor clearColor ]];
                    
                }
                
            }
            
            else
                
            {
                
                //iOS7.0 以下
                
                [[ searchBar . subviews objectAtIndex : 0 ] removeFromSuperview ];
                
                [ searchBar setBackgroundColor :[ UIColor clearColor ]];
                
            }
            
//            for (UIView *subview in searchBar.subviews)
//            {
//                if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
//                {
//                    [subview removeFromSuperview];
//                    break;
//                }
//            }
            

        }
        
        
        
        DLogInfo(@"rrr");
    } else if ([signal is:[MagicViewController DID_DISAPPEAR]]){
        
        
    }
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    
}

-(void)doSearch{
    
    WOSSearchViewController *search = [[WOSSearchViewController alloc]init];
    [self.drNavigationController pushViewController:search animated:YES];
    [search release];


}

-(void)doLeft{

    [self creatTopBatView ];



}

-(void)doRight{

    [self mapViewController];

}

#pragma mark- 接受tbv信号

static NSString *cellName = @"cellName";//

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
        NSDictionary *dict = (NSDictionary *)[signal object];
        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
        UITableView *tableView = [dict objectForKey:@"tableView"];
        
        NSMutableArray *arr_curSectionForCell=nil;
        NSMutableArray *arr_curSectionForModel=nil;
        
       
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
        UITableView *tableView = [dict objectForKey:@"tableView"];
        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
        
//        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
        
        WOSShopsListTableViewCell *cell = [[WOSShopsListTableViewCell alloc]init];
        [cell creatCell:[arrayShopList objectAtIndex:indexPath.row]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [signal setReturnValue:cell];
        
    }else if ([signal is:[MagicUITableView TABLEDIDSELECT]])//选中cell
    {
        NSDictionary *dict = (NSDictionary *)[signal object];
        UITableView *tableview = [dict objectForKey:@"tableView"];
        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
        
        
        WOShopDetailViewController *detail = [[WOShopDetailViewController alloc]init];
        NSDictionary *dictResult = [arrayShopList objectAtIndex:indexPath.row];
        detail.dictInfo = dictResult;
        [self.drNavigationController pushViewController:detail animated:YES];
        RELEASE(detail);
        
//        WOSPreferentialCardViewController *card = [[WOSPreferentialCardViewController alloc]init];
//        
//        //            [card setVc:_vc];
//        [self.drNavigationController pushViewController:card animated:YES];
//        
//        [card release];
        
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
        
//        [_tbv StretchingUpOrDown:0];
//        [[DYBUITabbarViewController sharedInstace] hideTabBar:YES animated:YES];
        
        [viewBar2 setHidden:YES];
        
        [viewPaiX setHidden:YES];
        [fenlei setHidden:YES];
        [youhui setHidden:YES];
        [self hideTabBar:YES animated:YES setView:viewBowwonView];
//         [self hideTabBar:YES animated:YES setView:viewBar2];
        
    }else if ([signal is:[MagicUITableView TAbLEVIEWSCROLLDOWN]]){//下滑
//        [_tbv StretchingUpOrDown:1];
//        [[DYBUITabbarViewController sharedInstace] hideTabBar:NO animated:YES];
         [viewBar2 setHidden:YES];
        [viewPaiX setHidden:YES];
        [fenlei setHidden:YES];
        [youhui setHidden:YES];
         [self hideTabBar:NO animated:YES setView:viewBowwonView];
//         [self hideTabBar:NO animated:YES setView:viewBar2];
        
    }
    else if ([signal is:[MagicUITableView TAbLEVIERELOADOVER]])//reload完毕
    {
        //        NSDictionary *dict = (NSDictionary *)[signal object];
        //        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
        //        UITableView *tableView = [dict objectForKey:@"tableView"];
        
        //        [_v_inputV.textV becomeFirstResponder];
    }
}


- (void)hideTabBar:(BOOL)isHidden animated:(BOOL)animated setView:(UIView *)view
{
    NSLog(@"-- %f",self.view.bounds.size.height);
    
    float version = [[UIDevice currentDevice].systemVersion floatValue];
    int offset1 = 0;
    if (version >= 7.0) {
        offset1 = 20;
    }

    if (isHidden)
    {
        if (view.frame.origin.y == self.view.bounds.size.height + offset1)
        {
            return;
        }
    }else
    {
        if (view.frame.origin.y == self.view.bounds.size.height - 40 + offset1)
        {
            return;
        }
    }
    
    if (animated)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.3f];
        if (isHidden)
        {
            CHANGEFRAMEORIGIN(view.frame, view.frame.origin.x, view.frame.origin.y + 40);
        }else
        {
            CHANGEFRAMEORIGIN(view.frame, view.frame.origin.x, view.frame.origin.y - 40);
        }
        [UIView commitAnimations];
    }else
    {
        if (isHidden)
        {
            CHANGEFRAMEORIGIN(view.frame, view.frame.origin.x, view.frame.origin.y + 1000);
        }else
        {
            CHANGEFRAMEORIGIN(view.frame, view.frame.origin.x, view.frame.origin.y - 40);
        }
    }
}




-(void)creatTopBatView{
    
    UIView *viewB = [self.view viewWithTag:1000];
    
    if (!viewB) {
        
        viewBar1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.headHeight, 320.0f, 40.0f)];
        [viewBar1 setTag:1000];
        [viewBar1 setBackgroundColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
        [viewBar1 setAlpha:0.6];
        [self.view addSubview:viewBar1];
        
        float offset = 320/3;
        for (int i = 0; i < 3; i++) {
            
            UIButton *btnTouch = [[UIButton alloc]initWithFrame:CGRectMake(i * offset, 0.0f, offset, 40)];
            [btnTouch setTag:i + 10];
            [btnTouch setTitle:[self getTitle:i] forState:UIControlStateNormal];
            [btnTouch addTarget:self action:@selector(doSelect:) forControlEvents:UIControlEventTouchUpInside];
            [viewBar1 addSubview:btnTouch];
            RELEASE(btnTouch);
        }

    }else if (viewB.hidden){
    
        [viewB setHidden:NO];
    
    }else{
    
        [viewB setHidden:YES];
    }
    


}

-(NSString *)getTitle:(int)index{

    switch (index) {
        case 0:
        {
        
            return @"地址";
        
        }
            break;
        case 1:
        {
            
            return @"美食";
            
        }
            break;
        case 2:
        {
            
            return @"店铺";
            
        }
            break;
    

        default:
            break;
    }
    return nil;
}


-(void)creatBowwon2{

    
    float version = [[UIDevice currentDevice].systemVersion floatValue];
    int offset1 = 0;
    if (version < 7.0) {
        offset1 = 20;
    }
    

    
    viewBar2 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.view.frame.size.height - offset1 -40 - 40, 320.0f, 40.0f)];
    [viewBar2 setTag:10001];
    [viewBar2 setBackgroundColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
    [viewBar2 setAlpha:0.7];
    [self.view addSubview:viewBar2];
    
    float offset = 320/3;
    for (int i = 0; i < 3; i++) {
        
        UIButton *btnTouch = [[UIButton alloc]initWithFrame:CGRectMake(i * offset, 0.0f, offset, 40)];
        [btnTouch setTag:i + 10];
        [btnTouch setTitle:[self gettitle2:i] forState:UIControlStateNormal];
        [btnTouch addTarget:self action:@selector(doSelect1:) forControlEvents:UIControlEventTouchUpInside];
        [viewBar2 addSubview:btnTouch];
        RELEASE(btnTouch);
    }
    

}

-(void)doSelect1:(id)sender{

    UIView *viewBar = [self.view viewWithTag:10001];
    UIButton *btn = (UIButton *)sender;
    if (viewBar) {
        
        
        
        for (int i = 10; i < 13; i++) {
            
            UIButton *btn1 = (UIButton *)[viewBar viewWithTag:i];
            if ([btn1 isEqual:btn]) {
                [btn1 setTitleColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f] forState:UIControlStateNormal];
            }else{
                [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            
            
        }
        
    }


}

-(NSString *)gettitle2:(int)index{

    switch (index) {
        case 0:
        {
            
            return @"免运费";
            
        }
            break;
        case 1:
        {
            
            return @"折扣";
            
        }
            break;
        case 2:
        {
            
            return @"限时";
            
        }
            break;
            
            
        default:
            break;
    }
    return nil;


}

-(void)doSelect:(id)sender{

    UIView *viewBar = [self.view viewWithTag:1000];
   UIButton *btn = (UIButton *)sender;
    if (viewBar) {
        
      
        
        for (int i = 10; i < 13; i++) {
            
            UIButton *btn1 = (UIButton *)[viewBar viewWithTag:i];
            if ([btn1 isEqual:btn]) {
                [btn1 setTitleColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f] forState:UIControlStateNormal];
            }else{
            [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            
            
        }
        
        [viewBar setHidden:YES];
        
    }


}

-(void)creatBowwonView{

    float version = [[UIDevice currentDevice].systemVersion floatValue];
    int offset1 = 0;
    if (version < 7.0) {
        offset1 = 20;
    }
    

   viewBowwonView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.view.frame.size.height - 40 - offset1, 320.0f, 40)];
    [viewBowwonView setTag:100101];
    [viewBowwonView setBackgroundColor:[UIColor grayColor]];
    [viewBowwonView setAlpha:0.7];
    [self.view addSubview:viewBowwonView];
    [viewBowwonView release];
    
    float offset = 320/4;
    for (int i = 0; i < 4; i++) {
        
        MagicUIButton *btnTouch = [[MagicUIButton alloc]initWithFrame:CGRectMake(i * offset, 0.0f, offset, 40)];
        [btnTouch setTag:i + 100];
        [btnTouch setTitle:[self getTitle1:i] forState:UIControlStateNormal];
        [btnTouch addTarget:self action:@selector(doSelectBowwon:) forControlEvents:UIControlEventTouchUpInside];
//        [btnTouch addSignal:[WOSHomeViewController TOUCHBUTTON] forControlEvents:UIControlEventTouchUpInside];
        [viewBowwonView addSubview:btnTouch];
        [btnTouch setBackgroundColor:[UIColor clearColor]];
        RELEASE(btnTouch);
    }
    
    
}
-(void)handleViewSignal_MagicUIButton:(MagicViewSignal *)signal{


    if ([signal is:[WOSHomeViewController TOUCHBUTTON]]) {
        
        UIView *viewBar = [self.view viewWithTag:100101];
        UIButton *btn = (UIButton *)[signal source];
        if (viewBar) {
            
            for (int i = 100; i < 104; i++) {
                
                UIButton *btn1 = (UIButton *)[viewBar viewWithTag:i];
                if ([btn1 isEqual:btn]) {
                    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                }else{
                    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
                
                
            }
            
        }
    }
    
}

-(NSString *)getTitle1:(int)index{

    switch (index) {
        case 0:
        {
        
        return @"排序";
        }
            break;
        case 1:
        {
            
            return @"分类";
        }
            break;

        case 2:
        {
            
            return @"全部";
        }
            break;

        case 3:
        {
            
            return @"优惠";
        }
            break;

            
        default:
            break;
    }
    
    return nil;

}

-(void)doSelectBowwon:(id)sender{

    UIView *viewBar = [self.view viewWithTag:100101];
    UIButton *btn = (UIButton *)sender;
    if (viewBar) {
        
        for (int i = 100; i < 104; i++) {
            
            UIButton *btn1 = (UIButton *)[viewBar viewWithTag:i];
            if ([btn1 isEqual:btn]) {
                [btn1 setTitleColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f] forState:UIControlStateNormal];
            }else{
                [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            
            
        }
        
        
        
        float version = [[UIDevice currentDevice].systemVersion floatValue];
        int offset1 = 0;
        if (version < 7.0) {
            offset1 = 20;
        }
        
        
        
        CGRect rect = CGRectMake(0.0f, self.view.frame.size.height - 40 - 20  , 320.0f, 40.0f);
        
        switch (btn.tag) {
            case 100:
            {
                if (!viewPaiX) {
                    
                    viewPaiX = [[UIView alloc]initWithFrame:rect];
                    [self.view addSubview:viewPaiX];
                    RELEASE(viewPaiX);
                    [viewPaiX setBackgroundColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
                    [viewPaiX setAlpha:0.7];
                    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0.0f, 160.0f, 40.0f)];
                    [btn1 setTag:10000];
                    [btn1 setTitle:@"距离优先" forState:UIControlStateNormal];
                    [btn1 addTarget:self action:@selector(setCan:) forControlEvents:UIControlEventTouchUpInside];
                    [viewPaiX addSubview:btn1];
                    RELEASE(btn1);
                    
                    
                    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(160, 0.0f, 160.0f, 40.0f)];
                    [btn2 setTag:10001];
                    [btn2 setTitle:@"热门优先" forState:UIControlStateNormal];
                    [btn2 addTarget:self action:@selector(setCan:) forControlEvents:UIControlEventTouchUpInside];
                    [viewPaiX addSubview:btn2];
                    RELEASE(btn2);
                }else{
                
                    [viewPaiX setHidden:NO];
                }
                

                if (fenlei) {
                    [fenlei setHidden:YES];
                }
                
                if (youhui) {
                    [youhui setHidden:YES];
                }
                
            }
                break;
            case 101:
            {
            
                if (!fenlei) {
                    
                    
                    float offset = 320/6;
                    
                    fenlei = [[UIView alloc]initWithFrame:rect];
                    [fenlei setBackgroundColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
                    [fenlei setAlpha:0.7];
                    [self.view addSubview:fenlei];
                    RELEASE(fenlei);
                    
                    for (int i = 0; i < 6; i++) {
                        
                        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(i * offset, 0.0f, offset, 40.0f)];

                        
                        [btn1 setTag:10002 + i];
                        [btn1 setTitle:[self getT:i] forState:UIControlStateNormal];
                        [btn1 addTarget:self action:@selector(setCan:) forControlEvents:UIControlEventTouchUpInside];
                        [fenlei addSubview:btn1];
                        
                    }
                    
                }else{
                    
                    [fenlei setHidden:NO];
                }
                
                
                if (viewPaiX) {
                    [viewPaiX setHidden:YES];
                }
                
                if (youhui) {
                    [youhui setHidden:YES];
                }


            
            }
                break;
            case 102:
            {
                [viewPaiX setHidden:YES];
                [fenlei setHidden:YES];
                [youhui setHidden:YES];
                
                typeIndex = 700;
                
                MagicRequest *request1 = [DYBHttpMethod wosgoodFood_typeIndex:[NSString stringWithFormat:@"%d",typeIndex] orderBy:[NSString stringWithFormat:@"%d",orderBy] page:@"0" count:@"1400" orderType:[NSString stringWithFormat:@"%d",orderType]  sAlert:YES receive:self];
                [request1 setTag:2];

            }
                break;
            case 103:
            {
                if (!youhui) {
                    
                    
                    float offset = 320/3;
                    
                    youhui = [[UIView alloc]initWithFrame:rect];
                    [youhui setBackgroundColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
                    [youhui setAlpha:0.7];
                    [self.view addSubview:youhui];
                    RELEASE(youhui);
                    
                    for (int i = 0; i < 3; i++) {
                        
                        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(i * offset, 0.0f, offset, 40.0f)];
                        
                        
                        [btn1 setTag:10009 + i];
                        [btn1 setTitle:[self getT1:i] forState:UIControlStateNormal];
                        [btn1 addTarget:self action:@selector(setCan:) forControlEvents:UIControlEventTouchUpInside];
                        [youhui addSubview:btn1];
                        
                    }
                    
                }else{
                    
                    [youhui setHidden:NO];
                }
                
                
                if (viewPaiX) {
                    [viewPaiX setHidden:YES];
                }
                
                if (fenlei) {
                    [fenlei setHidden:YES];
                }

                

            }
                break;
                
            default:
                break;
        }
        
    }
}

-(void)setCan:(id)sender{
    
    UIButton *btn = (UIButton *)sender;

    switch (btn.tag) {
        case 10000:
        {
            orderType = 5;
        
            [viewPaiX setHidden:YES];
            
            
            if (app.gps.length == 0) {
                
                 [DYBShareinstaceDelegate loadFinishAlertView:@"没有开启定位，无法次操作" target:self showTime:.8f];
                
                return;
            }
            
        }
            break;
            
        case 10001:
        {
            
             orderType = 2;
            [viewPaiX setHidden:YES];
        }
            break;
        case 10002:
        {
            typeIndex  = 100;
            [fenlei setHidden:YES];
        }
            break;
        case 10003:
        {
            
            typeIndex  = 200;[fenlei setHidden:YES];
        }
            break;
        case 10004:
        {
            typeIndex  = 300;
            [fenlei setHidden:YES];
        }
            break;
        case 10005:
        {
            typeIndex  = 400;
            [fenlei setHidden:YES];
        }
            break;
        case 10006:
        {
            typeIndex  = 600;
            [fenlei setHidden:YES];
        }
            break;
        case 10007:
        {
             typeIndex  = 500;
            [fenlei setHidden:YES];
        }
            break;
        case 10008:
        {
            
        }
            break;
        case 10009:
        {
            
            [youhui setHidden:YES];
            hasDiscount = YES;
            
        }
            break;
        case 10010:
        {
            
            [youhui setHidden:YES];
            freeDeliver = YES;
            
        }
            break;
        case 10011:
        {
            
            [youhui setHidden:YES];
            freeDrink = YES;
            
            
        }
            break;
            
        default:
            break;
    }

    MagicRequest *request1 = [DYBHttpMethod wosgoodFood_typeIndex:[NSString stringWithFormat:@"%d",typeIndex] orderBy:[NSString stringWithFormat:@"%d",orderBy] page:@"0" count:@"1400" orderType:[NSString stringWithFormat:@"%d",orderType]  sAlert:YES receive:self];
    [request1 setTag:2];
    
}

-(NSString *)getT1:(int)index{


    switch (index ) {
        case 0:
        {
            return @"打折";
        }
            break;
        case 1:
        {
            return @"免费配送";
        }
            break;
        case 2:
        {
            return @"送饮品";
            
        }
        default:
            break;
    }
    return nil;
}

-(NSString *)getT:(int)index{

    switch (index ) {
        case 0:
        {
        return @"中餐";
        }
            break;
        case 1:
        {
             return @"西餐";
        }
            break;
        case 2:
        {
            return @"小吃";

        }
            break;
        case 3:
        {
            return @"火锅";
        }
            break;
        case 4:
        {
            return @"清真";
        }
            break;
        case 5:
        {
            return @"甜点";
        }
            break;
            
        default:
            break;
    }

}
-(void)creatBanner{
    
    //添加最后一张图 用于循环
    int length = arrayResult.count;
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0 ; i < length; i++)
    {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"title%d",i],@"title" ,nil];
        [tempArray addObject:dict];
    }
    
    NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:length+2];
//    if (length > 1)
//    {
//        NSDictionary *dict = [tempArray objectAtIndex:length-1];
//        SGFocusImageItem *item = [[[SGFocusImageItem alloc] initWithDict:dict tag:-1] autorelease];
//        [itemArray addObject:item];
//    }
//    for (int i = 0; i < length; i++)
//    {
//        NSDictionary *dict = [tempArray objectAtIndex:i];
//        SGFocusImageItem *item = [[[SGFocusImageItem alloc] initWithDict:dict tag:i] autorelease];
//        [itemArray addObject:item];
//        
//    }
//    //添加第一张图 用于循环
//    if (length >1)
//    {
//        NSDictionary *dict = [tempArray objectAtIndex:0];
//        SGFocusImageItem *item = [[[SGFocusImageItem alloc] initWithDict:dict tag:length] autorelease];
//        [itemArray addObject:item];
//    }
//
//    [arrayResultTitle];
    NSMutableArray *arrayResultTitle = [[NSMutableArray alloc]init];

    
    
    NSMutableArray *arrayImage = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < arrayResult.count; i ++) {
        [arrayResultTitle addObject:@"6666"];
        [arrayImage addObject:[DYBShareinstaceDelegate addIPImage:[[arrayResult objectAtIndex:i] objectForKey:@"imgUrl"]]];

    }

    
    UIImage *image = [UIImage imageNamed:@"flash.png"];
    
    bannerView = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, self.headHeight - 20, 320, 240/2) delegate:self imageItems:itemArray isAuto:NO arrayStringTotal:arrayResultTitle arrayImage:arrayImage];
//    [bannerView setCenter:CGPointMake(160.0f, 100)];
//    [bannerView setArrayImage:arrayImage];
    bannerView.delegate = self;
    [bannerView scrollToIndex:1];
    [scrollView addSubview:bannerView];
    [bannerView release];
    RELEASE(arrayImage);
    RELEASE(arrayResultTitle);
}
-(void)goodPrice{

    WOSGoodPriceViewController *good = [[WOSGoodPriceViewController alloc]init];
    [self.drNavigationController pushViewController:good animated:YES];
    RELEASE(good);

}

-(void)goodFood{

    LLSplitViewController *goodFood = [LLSplitViewController getmainController];
    [self.drNavigationController pushViewController:goodFood animated:YES];
    RELEASE(goodFood);

}

-(void)mapViewController{

//    WOSMapViewController *map = [[WOSMapViewController alloc]init];
//    map.iType = 0;
//    map.arrayXY = arrayShopList;
//    [self.view addSubview:map.view];
    
    bMap = !bMap;
    if (bMap) {
        [_mapViewController setHidden:NO];
        [rightBtn setImage:[UIImage imageNamed:@"qiehuandituanjian"] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(void){
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:_mapViewController cache:YES];
        } completion:^(BOOL finish){
//            animationDurationLabel.text = @"动画结束";
            [viewBG setHidden:YES];
        }];
    }else{
       
        [viewBG setHidden:NO];
         [_mapViewController setHidden:YES];
     [rightBtn setImage:[UIImage imageNamed:@"切换地图按键"] forState:UIControlStateNormal];
        
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(void){
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:viewBG cache:YES];
        } completion:^(BOOL finish){
            [_mapViewController setHidden:YES];

        }];
    
    }
    
   
    [_mapViewController resetAnnitations:arrayShopList];

    
    
//    [self.drNavigationController pushViewController:map animated:YES];
//    RELEASE(map);
}
- (void)customMKMapViewDidSelectedWithInfo:(id)info
{
    NSLog(@"%@",info);
    
    WOShopDetailViewController *detail = [[WOShopDetailViewController alloc]init];
    detail.dictInfo = info;
    [self.drNavigationController pushViewController:detail animated:YES];
    RELEASE(detail);
    
}


-(void)youlike{
    WOSThinkYouLikeViewController *like = [[WOSThinkYouLikeViewController alloc]init];
    [self.drNavigationController pushViewController:like animated:YES];
    RELEASE(like);
}

-(void)nearby{
    
    WOSMapViewController *map = [[WOSMapViewController alloc]init];
    map.iType = 1;
    [self.drNavigationController pushViewController:map animated:YES];
    RELEASE(map);

}

-(void)nearbyPeople{

    WOSMapViewController *map = [[WOSMapViewController alloc]init];
    map.iType = 2;
    [self.drNavigationController pushViewController:map animated:YES];
    RELEASE(map);
}

-(void)searchFood{

    WOSFindFoodViewController *find = [[WOSFindFoodViewController alloc]init];
    [self.drNavigationController pushViewController:find animated:YES];
    RELEASE(find);

}

- (void)handleViewSignal_DYBBaseViewController:(MagicViewSignal *)signal
{
    if ([signal is:[DYBBaseViewController BACKBUTTON]])
    {
        
        NSLog(@"oo");
        
         [self creatTopBatView];
        
//        DYBUITabbarViewController *dync = [DYBUITabbarViewController sharedInstace];
//        [dync scrollMainView:1];
    }else if ([signal is:[DYBBaseViewController NEXTSTEPBUTTON]]){
//        
//        WOSPersonInfoViewController *person = [[WOSPersonInfoViewController alloc]init];
//        [self.drNavigationController pushViewController:person animated:YES];
//        RELEASE(person);
//        
        
    }
    
}


#pragma mark- 只接受HTTP信号
- (void)handleRequest:(MagicRequest *)request receiveObj:(id)receiveObj
{
    if ([request succeed])
    {
        
        if (request.tag == 2) {
            
            
            NSDictionary *dict = [request.responseString JSONValue];
            
            if (dict) {
                BOOL result = [[dict objectForKey:@"result"] boolValue];
                if (!result) {
                    
                    if ( !tabelViewList) {
                       self.arrayShopList =  [dict objectForKey:@"kitchenList"];
                        //                    [tabelViewList reloadData];
                        tabelViewList = [[MagicUITableView alloc]initWithFrame:CGRectMake(0.0f, 240/2 + self.headHeight, 320.0f, self.view.frame.size.height - CGRectGetMinY(bannerView.frame) - CGRectGetHeight(bannerView.frame))];
                        [tabelViewList setTableViewType:DTableViewSlime];
                        [viewBG insertSubview:tabelViewList atIndex:1];
                        //                    [self.view addSubview:tabelViewList];
                        NSLog(@"tableview --- %@",tabelViewList);
                        RELEASE(tabelViewList)
                        
                        _mapViewController = [[MapViewController alloc] initWithFrame:CGRectMake(0.0f, self.headHeight + 0 , 320.0f, self.view.bounds.size.height - self.headHeight + 20)];
                        _mapViewController.delegate = self;
                        [_mapViewController setHidden:YES];
                        [self.view insertSubview:_mapViewController atIndex:2];
                    }else{
                    
                        [arrayShopList removeAllObjects];
                        self.arrayShopList = [dict objectForKey:@"kitchenList"];
                     
                        [tabelViewList reloadData];
                    }
                    
//                    [self.view addSubview:_mapViewController];

                }else{
                    NSString *strMSG = [dict objectForKey:@"message"];
                    
                    [DYBShareinstaceDelegate popViewText:strMSG target:self hideTime:.5f isRelease:YES mode:MagicPOPALERTVIEWINDICATOR];
                    
                    
                }
            }
        }else if(request.tag == 3){
            
            NSDictionary *dict = [request.responseString JSONValue];
            arrayResult  = [[NSMutableArray alloc]initWithArray:[dict objectForKey:@"activityList"]];
            
            if (dict) {
                BOOL result = [[dict objectForKey:@"result"] boolValue];
                if (!result) {
                    
//                    [tableView1 reloadData];
                    [self creatBanner];
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


- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame currentItem:(int)index{

//    WOSActivityDetailViewController *detail = [[WOSActivityDetailViewController alloc]init];
//    detail.dictInfo  = [arrayResult objectAtIndex:index];
//    [self.drNavigationController pushViewController:detail animated:YES];
//    RELEASE(detail);
    
    WOShopDetailViewController *detail = [[WOShopDetailViewController alloc]init];
    NSDictionary *dictResult = [arrayResult objectAtIndex:index];
    detail.dictInfo = dictResult;
    [self.drNavigationController pushViewController:detail animated:YES];
    RELEASE(detail);


}

- (void)dealloc
{
    
    [super dealloc];
}
#pragma mark    UISearchBardelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)localsearchBar
{
    
    if (![localsearchBar.text length])
    {
        [DYBShareinstaceDelegate popViewText:@"搜索条件不能够为空!" target:self hideTime:.5f isRelease:YES mode:MagicPOPALERTVIEWINDICATOR];
        return;
        
    }
    
    WOSSearchViewController *search = [[WOSSearchViewController alloc]init];
    search.searkey = localsearchBar.text;
    [self.drNavigationController pushViewController:search animated:YES];
    [search release];
    
}

//
///**
// *用户位置更新后，会调用此函数
// *@param mapView 地图View
// *@param userLocation 新的用户位置
// */
//
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
	if (userLocation != nil) {
		NSLog(@"%f %f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
        
        //        CLLocationDistance radiusMeters = 500; //设置搜索范围
        //        [_search poiMultiSearchNearBy:@[@"学校", @"美食", @"小区", @"交通"] center:_mapView.centerCoordinate radius:radiusMeters pageIndex:0];
        
        //        [_searchTest reverseGeocode:mapView.userLocation.location.coordinate];
	}
    
}
///**
// *在地图View停止定位后，会调用此函数
// *@param mapView 地图View
// */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"stop locate");
}
//
///**
// *定位失败后，会调用此函数
// *@param mapView 地图View
// *@param error 错误号，参考CLError.h中定义的错误号
// */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}
//
//
- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error{
    NSLog(@"%@", result.strAddr);
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"%f,%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    
    coordinate2D.latitude = newLocation.coordinate.latitude;
    coordinate2D.longitude = newLocation.coordinate.longitude;
    
    
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:
     ^(NSArray* placemarks, NSError* error){
         NSLog(@"%@",placemarks);
         
      //   CLPlacemark *placemark = [placemarks objectAtIndex:0];
      //   NSArray *names = [placemark.addressDictionary objectForKey:@"FormattedAddressLines"];
         
         if (app.gps.length == 0) {
             
             
            
             
            app.gps = [NSString stringWithFormat:@"%f,%f",newLocation.coordinate.longitude,newLocation.coordinate.latitude];
        
             
         }
         
         
         
     }];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}


-(void)doSure_getSource{
    
    locManager = [[CLLocationManager alloc] init];
    locManager.delegate = self;
    locManager.desiredAccuracy = kCLLocationAccuracyBest;
    locManager.distanceFilter = 5.0;
    [locManager startUpdatingLocation];
    
    
}


@end
