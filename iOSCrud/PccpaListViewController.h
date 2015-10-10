//
//  PccpaListViewController.h
//  iOSCrud
//
//  Created by 朱梦晓 on 15-10-8.
//  Copyright (c) 2015年 Pccpa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PccpaListViewController : UITableViewController
@property NSMutableArray * list;
-(IBAction)backToList:(UIStoryboardSegue *)segue ;
@end
