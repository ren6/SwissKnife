//
//  FirstViewController.m
//  SwissKnife2
//
//  Created by renat on 05.11.13.
//  Copyright (c) 2013 renat. All rights reserved.
//

#import "FirstViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface FirstViewController ()
@property (nonatomic, strong) IBOutlet UIToolbar *toolbar;
@property (nonatomic, strong) IBOutlet UILabel *artistLabel;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *progressLabel;
@property (nonatomic, strong) IBOutlet UILabel *durationLabel;
@property (nonatomic, strong) IBOutlet UISlider *slider;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) NSTimer *timer;

-(IBAction) sliderChanged;

@end

@implementation FirstViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   NSURL *url = [[NSBundle mainBundle] URLForResource:@"1" withExtension:@"mp3"];
    
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player prepareToPlay];
    self.slider.maximumValue = self.player.duration;
    [self updateToolbarState];
    self.durationLabel.text =[self timeFormatFromSeconds:self.player.duration];
    
    AVAsset *asset = [AVAsset assetWithURL:url];
    NSArray *titles = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyTitle keySpace:AVMetadataKeySpaceCommon];
    NSArray *artists = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyArtist keySpace:AVMetadataKeySpaceCommon];
    
    if (titles.count>0){
        AVMetadataItem *item = [titles firstObject];
        self.titleLabel.text = (NSString*)item.value;
    }
    
    if (artists.count>0){
        AVMetadataItem *item  = [artists firstObject];
        self.artistLabel.text = (NSString*)item.value;
    }
    
    NSArray *artwork = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyArtwork keySpace:AVMetadataKeySpaceCommon];
    
    if (artwork.count>0){
        AVMetadataItem *item = [artwork firstObject];
        NSDictionary *dict = (NSDictionary *)item.value;
        NSData *imageData = [dict objectForKey:@"data"];
        self.imageView.image = [UIImage imageWithData:imageData];
    }
}

-(void) updateToolbarState{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.toolbar.items];
    UIBarButtonItem *item = nil;
    
    if (self.player.isPlaying){
        item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(playOrPauseTapped)];
    } else {
        item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(playOrPauseTapped)];
    }
    [array replaceObjectAtIndex:1 withObject:item];
    self.toolbar.items = array;
}

-(void) playOrPauseTapped{
    if (self.player.isPlaying){
        [self.player pause];
        [self.timer invalidate];
        self.timer = nil;
    } else {
        [self.player play];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    }
    [self updateToolbarState];
}

-(NSString*) timeFormatFromSeconds:(int) aSeconds{
    //   00:00
    int minutes = aSeconds/60;
    int seconds = aSeconds - minutes*60;
    
    NSString *minutesString = [NSString stringWithFormat:@"%@%i",
                               minutes>9?@"":@"0",minutes];
    NSString *secondsString = [NSString stringWithFormat:@"%@%i",
                               seconds>9?@"":@"0",seconds];
    
    return [NSString stringWithFormat:@"%@:%@",minutesString, secondsString];
}
-(void) updateProgress{
    
    if (self.slider.state==UIControlStateNormal)
        self.slider.value = self.player.currentTime;
    
    self.progressLabel.text = [self timeFormatFromSeconds:self.player.currentTime];
}


-(void) sliderChanged{
    self.player.currentTime = self.slider.value;
}








@end
