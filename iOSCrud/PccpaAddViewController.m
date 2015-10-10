//
//  PccpaAddViewController.m
//  iOSCrud
//
//  Created by 朱梦晓 on 15-10-8.
//  Copyright (c) 2015年 Pccpa. All rights reserved.
//

#import "PccpaAddViewController.h"
#import "PccpaDBHelper.h"

@interface PccpaAddViewController ()
- (IBAction)saveClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *inputText;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation PccpaAddViewController

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

-(IBAction)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(sender==self.saveButton)
    {
        if(self.inputText.text.length>0)
        {
            PccpaTask * task = [[PccpaTask alloc] init];
            task.taskName = self.inputText.text;
            self.item = task;
        }
    }
}

@end
