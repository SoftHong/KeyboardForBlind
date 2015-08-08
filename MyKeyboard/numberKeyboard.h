//
//  numberKeyboard.h
//  customkeyboard
//
//  Created by dev on 2015. 1. 20..
//  Copyright (c) 2015년 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h> //버튼에 효과를 주기위해 추가함


@interface numberKeyboard : UIView

@property (weak, nonatomic) IBOutlet UIButton *numberShiftKey;
@property (weak, nonatomic) IBOutlet UIButton *numberDeleteKey;
@property (weak, nonatomic) IBOutlet UIButton *numberKoreanKey;
@property (weak, nonatomic) IBOutlet UIButton *numberGlobeKey;
@property (weak, nonatomic) IBOutlet UIButton *numberSpaceKey;
@property (weak, nonatomic) IBOutlet UIButton *numberReturnKey;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberKeysArray;

@end
