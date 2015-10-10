//
//  PccpaAddViewController.h
//  iOSCrud
//
//  Created by 朱梦晓 on 15-10-8.
//  Copyright (c) 2015年 Pccpa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PccpaTask.h"

@interface PccpaAddViewController : UIViewController
@property PccpaTask * item;
-(IBAction)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
