//
//  PccpaDetailViewController.m
//  iOSCrud
//
//  Created by 朱梦晓 on 15-10-10.
//  Copyright (c) 2015年 Pccpa. All rights reserved.
//

#import "PccpaDetailViewController.h"

@interface PccpaDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputText;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation PccpaDetailViewController

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
    if(self.task!=nil)
    {
        self.inputText.text= self.task.taskName;
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(self.inputText.text.length>0)
    {
        self.task.taskName = self.inputText.text;
    
    }
}



@end
