//
//  KeyboardViewController.m
//  MyKeyboard
//
//  Created by dev on 2015. 1. 20..
//  Copyright (c) 2015년 dev. All rights reserved.
//

#import "KeyboardViewController.h"
#import "Keyboard.h"
#import "upperKeyboard.h"
#import "numberKeyboard.h"
#import "hangulInput.h"
#import "hangulDelete.h"

@interface KeyboardViewController ()
@property (strong, nonatomic) Keyboard *keyboard;
@property (strong, nonatomic) upperKeyboard *upperkeyboard;
@property (strong, nonatomic) numberKeyboard *numberkeyboard;



@end

@implementation KeyboardViewController

@synthesize lastKey;
@synthesize savedKey;
@synthesize hangulPointer;
@synthesize savedKeyForDelete;
@synthesize currentString;
@synthesize inputCount;

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //한글 포인터 ( 초,중,종성 위치 알려주는 것) 초기화
    //한글 포인터 규칙 : 의미없음 = 0, 초성 = 1, 중성 = 2, 종성 = 3
    hangulPointer = 0;
    
    //array 초기화
    self.savedKey = [[NSMutableArray alloc] init];
    [self initSavedKey];
    
    self.savedKeyForDelete = [[NSMutableArray alloc] init];
    
    
    //키보드들 초기화
    self.keyboard = [[[NSBundle mainBundle] loadNibNamed:@"Keyboard" owner:nil options: nil] objectAtIndex:0];
    self.upperkeyboard = [[[NSBundle mainBundle] loadNibNamed:@"upperKeyboard" owner:nil options: nil] objectAtIndex:0];
    self.numberkeyboard = [[[NSBundle mainBundle] loadNibNamed:@"numberKeyboard" owner:nil options: nil] objectAtIndex:0];
    
    self.inputView = self.keyboard; //첫번째화면
    [self addGesturesToKeyboard]; //키보드 입력 받아줌
    
    // Perform custom UI setup here
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    }
#pragma mark Keyboards
-(void)addGesturesToKeyboard{
    [self.keyboard.deleteKey addTarget:self action:@selector(pressDeleteKey) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.spaceKey addTarget:self action:@selector(pressSpaceKey) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.returnKey addTarget:self action:@selector(pressReturnKey) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.shiftKey addTarget:self action:@selector(pressShiftKey) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.numberKey addTarget:self action:@selector(pressNumberKey) forControlEvents:UIControlEventTouchUpInside];
//change to next keyboard
    [self.keyboard.globeKey addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    for (UIButton *key in self.keyboard.keysArray) {
        NSString *tempCurrentString = self.textDocumentProxy.documentContextBeforeInput; //커서 이전거 확인
        
        
        [key addTarget:self action:@selector(pressKey:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    //두번째 키보드
    [self.upperkeyboard.upperShiftKey addTarget:self action:@selector(upperPressShiftKey) forControlEvents:UIControlEventTouchUpInside];
    [self.upperkeyboard.upperDeleteKey addTarget:self action:@selector(pressDeleteKey) forControlEvents:UIControlEventTouchUpInside];
    [self.upperkeyboard.upperSpaceKey addTarget:self action:@selector(pressSpaceKey) forControlEvents:UIControlEventTouchUpInside];
    [self.upperkeyboard.upperReturnKey addTarget:self action:@selector(pressReturnKey) forControlEvents:UIControlEventTouchUpInside];
    [self.upperkeyboard.upperNumberKey addTarget:self action:@selector(pressNumberKey) forControlEvents:UIControlEventTouchUpInside];
    [self.upperkeyboard.upperGlobeKey addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    for (UIButton *upperKey in self.upperkeyboard.upperKeysArray){
        [upperKey addTarget:self action:@selector(pressKey:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //세번째 키보드
    [self.numberkeyboard.numberDeleteKey addTarget:self action:@selector(pressDeleteKey) forControlEvents:UIControlEventTouchUpInside];
    [self.numberkeyboard.numberSpaceKey addTarget:self action:@selector(pressSpaceKey) forControlEvents:UIControlEventTouchUpInside];
    [self.numberkeyboard.numberReturnKey addTarget:self action:@selector(pressReturnKey) forControlEvents:UIControlEventTouchUpInside];
    [self.numberkeyboard.numberGlobeKey addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    [self.numberkeyboard.numberKoreanKey addTarget:self action:@selector(pressKoreanKey) forControlEvents:UIControlEventTouchUpInside];
    for(UIButton *numberKey in self.numberkeyboard.numberKeysArray){
        [numberKey addTarget:self action:@selector(pressKey:) forControlEvents:UIControlEventTouchUpInside];

    }
   
   
}
//첫번째 키보드
-(void)pressDeleteKey{ //delete 기능을 수행
    [self initSavedKey];

    hangulPointer = 0;
//    for(int n = 0 ; n < 40 ; n++){
//        [savedKey replaceObjectAtIndex:n withObject:[savedKey objectAtIndex:(n+1)]]; //한칸씩 앞으로 (제일 앞에꺼 제거 기능)
//    }
//    
    
    
    NSString *tempCurrentString = self.textDocumentProxy.documentContextBeforeInput; //커서 이전거 확인
    
    if([currentString isEqualToString:tempCurrentString]){ //커서 앞 단어 같을 떄만 자모 하나씩 지워줌
        
       // hangulDelete *hangulDeleteTool = [[hangulDelete alloc]init];
        
      //  NSString *lastString = [hangulDeleteTool returnDeltedString:tempCurrentString];
        
       // int num = [hangulDeleteTool returnDeltedString:tempCurrentString];
        
        //int tempInputCount = inputCount-1;
       /*
        for(int j = 0; j<[tempCurrentString length];j++){
        [self.textDocumentProxy deleteBackward];
        }
        
        NSInteger tempInputCount = inputCount;
        for ( int i = tempInputCount ; i > -1 ; i--){
            [self hangulAutoMachine:[savedKey objectAtIndex:i]];
            inputCount--;
        }
        //[self.textDocumentProxy deleteBackward];
       // [self.textDocumentProxy insertText:[hangulDeleteTool returnDeltedString:tempCurrentString]];
       // delete는 미완성...
        
        */
        [self.textDocumentProxy deleteBackward];

        
        
    }
    else{
        [self.textDocumentProxy deleteBackward];
        [self initSavedKey];
        hangulPointer = 0;
        inputCount = 0;

    }
    
    currentString = self.textDocumentProxy.documentContextBeforeInput;
    
    /*
     if(hangulPointer == 0){
        [self.textDocumentProxy deleteBackward];
    }else if(hangulPointer == 1){
        [self.textDocumentProxy deleteBackward];
        hangulPointer = 0;
    }else if(hangulPointer == 2){
        NSString *tempDoubleVowel = [hangulInput1 doubleVowelChecker:[savedKey objectAtIndex:1] :[savedKey objectAtIndex:0]];
        if(tempDoubleVowel){ //중성이 복모음인 경우
            hangulPointer = 2;
            [self hangulAutoMachine:[savedKey objectAtIndex:0]];
        }else{
            hangulPointer = 1;
            [self hangulAutoMachine:[savedKey objectAtIndex:0]];
        }
    }else if(hangulPointer ==3){
        NSString *tempDoubleConsonant = [hangulInput1 doubleConsonantChecker:[savedKey objectAtIndex:1] :[savedKey objectAtIndex:0]];
        if(tempDoubleConsonant){
            hangulPointer = 3;
            [self hangulAutoMachine:[savedKey objectAtIndex:0]];
        }else{
            hangulPointer = 2;
            [self hangulAutoMachine:[savedKey objectAtIndex:0]];
        }
        
    }
    */
    
    [self.keyboard.wordCenter setText:currentString];
}

-(void)pressSpaceKey{
    [self.textDocumentProxy insertText:@" "];
    hangulPointer = 0;
    [self initSavedKey];
    [self.keyboard.wordCenter setText:@" "];
}

-(void)pressReturnKey{
    [self.textDocumentProxy insertText:@"\n"];
    hangulPointer = 0;
    [self initSavedKey];
}

-(void)pressShiftKey{
    self.inputView = self.upperkeyboard;

}

-(void)pressNumberKey{
    self.inputView = self.numberkeyboard;
    [self initSavedKey];
}


-(void)pressKey:(UIButton *)key{ //한글 입력키 구현
    
    NSString *current = [key currentTitle];
    [self hangulAutoMachine:current];
}



//두번째 키보드
-(void)upperPressShiftKey{
    self.inputView = self.keyboard;
}

//세번째 키보드
-(void)pressKoreanKey{
    self.inputView = self.keyboard;
}


-(void)initSavedKey{
    NSArray *emptyArray = [NSArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil]; //array에 빈칸 넣어주기 (50개)
    [savedKey addObjectsFromArray:emptyArray];
    
}



-(void)hangulAutoMachine:(NSString*)current{

    
   
    
    
    hangulInput *hangulInput1 = [[hangulInput alloc]init];
    
    
    if([hangulInput1 consonantVowalChecker:current]==2){ //한글이 아닌 경우
        [self.textDocumentProxy insertText:current];
        
        
    }
    
    
    
    for(int n = 40; n> -1 ; n--){
        [savedKey replaceObjectAtIndex:(n+1) withObject:[savedKey objectAtIndex:n]];
    }
    [savedKey replaceObjectAtIndex:0 withObject:current];
    
    
    //array한칸씩 밀어내기
    /*
     
     [savedKey replaceObjectAtIndex:6 withObject:[savedKey objectAtIndex:5]];
     [savedKey replaceObjectAtIndex:5 withObject:[savedKey objectAtIndex:4]];
     [savedKey replaceObjectAtIndex:4 withObject:[savedKey objectAtIndex:3]];
     [savedKey replaceObjectAtIndex:3 withObject:[savedKey objectAtIndex:2]];
     [savedKey replaceObjectAtIndex:2 withObject:[savedKey objectAtIndex:1]];
     [savedKey replaceObjectAtIndex:1 withObject:[savedKey objectAtIndex:0]];
     밑에 for문 원본
     */
    
    
    
    
    //pointer가 0인경우
    if(hangulPointer==0)
    {
        if([hangulInput1 consonantVowalChecker:current] == 0 ) //자음
        {
            [self.textDocumentProxy insertText:current];
            
            
            hangulPointer = 1;
        }
        
        else if([hangulInput1 consonantVowalChecker:current] == 1 ) //모음
        {
            [self.textDocumentProxy insertText:current];
            hangulPointer = 0;
        }
        
        
    }
    
    else if(hangulPointer==1)
    {
        if([hangulInput1 consonantVowalChecker:current] == 0) //자음
        {
            [self.textDocumentProxy insertText:current];
            hangulPointer = 1; //초성을 가리킴
        }
        else if([hangulInput1 consonantVowalChecker:current] == 1 ) //모음
        {
            [self.textDocumentProxy deleteBackward];
            NSString *output = [hangulInput1 combineUnicode:[savedKey objectAtIndex:1] :[savedKey objectAtIndex:0]];
            [self.textDocumentProxy insertText:output];
            hangulPointer = 2; //중성을 가리킴
            
        }
        
    }
    
    else if(hangulPointer ==2)
    {
        if([hangulInput1 consonantVowalChecker:current] == 0) //자음
        {
            NSString *tempDoubleVowel = [hangulInput1 doubleVowelChecker:[savedKey objectAtIndex:2] :[savedKey objectAtIndex:1]];
            if(tempDoubleVowel>0){//복모음
                [self.textDocumentProxy deleteBackward];
                NSString *output = [hangulInput1 combineUnicode:[savedKey objectAtIndex:3] :tempDoubleVowel :[savedKey objectAtIndex:0]];
                [self.textDocumentProxy insertText:output];
                hangulPointer = 3;
            }else{
                [self.textDocumentProxy deleteBackward];
                NSString *output = [hangulInput1 combineUnicode:[savedKey objectAtIndex:2]:[savedKey objectAtIndex:1] :[savedKey objectAtIndex:0]];
                [self.textDocumentProxy insertText:output];
                hangulPointer = 3;
            }
        }
        else if([hangulInput1 consonantVowalChecker:current] == 1) //모음
        {
            NSString *tempDoublVowelIndex = [hangulInput1 doubleVowelChecker:[savedKey objectAtIndex:1] :[savedKey objectAtIndex:0]] ;
            //복모음 체크, 0보다 큰 경우는 복모음!
            
            if( tempDoublVowelIndex > 0 )
            {
                [self.textDocumentProxy deleteBackward];
                NSString *output = [hangulInput1 combineUnicode:[savedKey objectAtIndex:2] : tempDoublVowelIndex];
                [self.textDocumentProxy insertText:output];
                hangulPointer = 2;
            }
            else
            {
                [self.textDocumentProxy insertText:current];
                hangulPointer = 0;
            }
        }
        
    }
    
    else if(hangulPointer == 3){
        if([hangulInput1 consonantVowalChecker:current] == 0)//자음
        {
            NSString *alreadyDoubleConsonant = [hangulInput1 doubleConsonantChecker:[savedKey objectAtIndex:2] :[savedKey objectAtIndex:1]]; //종성이 이미 복자음인 경우
            if(alreadyDoubleConsonant > 0){                                 //case0 ex) 갉+ㅅ
                [self.textDocumentProxy insertText:current];
                hangulPointer = 1;
            }
            
            else{ //종성이 복자음이 아닌 경우
                NSString *tempDoubleConsonant = [hangulInput1 doubleConsonantChecker:[savedKey objectAtIndex:1] :[savedKey objectAtIndex:0]];//종성과 자음이 만나서 복자음이 가능 체크
                NSString *tempDoubleVowel = [hangulInput1 doubleVowelChecker:[savedKey objectAtIndex:3] :[savedKey objectAtIndex:2]];
                //중성이 복모음인지 체크
                
                if( tempDoubleConsonant > 0){ //복자음 가능
                    if(tempDoubleVowel >0 ){ // 중성이 복모음o
                        [self.textDocumentProxy deleteBackward];
                        NSString *output = [hangulInput1 combineUnicode:[savedKey objectAtIndex:4]:tempDoubleVowel:tempDoubleConsonant];
                        [self.textDocumentProxy insertText:output];         //case1 ex) 괄+ㄱ
                        hangulPointer = 3;
                        
                    }else{ //중성이 복모음x
                        [self.textDocumentProxy deleteBackward];
                        NSString *output = [hangulInput1 combineUnicode:[savedKey objectAtIndex:3]:[savedKey objectAtIndex:2]:tempDoubleConsonant];
                        [self.textDocumentProxy insertText:output];         //case2 ex) 갈+ㄱ
                        hangulPointer = 3;
                    }
                }
                else{ //복자음 불가능
                    [self.textDocumentProxy insertText:current]; //case3 ex) 괄+ㄹ
                    hangulPointer = 1;                                      //case4 ex) 괄+ㄹ
                    //둘다 같은 결과를 내기에 분리하지 않았음
                }
                
            }
            
        }else if([hangulInput1 consonantVowalChecker:current]==1){//모음
            NSString *tempDoubleConsonant = [hangulInput1 doubleConsonantChecker:[savedKey objectAtIndex:2] :[savedKey objectAtIndex:1]];
            
            if(tempDoubleConsonant > 0){//종성이 복자음인 경우
                NSString *tempDoubleVowel = [hangulInput1 doubleVowelChecker:[savedKey objectAtIndex:4] :[savedKey objectAtIndex:3]];
                //중성 복모음 체크
                
                if(tempDoubleVowel>0){//중성이 복모음o
                    [self.textDocumentProxy deleteBackward];
                    NSString *output = [hangulInput1 combineUnicode:[savedKey objectAtIndex:5]:tempDoubleVowel:[savedKey objectAtIndex:2]];
                    NSString *secondOutput = [hangulInput1 combineUnicode:[savedKey objectAtIndex:1] :[savedKey objectAtIndex:0]];
                    [self.textDocumentProxy insertText:output];             //case7 괅+ㅏ
                    [self.textDocumentProxy insertText:secondOutput];
                    hangulPointer = 2;
                    
                }
                else{
                    [self.textDocumentProxy deleteBackward];
                    NSString *output = [hangulInput1 combineUnicode:[savedKey objectAtIndex:4]:[savedKey objectAtIndex:3]:[savedKey objectAtIndex:2]];
                    NSString *secondOutput = [hangulInput1 combineUnicode:[savedKey objectAtIndex:1] :[savedKey objectAtIndex:0]];
                    [self.textDocumentProxy insertText:output];             //case8 갉+ㅏ
                    [self.textDocumentProxy insertText:secondOutput];
                    hangulPointer = 2;
                    
                }
            }
            
            
            else{//종성이 복자음이 아닌경우
                NSString *tempDoubleVowel = [hangulInput1 doubleVowelChecker:[savedKey objectAtIndex:3] :[savedKey objectAtIndex:2]];
                //중성 복모음 체크
                
                if(tempDoubleVowel>0){//중성 복모음 o
                    [self.textDocumentProxy deleteBackward];
                    NSString *output = [hangulInput1 combineUnicode:[savedKey objectAtIndex:4] :tempDoubleVowel];
                    NSString *secondOutput = [hangulInput1 combineUnicode:[savedKey objectAtIndex:1] :[savedKey objectAtIndex:0]];
                    
                    [self.textDocumentProxy insertText:output];             //case5 ex) 괄+ㅏ
                    [self.textDocumentProxy insertText:secondOutput];
                    hangulPointer = 2;
                    
                }
                else{//중성 복모음 x
                    [self.textDocumentProxy deleteBackward];
                    
                    NSString *firstOutput = [hangulInput1 combineUnicode:[savedKey objectAtIndex:3]:[savedKey objectAtIndex:2]];
                    NSString *secondOutput = [hangulInput1 combineUnicode:[savedKey objectAtIndex:1] :[savedKey objectAtIndex:0]];
                    [self.textDocumentProxy insertText:firstOutput];
                    [self.textDocumentProxy insertText:secondOutput];       //case6 ex) 갈+ㅏ
                    hangulPointer = 2;
                }
            }
        }
    }
    currentString = self.textDocumentProxy.documentContextBeforeInput;
    [self.keyboard.wordCenter setText:currentString];
    
}

/*
 처음 알고리즘 구상할 때
 추억을 위해 남겨둠 :)
 
 if([[savedKey objectAtIndex:1] isEqualToString:@"ㄱ"] && [current isEqualToString:@"ㅏ"])
 {
 [self.textDocumentProxy deleteBackward];
 [self.textDocumentProxy insertText:@"가"];
 }
 else
 {
 [self.textDocumentProxy insertText:[key currentTitle]];
 }
 */

@end
