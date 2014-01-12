//
//  MBViewController.h
//  Mr Brightside
//
//  Created by Dylan Bourgeois on 18/12/2013.
//  Copyright (c) 2013 Dylan Bourgeois. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MBViewController : UIViewController <AVAudioPlayerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *songDuration;
@property (strong, nonatomic) IBOutlet UIButton *playPauseButton;
@property (strong, nonatomic) IBOutlet UILabel *songArtist;
@property (strong, nonatomic) IBOutlet UILabel *songTitle;
@property (strong, nonatomic) NSArray *tracks;
@property (strong, nonatomic) AVAudioPlayer* player;

@end
