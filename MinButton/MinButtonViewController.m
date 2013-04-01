//
//  MinButtonViewController.m
//  MinButton
//
//  Created by 中西 真樹 on 12/06/26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MinButtonViewController.h"

@interface MinButtonViewController ()

@end

@implementation MinButtonViewController
@synthesize labelfield;
@synthesize startbutton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // set up start button
    UIImage *greenImage = [[UIImage imageNamed:@"green_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	UIImage *redImage = [[UIImage imageNamed:@"red_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	
	[startbutton setBackgroundImage:greenImage forState:UIControlStateNormal];
	[startbutton setBackgroundImage:redImage forState:UIControlStateSelected];
    
    
}

- (void)viewDidUnload
{
    [self setLabelfield:nil];
    [self setStartbutton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //縦画面のみ有効
    return (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown || interfaceOrientation == UIInterfaceOrientationPortrait);

//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//    } else {
//        return YES;
//    }
}

- (IBAction)startbuttonPushed:(id)sender {

    
    if (nowdate != nil) {
        // ボタンラベル
        [startbutton setTitle:@"スタート！" forState:UIControlStateNormal];

        // 何秒経過したか
        NSTimeInterval intervaldate;
        intervaldate = [nowdate timeIntervalSinceNow];
        NSLog(@"%f",intervaldate);
        
        // 秒を整数に
        NSString* resultTime = [NSString stringWithFormat:@"%.0f", -intervaldate];
        NSInteger i = [resultTime intValue];
        

        // プロパティリストから文字列取得
        NSString* path = [[NSBundle mainBundle] pathForResource:@"Message-List" ofType:@"plist"]; 
        NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSArray* arr_data = [dic objectForKey:@"Result label"];

        // 60secからの誤差
        i = i - 60;
        if (i < 0) {
            i= i * (-1);
        }
        
        // 誤差秒を文字列に
        resultTime = [NSString stringWithFormat:@"%d", i];

        // 文字列をプロパティリストからとるか
        if (i < [arr_data count]) {
            labelfield.text = [NSString stringWithFormat:@"%@ 誤差%@秒",[arr_data objectAtIndex:i],resultTime];
        }
        else {
            labelfield.text = [NSString stringWithFormat:@"全然ダメ"];
        }

        // 日時初期化
        nowdate = nil;

        startbutton.selected = NO;
        
        // 惜しい時は効果音
        if (i < 5) {
            // 効果音ファイル
            NSError *err;
            player = 
            [[AVAudioPlayer alloc] 
             initWithContentsOfURL:
             [NSURL fileURLWithPath: 
              [[NSBundle mainBundle] 
               pathForResource:@"track" 
               ofType:@"m4a" inDirectory:@"/"]]
             error:&err];
            
            [player play];
        }

    }else {
        // 現在日時取得
        nowdate = [NSDate date];
        NSLog(@"%@",nowdate);
        
        // ボタンラベル
        [startbutton setTitle:@"1分たったら押してね" forState:UIControlStateNormal];
        startbutton.selected = YES;
    //    [startbutton setBackgroundColor:[UIColor blueColor]];        
        labelfield.text = [NSString stringWithFormat:@"1分当てゲーム"];

        [player stop];

    }
}


@end
