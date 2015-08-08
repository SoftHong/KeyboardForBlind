//
//  KeyboardViewController.h
//  MyKeyboard
//
//  Created by dev on 2015. 1. 20..
//  Copyright (c) 2015년 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h> //버튼에 효과를 주기위해 추가함


@interface KeyboardViewController : UIInputViewController

@property NSString *lastKey;//이거 안씀 나중에 지우기

@property NSString *currentString;
@property (nonatomic,strong) NSMutableArray *savedKey;
@property (nonatomic,strong) NSMutableArray *savedKeyForDelete;

@property NSInteger hangulPointer;
@property NSInteger inputCount;

@end
