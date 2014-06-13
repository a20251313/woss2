//
//  MapViewController.m
//  
//
//  Created by Jian-Ye on 12-10-16.
//  Copyright (c) 2012年 Jian-Ye. All rights reserved.
//

#import "MapViewController.h"
#import "CallOutAnnotationVifew.h"
#import "JingDianMapCell.h"
#define span 40000
#import "WOSStarView.h"
#import "WOShopDetailViewController.h"
#import "DYBSetButton.h"



@interface MapViewController ()
{
    NSMutableArray *_annotationList;
    
    CalloutMapAnnotation *_calloutAnnotation;
	CalloutMapAnnotation *_previousdAnnotation;
    
    UIView *viewTop;
    
}



-(void)setAnnotionsWithList:(NSArray *)list;

@end

@implementation MapViewController

@synthesize mapView=_mapView;
@synthesize dictInfo = _dictInfo;
@synthesize delegate;

- (void)dealloc
{
    [_dictInfo release];
    [_mapView release];
    [_annotationList release];
    [super dealloc];
}

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self viewDidLoad];
    }
    return self;
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    _annotationList = [[NSMutableArray alloc] init];
    
    
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f,CGRectGetHeight(self.frame))];
    _mapView.mapType=MKMapTypeStandard;
    _mapView.delegate=self;
    _mapView.showsUserLocation=YES;
    [self addSubview:_mapView];
    RELEASE(_mapView);

//    [super viewDidLoad];
}

-(void)setAnnotionsWithList:(NSArray *)list
{
    for (NSDictionary *dic in list) {
        
        
        
      
        NSString *strJINWEI = [dic objectForKey:@"gps"];
        NSArray *arrayStr = [strJINWEI componentsSeparatedByString:@","];

        
        CLLocationDegrees latitude=[[arrayStr objectAtIndex:0] doubleValue];
        CLLocationDegrees longitude=[[arrayStr objectAtIndex:1] doubleValue];
        CLLocationCoordinate2D location=CLLocationCoordinate2DMake(longitude, latitude);
        
        MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(location,1000 ,1000 );
        MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:region];
        [_mapView setRegion:adjustedRegion animated:YES];
        
        BasicMapAnnotation *  annotation=[[[BasicMapAnnotation alloc] initWithLatitude:longitude andLongitude:latitude]  autorelease];
        annotation.dictInfo = dic;
        [_mapView   addAnnotation:annotation];
    }
    
    
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
	if ([view.annotation isKindOfClass:[BasicMapAnnotation class]]) {
        if (_calloutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            return;
        }
        if (_calloutAnnotation) {
            [mapView removeAnnotation:_calloutAnnotation];
            _calloutAnnotation = nil;
        }
        
        
        BasicMapAnnotation *mapAnnotation = (BasicMapAnnotation *)view.annotation;
        
        UIView *viewq  = [self viewWithTag:101];
        
        if (!viewq) {
            
            viewTop = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 70.0f)];
            [viewTop setBackgroundColor:[UIColor whiteColor]];
            [viewTop setTag:101];
            [self addSubview:viewTop];
            
            DYBSetButton *btn = [[DYBSetButton alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 70.0f)];
            btn.sender = mapAnnotation.dictInfo;
//            [btn setBackgroundColor:[UIColor]];
            [btn addTarget:self action:@selector(doDO:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [btn release];
            
        }
        
        [self creatCell:mapAnnotation.dictInfo];
        
//        if([delegate respondsToSelector:@selector(customMKMapViewDidSelectedWithInfo:)]){
//            BasicMapAnnotation *mapAnnotation = (BasicMapAnnotation *)view.annotation;
//            NSDictionary *dict = mapAnnotation.dictInfo;
//            [delegate customMKMapViewDidSelectedWithInfo:dict];
//        }
//        _calloutAnnotation = [[[CalloutMapAnnotation alloc]
//                               initWithLatitude:view.annotation.coordinate.latitude
//                               andLongitude:view.annotation.coordinate.longitude] autorelease];
//        _calloutAnnotation.dictInfo = ((BasicMapAnnotation *)view.annotation).dictInfo;
//        [mapView addAnnotation:_calloutAnnotation];
//        
//        [mapView setCenterCoordinate:_calloutAnnotation.coordinate animated:YES];
	}
    else{
        
//        view.annotation
        
        if([delegate respondsToSelector:@selector(customMKMapViewDidSelectedWithInfo:)]){
            CallOutAnnotationVifew * callView = (CallOutAnnotationVifew *)view;
            NSDictionary *dict = callView.dictInfo;
            [delegate customMKMapViewDidSelectedWithInfo:dict];
        }
    }
}

-(void)doDO:(id)sender{

    
    DYBSetButton *btn = (DYBSetButton *)sender;
    
    WOShopDetailViewController *detail = [[WOShopDetailViewController alloc]init];
    NSDictionary *dictResult = btn.sender;
    detail.dictInfo = dictResult;
    
    DYBBaseViewController *vc = (DYBBaseViewController *)[self viewController];
    
    [vc.drNavigationController pushViewController:detail animated:YES];
    RELEASE(detail);
    


}


-(void)creatCell:(NSDictionary *)dict{
    
    //    UIImageView *imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10.0f, 10.0f, 50.0f, 50.0f)];
    //      NSURL *url = [NSURL URLWithString:[DYBShareinstaceDelegate addIPImage:[dict objectForKey:@"imgUrl"] ]];
    //    [imageViewIcon setImageWithURL:url];
    //    [imageViewIcon setBackgroundColor:[UIColor redColor]];
    //    [self addSubview:imageViewIcon];
    //    RELEASE(imageViewIcon);
    
    for (UIView *view in [viewTop subviews]) {
        
        [view removeFromSuperview];
        view = nil;
    }
    
    
    UILabel *imageViewIcon = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 10.0f, 50.0f, 50.0f)];
    [imageViewIcon setBackgroundColor:[UIColor colorWithRed:255.0f/255 green:91.0f/255 blue:91.0f/255 alpha:1.0f]];
    [imageViewIcon setTextAlignment:NSTextAlignmentCenter];
    [imageViewIcon setTextColor:[UIColor whiteColor]];
    [imageViewIcon.layer setCornerRadius:10.0f];
    [imageViewIcon.layer setBorderWidth:0.0f];
    [imageViewIcon.layer setMasksToBounds:YES];
    
    [imageViewIcon setText:[[dict objectForKey:@"kitchenName"] substringToIndex:1]];
    [viewTop addSubview:imageViewIcon];
    
    UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(imageViewIcon.frame) + 10 + CGRectGetWidth(imageViewIcon.frame), 10.0f, 120.0f, 20.0f)];
    [labelName setBackgroundColor:[UIColor clearColor]];
    [labelName setFont:[UIFont systemFontOfSize:16.0f]];
    [labelName setText:[dict objectForKey:@"kitchenName"]];
    [viewTop addSubview:labelName];
    RELEASE(labelName);
    
    
    
    
    
    
    UIImage *imagehui = [UIImage imageNamed:@"优惠小图标"];
    UIImageView *imageViewIndexHui = [[UIImageView alloc]initWithFrame:CGRectMake(370/2,  10, imagehui.size.width/2, imagehui.size.height/2)];
    [imageViewIndexHui setImage:imagehui];
    [imageViewIndexHui setBackgroundColor:[UIColor clearColor]];
    //    if ([[dict objectForKey:@"hasDiscount"] boolValue]) {
    [viewTop addSubview:imageViewIndexHui];
    RELEASE(imageViewIndexHui);
    
    //    }
    
    UIImage *imageType = [UIImage imageNamed:@"川菜小图标"];
    UIImageView *imageViewIndexchuan = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(labelName.frame), 20 + 10, imageType.size.width/2, imageType.size.height/2)];
    [imageViewIndexchuan setImage:imageType];
    
    [imageViewIndexchuan setBackgroundColor:[UIColor clearColor]];
    [viewTop addSubview:imageViewIndexchuan];
    RELEASE(imageViewIndexchuan);
    
    WOSStarView *start = [[WOSStarView alloc]initWithFrame:CGRectMake(CGRectGetMinX(imageViewIndexchuan.frame) + CGRectGetWidth(imageViewIndexchuan.frame) + 10, CGRectGetMinY(imageViewIndexchuan.frame), 100.0f, 20.0f) num:[[dict objectForKey:@"starLevel"] intValue]];
    [viewTop addSubview:start];
    RELEASE(start);
    
    
    UILabel *labelNameDistance = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(imageViewIcon.frame) + CGRectGetWidth(imageViewIcon.frame) + 10, 15.0f + CGRectGetMinY(start.frame), 120.0f, 20.0f)];
    double lat = 100;
    double lon = 34;
    NSString *gps = [dict objectForKey:@"gps"];
    NSArray *arrayGPS = [gps componentsSeparatedByString:@","];
    double tt = [DYBShareinstaceDelegate getDsitance_lat_a:lat lng_a:lon lat_b:[[arrayGPS objectAtIndex:0] doubleValue] lng_b:[[arrayGPS objectAtIndex:1] doubleValue]];
    [labelNameDistance setFont:[UIFont systemFontOfSize:12.0f]];
    [labelNameDistance setTextColor:[UIColor colorWithRed:159.0f/255 green:159.0f/255 blue:159.0f/255 alpha:1.0f]];
    [labelNameDistance setText:[NSString stringWithFormat:@"距离我%@",[self getDistance:tt] ]];
    [viewTop addSubview:labelNameDistance];
    RELEASE(labelNameDistance);
    [labelNameDistance setBackgroundColor:[UIColor clearColor]];
    
    UILabel *labelFree = [[UILabel alloc]initWithFrame:CGRectMake(370/2, 15.0f + CGRectGetMinY(start.frame), 120.0f, 20.0f)];
    [labelFree setFont:[UIFont systemFontOfSize:12.0f]];
    [labelFree setTextColor:[UIColor colorWithRed:159.0f/255 green:159.0f/255 blue:159.0f/255 alpha:1.0f]];
    [labelFree setBackgroundColor:[UIColor clearColor]];
    [labelFree setText:[NSString stringWithFormat:@"%@元起送",[dict objectForKey:@"pricePU"]]];
    [viewTop addSubview:labelFree];
    RELEASE(labelFree);
    
}

-(NSString *)getDistance:(double)distance{
    
    double distance1 = 0;
    if (distance > 1000) {
        distance1 = distance/1000;
        return [NSString stringWithFormat:@"%.2fKM",distance1];
    }else{
        
        return [NSString stringWithFormat:@"%.2f",distance];
    }
    
}

-(void)creat:(NSDictionary *)dict{
    
    for (UIView *view in [viewTop subviews]) {
        
        [view removeFromSuperview];
        view = nil;
    }
    
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 145/2)];
        [viewTop addSubview:view];
        RELEASE( view);
        
        UIImageView *imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake(9.0f,7.0f, 110/2, 110/2)];
        [imageViewIcon setBackgroundColor:[UIColor redColor]];
        [imageViewIcon setImage:[UIImage imageNamed:@"food1.png"]];
        [view addSubview:imageViewIcon];
        RELEASE(imageViewIcon);
        
        
        
        
        UILabel *labelNum = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(imageViewIcon.frame) + CGRectGetMinX(imageViewIcon.frame) + 3 + 3, 5, 100, 15)];
        [labelNum setBackgroundColor:[UIColor clearColor]];
        //    [labelNum setTextColor:ColorGryWhite];
        [labelNum setText:[dict objectForKey:@"kitchenName"]];
        [labelNum sizeToFit];
        [view addSubview:labelNum];
        RELEASE(labelNum);
        
        UIImage *imageChuan1 = [UIImage imageNamed:@"优惠小图标"];
        UIImageView *imageViewChuan1 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(labelNum.frame) + CGRectGetMinX(labelNum.frame) + 3 + 3, 5,imageChuan1.size.width/2 , imageChuan1.size.height/2)];
        [view addSubview:imageViewChuan1];
        [imageViewChuan1 setImage:imageChuan1];
        [imageViewChuan1 release];
        [imageViewChuan1 setBackgroundColor:[UIColor redColor]];
        
        
        UIImage *imageChuan = [UIImage imageNamed:@"川菜小图标"];
        UIImageView *imageViewChuan = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(imageViewIcon.frame) + CGRectGetMinX(imageViewIcon.frame) + 3 ,  CGRectGetHeight(labelNum.frame) + 5 + 3,imageChuan.size.width/2 , imageChuan.size.height/2)];
        [imageViewChuan setImage:imageChuan];
        [view addSubview:imageViewChuan];
        [imageViewChuan setBackgroundColor:[UIColor redColor]];
        [imageViewChuan release];
        
        int num = [[dict objectForKey:@"starLevel"] integerValue];
        
        WOSStarView *star = [[WOSStarView alloc]initWithFrame:CGRectMake(CGRectGetWidth(imageViewChuan.frame) + CGRectGetMinX(imageViewChuan.frame) + 3, CGRectGetHeight(labelNum.frame) + 5 + 3,100, 30) num:num];
        [star setBackgroundColor:[UIColor clearColor]];
        [view addSubview:star];
        [star release];
        
        
        UILabel *labelPrice = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(star.frame) + CGRectGetMinX(star.frame) + 3,  CGRectGetHeight(labelNum.frame) + 5 + 7 , 100, 15)];
        [labelPrice setText:[NSString stringWithFormat:@"人均：%@",[dict objectForKey:@"pricePU"]]];
        [labelPrice setTextColor:[UIColor colorWithRed:250/255.0f green:250/255.0f blue:250/255.0f alpha:1.0f]];
        [labelPrice setBackgroundColor:[UIColor clearColor]];
        [view addSubview:labelPrice];
        RELEASE(labelPrice);
        
        UILabel *labelAddr = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(imageViewIcon.frame) + CGRectGetMinX(imageViewIcon.frame) + 3 + 2,   CGRectGetMinY(labelPrice.frame) +CGRectGetHeight(labelPrice.frame) + 3 + 2, 100, 15) ];
        [labelAddr setTextColor:[UIColor colorWithRed:250/255.0f green:250/255.0f blue:250/255.0f alpha:1.0f]];
        [labelAddr setBackgroundColor:[UIColor clearColor]];
        [labelAddr setText:[dict objectForKey:@"typeName"]];
        [view addSubview:labelAddr];
        RELEASE(labelAddr);
        
        UIImage *imageT = [UIImage imageNamed:@"jian"];
        UIImageView *imageViewInt = [[UIImageView alloc]initWithFrame:CGRectMake(280.0f + 5, CGRectGetHeight(self.frame) - imageT.size.height/2 -3, imageT.size.width/2, imageT.size.height/2)];
        [imageViewInt setImage:imageT];
        //    [view addSubview:imageViewInt];
        ////    [imageViewInt setBackgroundColor:[UIColor redColor]];
        //    RELEASE(imageViewInt);
        [view setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *imageFen = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 145/2 - 1, 320.0f, 1)];
        [imageFen setImage:[UIImage imageNamed:@"class_dotline"]];
        [view addSubview:imageFen];
        RELEASE(imageFen);
    }
    

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if (_calloutAnnotation&& ![view isKindOfClass:[CallOutAnnotationVifew class]]) {
        if (_calloutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude)
        {
            CalloutMapAnnotation *oldAnnotation = _calloutAnnotation; //saving it to be removed from the map later
            _calloutAnnotation = nil; //setting to nil to know that we aren't showing a callout anymore
            dispatch_async(dispatch_get_main_queue(), ^{
                [mapView removeAnnotation:oldAnnotation]; //removing the annotation a bit later
            });
        }
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[CalloutMapAnnotation class]]) {

        CallOutAnnotationVifew *annotationView = (CallOutAnnotationVifew *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutView"];
        if (!annotationView) {
            annotationView = [[[CallOutAnnotationVifew alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutView"] autorelease];
//            JingDianMapCell  *cell = [[[NSBundle mainBundle] loadNibNamed:@"JingDianMapCell" owner:self options:nil] objectAtIndex:0];
            JingDianMapCell *cell = [[JingDianMapCell alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 70.0f, 30)];
            BasicMapAnnotation *rr = (BasicMapAnnotation *)annotation;
            annotationView.dictInfo = rr.dictInfo;
            [annotationView.contentView addSubview:cell];
            RELEASE(cell);
        }
        return annotationView;
	} else if ([annotation isKindOfClass:[BasicMapAnnotation class]]) {
        
         MKAnnotationView *annotationView =[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
        if (!annotationView) {
            annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation 
                                                           reuseIdentifier:@"CustomAnnotation"] autorelease];
            annotationView.canShowCallout = NO;
            annotationView.image = [UIImage imageNamed:@"pin.png"];
        }
		
		return annotationView;
    }
	return nil;
}
- (void)resetAnnitations:(NSArray *)data
{
    [_annotationList removeAllObjects];
    [_annotationList addObjectsFromArray:data];
    [self setAnnotionsWithList:_annotationList];
}


#pragma mark - back button signal
//- (void)handleViewSignal_DYBBaseViewController:(MagicViewSignal *)signal
//{
//    if ([signal is:[DYBBaseViewController BACKBUTTON]])
//    {
//        [self.drNavigationController popViewControllerAnimated:YES];
//    }else if ([signal is:[DYBBaseViewController NEXTSTEPBUTTON]]){
//    }
//}

@end
