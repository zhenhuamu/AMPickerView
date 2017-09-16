//
//  AMPickerView.h
//  AMPickerView
//
//  Created by AndyMu on 2017/9/9.
//  Copyright © 2017年 AndyMu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AMPickerViewDelegate <NSObject>

@optional

/**
 pickerView滑动回调
 */
- (void)pickerView:(UIView *)amPickerView didSelectRow:(NSInteger)row;

/**
 pickerView当前选择元素 {index：选择位置  name：元素名称}
 */
- (void)pickerView:(UIView *)amPickerView didSelectedItem:(NSDictionary *)selectedItem;

@end


@interface AMPickerView : UIView

@property (nonatomic, strong) UIFont *textFont;               // default is nil (system font 20 plain)
@property (nonatomic, strong) UIFont *selectTextFont;         // default is nil (boldsystem font 25 plain)
@property (nonatomic, strong) UIColor *textColor;             // default is nil (text draws gray)
@property (nonatomic, strong) UIColor *selectTextColor;       // default is nil (text draws black)

/**
 PickerView 数据源
 */
@property (nonatomic, copy) NSArray *dataSource;

/**
 pickerView当前选择元素,也可以根据回调获取。{index：选择位置  name：元素名称}
 */
@property (nonatomic, strong, readonly) NSDictionary *selectedItem;

/**
 滑动到指定位置
 */
@property (nonatomic, assign, setter=scrollToIndex:) NSInteger scrollToIndex;

/**
 背景图
 */
@property (nonatomic, strong) UIImage *backgroundImage;

/**
 设置左侧点击按钮
 */
@property (nonatomic, strong) UIButton *leftButton;

/**
 设置右侧点击按钮
 */
@property (nonatomic, strong) UIButton *rightButton;

/**
 代理
 */
@property (nonatomic, weak) id <AMPickerViewDelegate> delegate;

/**
 刷新数据
 */
- (void)reloadComponent;

@end


