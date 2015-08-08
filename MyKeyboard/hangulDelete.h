//
//  hangulDelete.h
//  customkeyboard
//
//  Created by 성호 홍 on 2015. 2. 16..
//  Copyright (c) 2015년 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hangulDelete : NSObject

@property NSArray *chosungList;
@property NSArray *jungsungList;
@property NSArray *jongsungList;
@property NSArray *doubleConsonantList;
@property NSArray *doubelVowelList;

@property NSMutableArray *splitedHangul;

-(int)returnDeltedString:(NSString*)passedString;
-(int)lengthOfString:(NSString*)lastString;
@end
