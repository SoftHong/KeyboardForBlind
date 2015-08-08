//
//  hangulInput.m
//  customkeyboard
//
//  Created by 성호 홍 on 2015. 1. 24..
//  Copyright (c) 2015년 dev. All rights reserved.
//
//  유니코드 한글 조합법 : 초성*588 + 중성*28 + 종성

#import "hangulInput.h"

@implementation hangulInput

@synthesize chosungList;
@synthesize jungsungList;
@synthesize jongsungList;

-(id)init{
    if(self =[super init]){
        chosungList = [NSArray arrayWithObjects:@"ㄱ",@"ㄲ",@"ㄴ",@"ㄷ",@"ㄸ",@"ㄹ",@"ㅁ",@"ㅂ",@"ㅃ",@"ㅅ",@"ㅆ",@"ㅇ",@"ㅈ",@"ㅉ",@"ㅊ",@"ㅋ",@"ㅌ",@"ㅍ",@"ㅎ",nil];
        jungsungList = [NSArray arrayWithObjects:@"ㅏ",@"ㅐ",@"ㅑ",@"ㅒ",@"ㅓ",@"ㅔ",@"ㅕ",@"ㅖ",@"ㅗ",@"ㅘ",@"ㅙ",@"ㅚ",@"ㅛ",@"ㅜ",@"ㅝ",@"ㅞ",@"ㅟ",@"ㅠ",@"ㅡ",@"ㅢ",@"ㅣ", nil];
        jongsungList =[NSArray arrayWithObjects:@" ",@"ㄱ", @"ㄲ", @"ㄳ", @"ㄴ", @"ㄵ", @"ㄶ", @"ㄷ", @"ㄹ", @"ㄺ", @"ㄻ", @"ㄼ", @"ㄽ", @"ㄾ", @"ㄿ", @"ㅀ", @"ㅁ", @"ㅂ", @"ㅄ", @"ㅅ", @"ㅆ", @"ㅇ", @"ㅈ", @"ㅊ", @"ㅋ", @"ㅌ", @"ㅍ", @"ㅎ", nil];
        
    }
    return self;
}

- (NSString*)combineUnicode:(NSString*) chosung: (NSString*) junsung{
    
    unichar tempUniNum = 44032 + [chosungList indexOfObject:chosung]*588 + [jungsungList indexOfObject:junsung]*28;
    
    //NSString *result = [NSString stringWithFormat:@"%C",tempUniNum]; //밑에줄이랑 같은 기능, 나중에 응용해 보자
    
    NSString *result = [NSString stringWithCharacters:&tempUniNum length:(1)];
    
    return result;
}


- (NSString*)combineUnicode:(NSString*) chosung: (NSString*) junsung: (NSString*) jongsung{
    
    unichar tempUniNum = 44032 + [chosungList indexOfObject:chosung]*588 + [jungsungList indexOfObject:junsung]*28 +[jongsungList indexOfObject:jongsung]*1 ;
    
    NSString *result = [NSString stringWithCharacters:&tempUniNum length:(1)];
    
    return result;
}



- (NSString*)combinedoubleVowelUnicode:(NSString*) chosung: (NSString*) jungsung{
    
    unichar tempUniNum = 44032 + [chosungList indexOfObject:chosung]*588 + [jungsungList indexOfObject:jungsung]*28;
    
    NSString *result = [NSString stringWithCharacters:&tempUniNum length:(1)];
    
    return result;
    
    
}



//자모음 체크
- (int)consonantVowalChecker:(NSString*)passedKey{
    
    /*(설명)
     자음과 모음을 구분해주는 메소드
     자음이면 0, 모음이면 1, 한글이 아니면 2를 리턴해준다*/
    
    for(int i = 0 ; i < [chosungList count]; i++){
        if([passedKey isEqualToString:[chosungList objectAtIndex:i]]){
            return 0;
        }
    }
    
    for(int i = 0; i < [jungsungList count]; i++){
        if([passedKey isEqualToString:[jungsungList objectAtIndex:i]]){
            return 1;
        }
    }
    
    return 2;
}


//복모음 체크
-(NSString*)doubleVowelChecker:(NSString*)beforeVowel :(NSString*)afterVowel{
    
    if([beforeVowel isEqualToString:@"ㅗ"]){
        if([afterVowel isEqualToString:@"ㅏ"]){
            return @"ㅘ";
        }else if([afterVowel isEqualToString:@"ㅐ"]){
            return @"ㅙ";
        }else if([afterVowel isEqualToString:@"ㅣ"]){
            return @"ㅚ";
        }else{
            return 0;
        }
    }else if([beforeVowel isEqualToString:@"ㅜ"]){
        if([afterVowel isEqualToString:@"ㅓ"]){
            return @"ㅝ";
        }else if([afterVowel isEqualToString:@"ㅔ"]){
            return @"ㅞ";
        }else if([afterVowel isEqualToString:@"ㅣ"]){
            return @"ㅟ";
        }else{
            return 0;
        }
    }else if([beforeVowel isEqualToString:@"ㅡ"]){
        if([afterVowel isEqualToString:@"ㅣ"]){
            return @"ㅢ";
        }else{
            return 0;
        }
    }else{
        return 0;
    }
}

//복자음 체크
-(NSString*)doubleConsonantChecker:(NSString*)beforeConsonant: (NSString*)afterConsonant{
    if([beforeConsonant isEqualToString:@"ㄱ"]){
        if([afterConsonant isEqualToString:@"ㅅ"]){
            return @"ㄳ";
        }else{
            return 0;
        }
    }else if([beforeConsonant isEqualToString:@"ㄴ"]){
        if([afterConsonant isEqualToString:@"ㅈ"]){
            return @"ㄵ";
        }else if([afterConsonant isEqualToString:@"ㅎ"]){
            return @"ㄶ";
        }else{
            return 0;
        }
    }else if([beforeConsonant isEqualToString:@"ㄹ"]){
        if([afterConsonant isEqualToString:@"ㄱ"]){
            return @"ㄺ";
        }else if([afterConsonant isEqualToString:@"ㅁ"]){
            return @"ㄻ";
        }else if([afterConsonant isEqualToString:@"ㅂ"]){
            return @"ㄼ";
        }else if([afterConsonant isEqualToString:@"ㅅ"]){
            return @"ㄽ";
        }else if([afterConsonant isEqualToString:@"ㅌ"]){
            return @"ㄾ";
        }else if([afterConsonant isEqualToString:@"ㅍ"]){
            return @"ㄿ";
        }else if([afterConsonant isEqualToString:@"ㅎ"]){
            return @"ㅀ";
        }else{
            return 0;
        }
    }else if([beforeConsonant isEqualToString:@"ㅂ"]){
        if([afterConsonant isEqualToString:@"ㅅ"]){
            return @"ㅄ";
        }else{
            return 0;
        }
    }else{
        return 0;
    }
}

@end