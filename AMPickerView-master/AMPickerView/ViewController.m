//
//  ViewController.m
//  AMPickerView
//
//  Created by AndyMu on 2017/9/10.
//  Copyright © 2017年 AndyMu. All rights reserved.
//

#import "ViewController.h"
#import "AMPickerView.h"

@interface ViewController ()<AMPickerViewDelegate>
@property (nonatomic, strong) AMPickerView *pickerView;
@property (weak, nonatomic) IBOutlet AMPickerView *xibPickerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _pickerView = [[AMPickerView alloc]initWithFrame:CGRectMake(18, 280, [UIScreen mainScreen].bounds.size.width - 36 , 50)];
    _pickerView.backgroundColor = [UIColor clearColor];
    _pickerView.textFont = [UIFont systemFontOfSize:20];
    _pickerView.selectTextFont = [UIFont systemFontOfSize:25];
    _pickerView.textColor = [UIColor redColor];
    _pickerView.selectTextColor = [UIColor purpleColor];
    _pickerView.backgroundImage = [UIImage imageNamed:@"bg_popup_creditplus"];
    _pickerView.dataSource = @[@"5",@"6",@"7",@"80",@"90",@"10",@"1100",@"1200",@"1300",@"1400"];
    _pickerView.delegate = self;
    _pickerView.scrollToIndex = 5;
    
    UIButton *downButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 50)];
    [downButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [downButton setImage:[UIImage imageNamed:@"ic_arrow_left"] forState:UIControlStateNormal];
    _pickerView.leftButton = downButton;
    UIButton *upButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 50)];
    [upButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [upButton setImage:[UIImage imageNamed:@"ic_arrow_right"] forState:UIControlStateNormal];
    _pickerView.rightButton = upButton;
    
    [self.view addSubview:_pickerView];
    
    
    _xibPickerView.backgroundColor = [UIColor clearColor];
    _xibPickerView.textFont = [UIFont systemFontOfSize:20];
    _xibPickerView.selectTextFont = [UIFont systemFontOfSize:25];
    _xibPickerView.textColor = [UIColor redColor];
    _xibPickerView.selectTextColor = [UIColor purpleColor];
    _xibPickerView.backgroundImage = [UIImage imageNamed:@"bg_popup_creditplus"];
    _xibPickerView.dataSource = @[@"5",@"6",@"7",@"80",@"90",@"10",@"1100",@"1200",@"1300",@"1400"];
    _xibPickerView.delegate = self;
    _xibPickerView.scrollToIndex = 5;
    
    
}

#pragma mark - Action

-(void)leftButtonAction{
    NSDictionary *result = _pickerView.selectedItem;
    NSInteger currentIndex = [result[@"index"] integerValue];
    [_pickerView scrollToIndex:currentIndex-1];
}

-(void)rightButtonAction{
    NSDictionary *result = _pickerView.selectedItem;
    NSInteger currentIndex = [result[@"index"] integerValue];
    [_pickerView scrollToIndex:currentIndex+1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
