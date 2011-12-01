//
//  UISound.m
//
//  Created by Patrick Perini on 11/29/11.
//  Copyright (c) 2011 Patrick Perini. All rights reserved.
//

#import "UISound.h"

#pragma mark UISound Private Interface
//========================================================================//
void systemAudioCallback(SystemSoundID soundID, void *clientData);
//========================================================================//
#pragma mark UISound Public Implementation
//========================================================================//
@implementation UISound

@synthesize name;
@synthesize delegate;

- (id)initWithName: (NSString *)soundName
{
    self = [super init];
    if (self)
    {
        name = [soundName copy];
        
        NSString *path;
        for (NSString *ext in [UISound soundUnfilteredTypes])
        {
            path = [[NSBundle mainBundle] pathForResource: soundName
                                          ofType: ext];
            
            if ([[NSFileManager defaultManager] fileExistsAtPath: path])
            {
                NSURL *pathURL = [NSURL fileURLWithPath: path];
                
                AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef) pathURL, &audioEffect);
                AudioServicesAddSystemSoundCompletion(audioEffect,
                                                      NULL, 
                                                      NULL, 
                                                      systemAudioCallback, 
                                                      (__bridge_retained void *) self);
                
                return self;
            }
        }
    }
    
    return nil;
}

- (id)initWithContentsOfURL:(NSURL *)url
{
    self = [super init];
    if (self)
    {
        name = [url lastPathComponent];
        
        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef) url, &audioEffect);
        AudioServicesAddSystemSoundCompletion(audioEffect,
                                              NULL, 
                                              NULL, 
                                              systemAudioCallback, 
                                              (__bridge_retained void *) self);
        
        return self;
    }
    
    return nil;
}

+ (id)soundNamed: (NSString *)soundName
{return [[UISound alloc] initWithName: soundName];}

+ (id)soundWithContentsOfURL:(NSURL *)url
{return [[UISound alloc] initWithContentsOfURL: url];}

+ (NSArray *)soundUnfilteredTypes
{
    return [NSArray arrayWithObjects: @"aac",
                                      @"aiff",
                                      @"wav",
                                      @"wma",
                                      @"mp3",
                                      @"m4a", nil];
}

- (void)play
{AudioServicesPlaySystemSound(audioEffect);}

- (void)alert
{AudioServicesPlayAlertSound(audioEffect);}

- (void)dealloc
{
    AudioServicesRemoveSystemSoundCompletion(audioEffect);
    AudioServicesDisposeSystemSoundID(audioEffect);
}

@end
//========================================================================//
#pragma mark UISound Private Implementation
//========================================================================//
void systemAudioCallback(SystemSoundID soundID, void *clientData)
{
    UISound *sound = (__bridge_transfer UISound *) clientData;
    if (sound.delegate)
    {
        [sound.delegate sound: sound
             didFinishPlaying: YES];
    }
}
//========================================================================//