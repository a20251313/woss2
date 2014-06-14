//
//  WOSAddrViewController.h
//  DYiBan
//
//  Created by tom zeng on 13-11-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "DYBBaseViewController.h"
#import "WOSAdrrDrtailView.h"
#import "WOSPayViewController.h"

@interface WOSAddrViewController : DYBBaseViewController<UITableViewDataSource,UITableViewDelegate,WOSAdrrDrtailViewDelegate>
@property(nonatomic,retain)WOSPayViewController *payController;

@end
