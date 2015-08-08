//
//  upperKeyboard.h
//  customkeyboard
//
//  Created by 성호 홍 on 2015. 1. 20..
//  Copyright (c) 2015년 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h> //버튼에 효과를 주기위해 추가함


@interface upperKeyboard : UIView
@property (weak, nonatomic) IBOutlet UIButton *upperShiftKey;
@property (weak, nonatomic) IBOutlet UIButton *upperDeleteKey;
@property (weak, nonatomic) IBOutlet UIButton *upperNumberKey;
@property (weak, nonatomic) IBOutlet UIButton *upperGlobeKey;
@property (weak, nonatomic) IBOutlet UIButton *upperSpaceKey;
@property (weak, nonatomic) IBOutlet UIButton *upperReturnKey;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *upperKeysArray;

@end
