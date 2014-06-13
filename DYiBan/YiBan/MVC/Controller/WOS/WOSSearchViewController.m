//
//  WOSSearchViewController.m
//  WOS
//
//  Created by apple on 14-6-8.
//  Copyright (c) 2014年 ZzL. All rights reserved.
//

#import "WOSSearchViewController.h"

@interface WOSSearchViewController ()

@end

@implementation WOSSearchViewController

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
        //        [self.rightButton setHidden:YES];
        [self.headview setTitle:@"搜索"];
        
        
        
        [self.headview setTitleColor:[UIColor whiteColor]];
        [self setButtonImage:self.leftButton setImage:@"返回键"];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [self.headview setBackgroundColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
        
        
    }
    else if ([signal is:[MagicViewController CREATE_VIEWS]]) {
//        appde= appDelegate;
//        [self.rightButton setHidden:YES];
//        //        arrayCard = [[NSArray alloc]init];
//        
//        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.view.frame.size.height)];
//        [self.view addSubview:scrollView];
//        RELEASE(scrollView);
//        
//        
//        dictOrder = [[NSMutableDictionary alloc]init];
//        
//        UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, self.headHeight + 20, 250.0, 30.0f)];
//        [labelName setBackgroundColor:[UIColor clearColor]];
//        NSString *strName = [[NSUserDefaults standardUserDefaults]objectForKey:@"shopname"];
//        [labelName setText:strName];
//        
//        [labelName setTextColor:[UIColor colorWithRed:40.0f/255 green:191.0f/255 blue:140.0f/255 alpha:1.0f]];
//        [scrollView addSubview:labelName];
//        RELEASEOBJ(labelName);
//
//        
//        _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, CGRectGetHeight(switchFree.frame) + CGRectGetMinY(switchFree.frame) + 5, 320.0f, 90)];
//        [_tableView1 setDataSource:self];
//        [_tableView1 setDelegate:self];
//        [_tableView1 setBackgroundColor:[UIColor whiteColor]];
//        [_tableView1 setTag:102];
//        [scrollView addSubview:_tableView1];
//        //        RELEASEOBJ(_tableView1);
        
        

        
        
    }
    
    
    else if ([signal is:[MagicViewController WILL_APPEAR]]) {
        
        DLogInfo(@"rrr");
        
        
    } else if ([signal is:[MagicViewController DID_DISAPPEAR]]){
        
        
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
