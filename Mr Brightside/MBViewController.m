//
//  MBViewController.m
//  Mr Brightside
//
//  Created by Dylan Bourgeois on 18/12/2013.
//  Copyright (c) 2013 Dylan Bourgeois. All rights reserved.
//

#import "MBViewController.h"
#define API_KEY @"PFNVtb9DgmvdLwt43vK3f3zQai0bSLEmyz07A9cr7Do1xlIJ3D"
#define PAGES 1

@interface MBViewController () {
    BOOL hasPlayed;
}

@end

@implementation MBViewController
@synthesize tracks;
@synthesize player;

- (void)viewDidLoad
{
    hasPlayed=FALSE;
    [super viewDidLoad];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        NSError *error = nil;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.tumblr.com/v2/blog/quark-up.tumblr.com/posts?api_key=%@&limit=%d",API_KEY, PAGES]];
        NSString *json = [NSString stringWithContentsOfURL:url
                                                  encoding:NSUTF8StringEncoding
                                                     error:&error];
        
        if(!error) {
            NSData *jsonData = [json dataUsingEncoding:NSISOLatin1StringEncoding];
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                     options:kNilOptions
                                                                       error:&error];
            
            NSDictionary *result=[jsonDict objectForKey:@"response"];
            self.tracks=(NSArray*)[result objectForKey:@"posts"];
            
        }
    });
    
  

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)playPause:(id)sender {
    
    if(self.playPauseButton.isSelected) {
        
        [self.playPauseButton setImage:[UIImage imageNamed:@"icon-ios7-play.png"] forState:UIControlStateNormal];
        self.playPauseButton.selected=NO;
        
        if (player) {
            [player pause];
        }
    }
    
    else {
    [self.playPauseButton setImage:[UIImage imageNamed:@"icon-ios7-pause.png"] forState:UIControlStateNormal];
        self.playPauseButton.selected=YES;
        
        if (!hasPlayed) {
            NSURL *url;
            NSDictionary *track = [self.tracks objectAtIndex:0];
            url = [NSURL URLWithString:[track objectForKey:@"source_url"]];
            NSLog(@"%@", url);
           
            NSError *playerError;
            NSData *data = [NSData dataWithContentsOfURL:url];
            player = [[AVAudioPlayer alloc] initWithData:data error:&playerError];
            NSLog(@"playing");
            [player setDelegate:self];
            NSLog(@"playing1");
            [player prepareToPlay];
            NSLog(@"playing2");
            [player play];
            if (player.isPlaying) NSLog(@"playing");
            hasPlayed=TRUE;
        }
        
        else {
            if(player) [player play];
        }

    }
}

@end
