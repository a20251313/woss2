//
//  WOSAboutCell.h
//  WOS
//
//  Created by tom zeng on 14-2-17.
//  Copyright (c) 2014年 ZzL. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    WOSAboutCellIcon,
    WOSAboutCellIndicate,
    WOSAboutCellNormal
}WOSAboutCellType;


@interface WOSAboutModel : NSObject

@property(nonatomic,retain)NSString *iconName;
@property(nonatomic,retain)NSString *mainName;
@property(nonatomic,retain)NSString *mainContent;
@property(nonatomic)WOSAboutCellType type;


+(id)modelWithType:(WOSAboutCellType)type mainName:(NSString*)mainName mainContent:(NSString*)mainContent;
@end

@interface WOSAboutCell : UITableViewCell
@property(nonatomic,retain)WOSAboutModel    *dataModel;
@end
