//
//  hangulDelete.m
//  customkeyboard
//
//  Created by 성호 홍 on 2015. 2. 16..
//  Copyright (c) 2015년 dev. All rights reserved.
//

#import "hangulDelete.h"
#import "hangulInput.h"
#import "KeyboardViewController.h"

@implementation hangulDelete

@synthesize chosungList;
@synthesize jungsungList;
@synthesize jongsungList;
@synthesize doubelVowelList;
@synthesize doubleConsonantList;
@synthesize splitedHangul;


-(id)init{
    if(self =[super init]){
        chosungList = [NSArray arrayWithObjects:@"ㄱ",@"ㄲ",@"ㄴ",@"ㄷ",@"ㄸ",@"ㄹ",@"ㅁ",@"ㅂ",@"ㅃ",@"ㅅ",@"ㅆ",@"ㅇ",@"ㅈ",@"ㅉ",@"ㅊ",@"ㅋ",@"ㅌ",@"ㅍ",@"ㅎ",nil];
        jungsungList = [NSArray arrayWithObjects:@"ㅏ",@"ㅐ",@"ㅑ",@"ㅒ",@"ㅓ",@"ㅔ",@"ㅕ",@"ㅖ",@"ㅗ",@"ㅘ",@"ㅙ",@"ㅚ",@"ㅛ",@"ㅜ",@"ㅝ",@"ㅞ",@"ㅟ",@"ㅠ",@"ㅡ",@"ㅢ",@"ㅣ", nil];
        jongsungList =[NSArray arrayWithObjects:@" ",@"ㄱ", @"ㄲ", @"ㄳ", @"ㄴ", @"ㄵ", @"ㄶ", @"ㄷ", @"ㄹ", @"ㄺ", @"ㄻ", @"ㄼ", @"ㄽ", @"ㄾ", @"ㄿ", @"ㅀ", @"ㅁ", @"ㅂ", @"ㅄ", @"ㅅ", @"ㅆ", @"ㅇ", @"ㅈ", @"ㅊ", @"ㅋ", @"ㅌ", @"ㅍ", @"ㅎ", nil];
        
        doubelVowelList =[NSArray arrayWithObjects: @"ㅘ",@"ㅙ",@"ㅚ",@"ㅝ",@"ㅞ",@"ㅟ",@"ㅢ",nil];
        doubleConsonantList=[NSArray arrayWithObjects: @"ㄳ",@"ㄵ",@"ㄶ",@"ㄺ",@"ㄻ",@"ㄼ",@"ㄽ",@"ㄾ",@"ㄿ",@"ㅀ",@"ㅄ",nil];
        
        
        splitedHangul = [[NSMutableArray alloc]initWithCapacity:5];
    }
    return self;
}

-(int)returnDeltedString:(NSString*)passedString{ //주요기능
    
    NSString *lastString = [self returnLastString:passedString]; //마지막 글자 받음
    
    
    if([self koreanChecker:lastString]==1){ //한글일 경우
        [self initSplitedHangul];
        return [self lengthOfString:lastString];
        //return [self inputSplitedHanugl:lastString];
    }
    else{
        return 0;
    }
    return 0; //의미없음 나중에 지워주기

}


-(int)lengthOfString:(NSString*)lastString{
    
    
    
    unichar chosungIndex = [self stringToUnicahr:lastString]%20;
    unichar jungsungIndex = (([self stringToUnicahr:lastString]-chosungIndex)/28)%21;
    unichar jongsungIndex = ((([self stringToUnicahr:lastString]-chosungIndex)/28)-jungsungIndex)/21;
    
    NSString *chosungString = [chosungList objectAtIndex:chosungIndex];
    NSString *junsungString = [jungsungList objectAtIndex:jungsungIndex];
    NSString *jongsungString = [jongsungList objectAtIndex:jongsungIndex];
    
    
    if(jongsungIndex){
        if([doubelVowelList indexOfObject:junsungString]){
            if([doubleConsonantList indexOfObject:jongsungString]){
                return 4;
            }else{
                return 3;
            }
        }else{
            if([doubleConsonantList indexOfObject:jongsungString]){
                return 3;
            }else{
                return 2;
            }
        }
    }else{
        if([doubelVowelList indexOfObject:junsungString]){
            return 2;
        }else{
            return 1;
        }
    }
    
}



-(int)inputSplitedHanugl:(NSString*)tempLastString{
    
    int countHangulIndex;
    
    unichar convertedUniChar;
    [tempLastString getCharacters:&convertedUniChar];
    
    
    
    unichar chosungUni = convertedUniChar%20;
    unichar jungsungUni = ((convertedUniChar-chosungUni)/28)%21;
    unichar jongsungUni = (((convertedUniChar-chosungUni)/28)-jungsungUni)/21;
    
    
    
    NSString* chosung = [chosungList objectAtIndex:chosungUni];
    NSString* jungsung = [jungsungList objectAtIndex:jungsungUni];
    NSString* jongsung = [jongsungList objectAtIndex:jongsungUni];
    
    
    
    [splitedHangul replaceObjectAtIndex:0 withObject:chosung];
    [splitedHangul replaceObjectAtIndex:1 withObject:jungsung];
    [splitedHangul replaceObjectAtIndex:2 withObject:jongsung];

    
    
    countHangulIndex = 0;
    
    for(int i ; i < [jungsungList count] ; i++){
        if([jungsung isEqualToString:[jungsungList objectAtIndex:i]]){
            countHangulIndex = 1;

        }
    }

    
    if([jungsung isEqualToString:@"ㅘ"]){
        [splitedHangul replaceObjectAtIndex:1 withObject:@"ㅗ"];
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㅏ"];
        countHangulIndex = 2;
    }else if([jungsung isEqualToString:@"ㅙ"]){
        [splitedHangul replaceObjectAtIndex:1 withObject:@"ㅗ"];
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㅐ"];
        countHangulIndex = 2;
    }else if([jungsung isEqualToString:@"ㅚ"]){
        [splitedHangul replaceObjectAtIndex:1 withObject:@"ㅗ"];
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㅣ"];
        countHangulIndex = 2;
    }else if([jungsung isEqualToString:@"ㅝ"]){
        [splitedHangul replaceObjectAtIndex:1 withObject:@"ㅜ"];
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㅓ"];
        countHangulIndex = 2;
    }else if([jungsung isEqualToString:@"ㅞ"]){
        [splitedHangul replaceObjectAtIndex:1 withObject:@"ㅜ"];
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㅔ"];
        countHangulIndex = 2;
    }else if([jungsung isEqualToString:@"ㅟ"]){
        [splitedHangul replaceObjectAtIndex:1 withObject:@"ㅜ"];
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㅣ"];
        countHangulIndex = 2;
    }else if([jungsung isEqualToString:@"ㅢ"]){
        [splitedHangul replaceObjectAtIndex:1 withObject:@"ㅡ"];
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㅣ"];
        countHangulIndex = 2;
    }else{
        [splitedHangul replaceObjectAtIndex:1 withObject:jungsung];
        
        
    }
    
    
    [splitedHangul replaceObjectAtIndex:3 withObject:jongsung];
    
    if(countHangulIndex == 1){
        if([jongsung isEqualToString:@"ㄳ"]){
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㄱ"];
        [splitedHangul replaceObjectAtIndex:3 withObject:@"ㅅ"];
            countHangulIndex = 3;
        }else if([jongsung isEqualToString:@"ㄵ"]){
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㄴ"];
        [splitedHangul replaceObjectAtIndex:3 withObject:@"ㅈ"];
            countHangulIndex = 3;
        }else if([jongsung isEqualToString:@"ㄶ"]){
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㄴ"];
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㅎ"];
            countHangulIndex = 3;
        }else if([jongsung isEqualToString:@"ㄺ"]){
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㄹ"];
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㄱ"];
            countHangulIndex = 3;
        }else if([jongsung isEqualToString:@"ㄻ"]){
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㄹ"];
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㅁ"];
            countHangulIndex = 3;
        }else if([jongsung isEqualToString:@"ㄼ"]){
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㄹ"];
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㅂ"];
            countHangulIndex = 3;
        }else if([jongsung isEqualToString:@"ㄽ"]){
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㄹ"];
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㅅ"];
            countHangulIndex = 3;
        }else if([jongsung isEqualToString:@"ㄾ"]){
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㄹ"];
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㅌ"];
            countHangulIndex = 3;
        }else if([jongsung isEqualToString:@"ㄿ"]){
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㄹ"];
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㅍ"];
            countHangulIndex = 3;
        }else if([jongsung isEqualToString:@"ㅀ"]){
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㄹ"];
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㅎ"];
            countHangulIndex = 3;
        }else if([jongsung isEqualToString:@"ㅄ"]){
        [splitedHangul replaceObjectAtIndex:2 withObject:@"ㅂ"];
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㅅ"];
            countHangulIndex = 3;
        }else{
            countHangulIndex = 2;
        }
    }else if(countHangulIndex ==2){
        if([jongsung isEqualToString:@"ㄳ"]){
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㄱ"];
            [splitedHangul replaceObjectAtIndex:4 withObject:@"ㅅ"];
            countHangulIndex = 4;
        }else if([jongsung isEqualToString:@"ㄵ"]){
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㄴ"];
            [splitedHangul replaceObjectAtIndex:4 withObject:@"ㅈ"];
            countHangulIndex = 4;
        }else if([jongsung isEqualToString:@"ㄶ"]){
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㄴ"];
            [splitedHangul replaceObjectAtIndex:4 withObject:@"ㅎ"];
            countHangulIndex = 4;
        }else if([jongsung isEqualToString:@"ㄺ"]){
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㄹ"];
            [splitedHangul replaceObjectAtIndex:4 withObject:@"ㄱ"];
            countHangulIndex = 4;
        }else if([jongsung isEqualToString:@"ㄻ"]){
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㄹ"];
            [splitedHangul replaceObjectAtIndex:4 withObject:@"ㅁ"];
            countHangulIndex = 4;
        }else if([jongsung isEqualToString:@"ㄼ"]){
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㄹ"];
            [splitedHangul replaceObjectAtIndex:4 withObject:@"ㅂ"];
            countHangulIndex = 4;
        }else if([jongsung isEqualToString:@"ㄽ"]){
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㄹ"];
            [splitedHangul replaceObjectAtIndex:4 withObject:@"ㅅ"];
            countHangulIndex = 4;
        }else if([jongsung isEqualToString:@"ㄾ"]){
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㄹ"];
            [splitedHangul replaceObjectAtIndex:4 withObject:@"ㅌ"];
            countHangulIndex = 4;
        }else if([jongsung isEqualToString:@"ㄿ"]){
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㄹ"];
            [splitedHangul replaceObjectAtIndex:4 withObject:@"ㅍ"];
            countHangulIndex = 4;
        }else if([jongsung isEqualToString:@"ㅀ"]){
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㄹ"];
            [splitedHangul replaceObjectAtIndex:4 withObject:@"ㅎ"];
            countHangulIndex = 4;
        }else if([jongsung isEqualToString:@"ㅄ"]){
            [splitedHangul replaceObjectAtIndex:3 withObject:@"ㅂ"];
            [splitedHangul replaceObjectAtIndex:4 withObject:@"ㅅ"];
            countHangulIndex = 4;
        }else{
            countHangulIndex = 3;
        }
    }
    
    
    hangulInput *hangulInputTool = [[hangulInput alloc]init];
    
    if(countHangulIndex==1||countHangulIndex==2){
    NSString* tempDoubelVowel = [hangulInputTool doubleVowelChecker:[splitedHangul objectAtIndex:1] :[splitedHangul objectAtIndex:2]];
    if(tempDoubelVowel>0){
        return [hangulInputTool combinedoubleVowelUnicode:[splitedHangul objectAtIndex:0] :[splitedHangul objectAtIndex:1]];
    }
    else{
        return [splitedHangul objectAtIndex:0];
    }
    }else if(countHangulIndex==3 || countHangulIndex==4){
        NSString* tempDoubelVowel = [hangulInputTool doubleVowelChecker:[splitedHangul objectAtIndex:1] :[splitedHangul objectAtIndex:2]];
        if(tempDoubelVowel>0){
            NSString *tempDoubleConsonant = [hangulInputTool doubleConsonantChecker:[splitedHangul objectAtIndex:3]:[splitedHangul objectAtIndex:4]];
            if(tempDoubleConsonant>0){
                return [hangulInputTool combineUnicode:[splitedHangul objectAtIndex:0] :tempDoubelVowel :[splitedHangul objectAtIndex:3]];
            }else{
                return [hangulInputTool combineUnicode:[splitedHangul objectAtIndex:0] :tempDoubelVowel];
            }
        }else{
            NSString *tempDoubleConsonant = [hangulInputTool doubleConsonantChecker:[splitedHangul objectAtIndex:2] :[splitedHangul objectAtIndex:3]];
            if(tempDoubleConsonant>0){
                [hangulInputTool combineUnicode:[splitedHangul objectAtIndex:0] :[splitedHangul objectAtIndex:1] :[splitedHangul objectAtIndex:2]];
            }else{
                [hangulInputTool combineUnicode:[splitedHangul objectAtIndex:0] :[splitedHangul objectAtIndex:1]];
            }
        }
    }
    
    return countHangulIndex;

}





-(NSString*)returnLastString:(NSString*)passedFullString{ //string에서 마지막 글자 보내주기
    
    NSRange areaStr;
    areaStr.location = [passedFullString length]-1;
    areaStr.length = 1 ;
    NSString *lastString = [passedFullString substringWithRange:areaStr];
    return lastString;
}

-(void)initSplitedHangul{
    //NSArray *emptyArray = [NSArray arrayWithObjects:@"",@"",@"",@"",@"", nil]; //array에 빈칸 넣어주기 (5개)
    //[splitedHangul addObjectsFromArray:emptyArray];
    splitedHangul = [[NSMutableArray alloc]initWithCapacity:5];

}

-(int)koreanChecker:(NSString*)passedString{
    
    unichar koreanCheckerConvUniChar;
    [passedString getCharacters:&koreanCheckerConvUniChar];
    if((koreanCheckerConvUniChar>44032)&&(koreanCheckerConvUniChar<55203)){
        return 1;
    }
    else{
        return 0;
    }
}

-(NSString*)unicharToString:(unichar)passedUnichar{
    NSString* convertedString = [NSString stringWithFormat:@"%C",passedUnichar];
    return convertedString;
}

-(unichar)stringToUnicahr:(NSString*)passedString{
    unichar tempUniChar;
    [passedString getCharacters:&tempUniChar];
    return tempUniChar;
}

@end
