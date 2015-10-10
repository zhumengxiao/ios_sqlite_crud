//
//  PccpaDBHelper.h
//  iOSCrud
//
//  Created by 朱梦晓 on 15-10-8.
//  Copyright (c) 2015年 Pccpa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PccpaTask.h"

@interface PccpaDBHelper : NSObject


-(BOOL) addTask:(PccpaTask *)task;

-(NSMutableArray *) getTaskList;

-(BOOL) deleteTask:(PccpaTask *) task;

-(BOOL) updateTask:(PccpaTask *) task;


@end
