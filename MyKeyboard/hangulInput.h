//
//  hangulInput.h
//  customkeyboard
//
//  Created by 성호 홍 on 2015. 1. 24..
//  Copyright (c) 2015년 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hangulInput : NSObject

@property NSArray *chosungList;
@property NSArray *jungsungList;
@property NSArray *jongsungList;



- (int)consonantVowalChecker:(NSString*)passedKey;

- (NSString*)combineUnicode:(NSString*) chosung: (NSString*) junsung: (NSString*) jongsung;
- (NSString*)combineUnicode:(NSString*) chosung: (NSString*) junsung;

- (NSString*)combinedoubleVowelUnicode:(NSString*) chosung: (NSString*) jungsung;

- (NSString*)doubleVowelChecker:(NSString*)beforeVowel :(NSString*)afterVowel;
- (NSString*)doubleConsonantChecker:(NSString*)beforeConsonant: (NSString*)afterConsonant;


@end


