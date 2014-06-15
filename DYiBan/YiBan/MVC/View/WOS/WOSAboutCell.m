//
//  WOSCardCell.m
//  WOS
//
//  Created by tom zeng on 14-2-17.
//  Copyright (c) 2014年 ZzL. All rights reserved.
//

#import "WOSAboutCell.h"

#define CELLWIDTH  320
@implementation WOSAboutModel

+(id)modelWithType:(WOSAboutCellType)type mainName:(NSString*)mainName mainContent:(NSString*)mainContent
{
    WOSAboutModel   *model = [[WOSAboutModel alloc] init];
    model.type = type;
    model.mainName = mainName;
    model.mainContent = mainContent;
    return [model autorelease];
}

@end


@interface WOSAboutCell ()
{
    WOSAboutModel   *m_datamodel;
}

@end

@implementation WOSAboutCell
@synthesize dataModel = m_datamodel;

-(void)setDataModel:(WOSAboutModel *)newdataModel
{
    if (newdataModel != m_datamodel)
    {
        [m_datamodel release];
        m_datamodel = nil;
        m_datamodel = newdataModel;
    }
    
    [self creatCell:newdataModel];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)creatCell:(WOSAboutModel*)model
{
    
    for (UIView *subView in self.contentView.subviews)
    {
        if (subView != self.contentView)
        {
            [subView removeFromSuperview];
        }
    }
    if (model.type == WOSAboutCellIcon)
    {
        
        //height 140
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake((CELLWIDTH-60)/2, 10, 60, 60)];
        icon.image = [UIImage imageNamed:model.iconName];
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius = 30;
        [self.contentView addSubview:icon];
        [icon release];
        
        
        UILabel *mainName = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, CELLWIDTH, 30)];
        [mainName setBackgroundColor:[UIColor clearColor]];
        [mainName setTextColor:[UIColor blackColor]];
        [mainName setTextAlignment:NSTextAlignmentCenter];
        [mainName setFont:[UIFont systemFontOfSize:22]];
        [self.contentView addSubview:mainName];
        [mainName setText:model.mainName];
        [mainName release];
        
        
        UILabel *mainContent = [[UILabel alloc] initWithFrame:CGRectMake(0, 75+35, CELLWIDTH, 30)];
        [mainContent setBackgroundColor:[UIColor clearColor]];
        [mainContent setTextColor:[UIColor blackColor]];
        [mainContent setTextAlignment:NSTextAlignmentCenter];
        [mainContent setFont:[UIFont systemFontOfSize:22]];
        [self.contentView addSubview:mainContent];
        [mainContent setText:model.mainContent];
        [mainContent release];
        
        self.accessoryType = UITableViewCellAccessoryNone;
    }else
    {
          //height 60
        
        
        
        UIView  *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, CELLWIDTH, 40)];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        UILabel *mainName = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 30)];
        [mainName setBackgroundColor:[UIColor clearColor]];
        [mainName setTextColor:[UIColor blackColor]];
        [mainName setTextAlignment:NSTextAlignmentLeft];
        [mainName setFont:[UIFont systemFontOfSize:20]];
        [bgView addSubview:mainName];
        [mainName setText:model.mainName];
        [mainName release];
        
        
        UILabel *mainContent = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, CELLWIDTH-100, 30)];
        [mainContent setBackgroundColor:[UIColor clearColor]];
        [mainContent setTextColor:[UIColor blackColor]];
        [mainContent setTextAlignment:NSTextAlignmentLeft];
        [mainContent setFont:[UIFont systemFontOfSize:18]];
        [bgView addSubview:mainContent];
        [mainContent setText:model.mainContent];
        [mainContent release];
        
        
        [self.contentView addSubview:bgView];
        [bgView release];
        self.accessoryType = UITableViewCellAccessoryNone;
        
        if (model.type == WOSAboutCellIndicate)
        {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }

    
    
    [self setBackgroundColor:[UIColor clearColor]];
}

@end
