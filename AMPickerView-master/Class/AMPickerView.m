//
//  AMPickerView.m
//  AMPickerView
//
//  Created by AndyMu on 2017/9/9.
//  Copyright © 2017年 AndyMu. All rights reserved.
//

#import "AMPickerView.h"
static CGFloat const maxWidth = 36;
static NSString * const kName = @"name";
static NSString * const kIndex = @"index";

@interface UIPickerView (AMPicker)

@end

@implementation UIPickerView (AMPicker)

- (void)am_clearSpearatorLine {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.frame.size.height < 1) {
            [obj setHidden:YES];
        }
    }];
}

@end

@interface AMPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    CGFloat _width;
    CGFloat _height;
    UIView *_leftView;
    UIView *_rightView;
    UIImageView * _backgroundImageView;
    UIPickerView *_pickerView;
    NSInteger  _selectIndex;
}
@end

@implementation AMPickerView

#pragma mark - LeftCycle

- (instancetype)init {
    self = [super init];
    if (self) {
       _selectIndex = 0;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initPickerView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
         [self initPickerView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _width = CGRectGetWidth(self.frame);
    _height = CGRectGetHeight(self.frame);

    [_backgroundImageView setFrame:self.bounds];
    [_pickerView setFrame:self.bounds];
    [self transformForPickerView];
    [_leftView setFrame:CGRectMake(0, 0, maxWidth, _height)];
    [_rightView setFrame:CGRectMake(_width - maxWidth, 0, maxWidth, _height)];
}

- (void)transformForPickerView {
    //逆时针旋转90度
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-M_PI/2);
    [_pickerView setTransform:rotate];
    //重新设置frame
    [_pickerView.layer setFrame:CGRectMake(0, 0, _width, _height)];
}

#pragma mark - UI

- (void)initPickerView {
    //背景图
    _backgroundImageView = [[UIImageView alloc]init];
    _backgroundImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_backgroundImageView];
    
    //先把pickerView设置成正方形再去旋转
    _pickerView = [[UIPickerView alloc]init];
    [_pickerView setDelegate:self];
    [_pickerView setDataSource:self];
    [_pickerView setShowsSelectionIndicator:NO];
    [_pickerView setBackgroundColor:[UIColor clearColor]];
    [self insertSubview:_pickerView aboveSubview:_backgroundImageView];
    
    //按钮
    _leftView = [[UIView alloc]init];
    _leftView.backgroundColor = [UIColor clearColor];
    [self insertSubview:_leftView aboveSubview:_pickerView];
    _rightView = [[UIView alloc]init];
    _rightView.backgroundColor = [UIColor clearColor];
    [self insertSubview:_rightView aboveSubview:_pickerView];
}

- (UIView *)customViewForRow:(NSInteger)row {
    CGAffineTransform rotateItem = CGAffineTransformMakeRotation(M_PI/2);
    UILabel *labelItem = [[UILabel alloc]init];
    labelItem.text =   _dataSource[row];
    labelItem.backgroundColor = [UIColor clearColor];
    labelItem.textAlignment = NSTextAlignmentCenter;
    if (row == _selectIndex) {
        labelItem.textColor = _selectTextColor ?: [UIColor blackColor];
        labelItem.font = _selectTextFont ?: [UIFont boldSystemFontOfSize:25];
    }else {
        labelItem.textColor = _textColor ?: [UIColor grayColor];
        labelItem.font = _textFont ?: [UIFont systemFontOfSize:20];
    }
    labelItem.transform = rotateItem;
    return labelItem;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _dataSource.count;
}

#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    [pickerView am_clearSpearatorLine];
    return [self customViewForRow:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return (( _width - maxWidth * 2 ) / 5 < 20) ? 20 : ( _width - maxWidth * 2 ) / 5;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (row < _dataSource.count) {
        _selectIndex = row;
        [self reloadComponent];
        if ([self.delegate respondsToSelector:@selector(pickerView:didSelectRow:)]) {
            [self.delegate pickerView:self didSelectRow:row];
        }
    }
}

#pragma mark - -

/**
 *  pickerView滑动到指定位置
 */
- (void)scrollToIndex:(NSInteger)scrollToIndex{
    if (scrollToIndex < [_dataSource count]) {
        _selectIndex = scrollToIndex;
        [_pickerView selectRow:scrollToIndex inComponent:0 animated:true];
        [self reloadComponent];
    }
}

/**
 *  查询当前选择元素 {index：选择位置  name：元素名称}
 */
- (NSDictionary *)selectedItem{
    NSInteger index = [_pickerView selectedRowInComponent:0];
    if (_dataSource.count > index) {
        return @{kName:_dataSource[index],kIndex:@(index)};
    }
    return nil;
}

#pragma mark - BackgroundImage

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    if (backgroundImage) {
        _backgroundImageView.image = backgroundImage;
    }
}

#pragma mark - Button

/**
 *  添加左侧按钮
 */
- (void)setLeftButton:(UIButton *)leftButton {
    if (leftButton) {
       [_leftView addSubview:leftButton];
    }
}

/**
 *  添加右侧按钮
 */
- (void)setRightButton:(UIButton *)rightButton {
    if (rightButton) {
        [_rightView addSubview:rightButton];
    }
}

/**
 刷新数据
 */
- (void)reloadComponent {
    if (_pickerView) {
        [_pickerView reloadComponent:0];
    }
}

@end
