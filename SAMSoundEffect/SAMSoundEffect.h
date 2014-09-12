//
//  SAMSoundEffect.h
//  SAMSoundEffect
//
//  Created by Sam Soffes on 8/31/14.
//  Copyright (c) 2014 Sam Soffes. All rights reserved.
//

@class AVAudioPlayer;

/**
 This class simplifies playing sound effects as well as implementing basic caching behavior. It retains an
 `AVAudioPlayer` object with it's sound effect pre-cached and ready to play instantly. It is designed to provide user
 interface audio feedback, making it optimal for playing short sound clips.
 
 There can be some loading time between when a sound effect is initialized and when it is ready for playback. For this
 reason it is recommended to preload the sound in advance of when it is needed (for low latency playback). When you
 should preload is left up to your implementation, however a convenience method (`preloadSoundEffectNamed:`) is
 provided.
 */
@interface SAMSoundEffect : NSObject

/**
 Returns a sound effect with the provided name.
 
 @param name The name of the audio file. Can be in Core Audio Format without a file extension, otherwise an extension is
 required.
 
 @param bundleOrNil The bundle to search for the audio file (sending nil will use the main bundle).
 */
+ (instancetype)soundEffectNamed:(NSString *)name inBundle:(NSBundle *)bundleOrNil;
+ (instancetype)soundEffectNamed:(NSString *)name;


/**
 Plays a sound effect with the provided name.
 
 @param name The name of the audio file. Can be in Core Audio Format without a file extension, otherwise an extension is
 required.
 
 @param bundleOrNil The bundle to search for the audio file (sending nil will use the main bundle).
 */
+ (instancetype)playSoundEffectNamed:(NSString *)name inBundle:(NSBundle *)bundleOrNil;
+ (instancetype)playSoundEffectNamed:(NSString *)name;

/**
 Initializes a sound effect with the file at the provided path.
 
 @param path A full path to the desired audio file.
 
 The file can be in any format that AVAudioPlayer supports.
 
 @note It is recommended to use the `soundEffectNamed` class methods instead of this, as these methods cache the
 resulting sound effect object. This provides performance benefits and simpler syntax as well as assuring the sound
 effect is retained throughout its playback.
 */
- (instancetype)initWithContentsOfFile:(NSString *)path;

/**
 Plays the sound effect.
 */
- (void)play;


/**
 Stops the sound effect if its playing.
 */
- (void)stop;

/**
 Returns a boolean indicating if the sound effect is playing.
 
 @return A boolean indicating if the receiver is playing.
 */
- (BOOL)isPlaying;

@end
