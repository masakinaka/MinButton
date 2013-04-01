//
//  MinButtonViewController.h
//  MinButton
//
//  Created by 中西 真樹 on 12/06/26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MinButtonViewController : UIViewController{
    NSDate* nowdate;
    AVAudioPlayer *player;
}
- (IBAction)startbuttonPushed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelfield;
@property (weak, nonatomic) IBOutlet UIButton *startbutton;

@end
