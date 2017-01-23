//
//  MyMusicVC.m
//  LNTheme
//
//  Created by vvusu on 1/23/17.
//  Copyright © 2017 vvusu. All rights reserved.
//

#import "MyMusicVC.h"
#import "LNTheme.h"

@interface MyMusicVC ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UISwitch *testSwitch;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UISlider *sliderView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation MyMusicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.button ln_backgroundImageNamed:@"cm2_btm_bg" forState:UIControlStateNormal];
    [self.button ln_backgroundImageNamed:@"cm2_edit_cmt_bg" forState:UIControlStateHighlighted];
    
    [self.textField ln_textColor:C8];
    
    [self.textView ln_textColor:C8];
    
    [self.imageview ln_imageNamed:@"cm2_chat_bg"];
    
    [self.testSwitch ln_onTintColor:C8];
    [self.testSwitch ln_thumbTintColor:C3];
    
    [self.progressView ln_trackTintColor:C3];
    [self.progressView ln_progressTintColor:C8];
    
    [self.sliderView ln_minimumTrackTintColor:C8];
    [self.sliderView ln_maximumTrackTintColor:C3];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
