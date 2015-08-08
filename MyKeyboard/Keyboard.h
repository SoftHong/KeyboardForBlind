//
//  Keyboard.h
//  customkeyboard
//
//  Created by dev on 2015. 1. 20..
//  Copyright (c) 2015년 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h> //버튼에 효과를 주기위해 추가함

@interface Keyboard : UIView
@property (weak, nonatomic) IBOutlet UIButton *deleteKey;
@property (weak, nonatomic) IBOutlet UIButton *globeKey;
@property (weak, nonatomic) IBOutlet UIButton *spaceKey;
@property (weak, nonatomic) IBOutlet UIButton *returnKey;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *keysArray;
@property (weak, nonatomic) IBOutlet UIButton *shiftKey;
@property (weak, nonatomic) IBOutlet UIButton *numberKey;
@property (weak, nonatomic) IBOutlet UIButton *emptyKey;

@property (weak, nonatomic) IBOutlet UILabel *wordCenter;
@end
