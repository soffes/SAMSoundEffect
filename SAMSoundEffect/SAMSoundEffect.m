///
//  SAMSoundEffect.m
//  SAMSoundEffect
//
//  Created by Sam Soffes on 8/31/14.
//  Copyright (c) 2014 North Technologies. All rights reserved.
//

#import "SAMSoundEffect.h"

@import AVFoundation;

@interface SAMSoundEffect ()
@property (nonatomic) AVAudioPlayer *player;
@end

@implementation SAMSoundEffect

#pragma mark - Accessors

@synthesize player = _player;


#pragma mark - Class Methods

+ (void)initialize {
	if (self == [SAMSoundEffect class]) {
		[[NSNotificationCenter defaultCenter]
         addObserverForName:AVAudioSessionMediaServicesWereResetNotification
         object:nil
         queue:nil
         usingBlock:^(NSNotification *notification) {
             [[self _cache] removeAllObjects];
         }];
	}
}


+ (NSCache *)_cache {
	static NSCache *cache = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		cache = [[NSCache alloc] init];
	});
	return cache;
}


+ (instancetype)soundEffectNamed:(NSString *)name {
	return [SAMSoundEffect soundEffectNamed:name inBundle:nil];
}


+ (instancetype)soundEffectNamed:(NSString *)name inBundle:(NSBundle *)bundleOrNil {
	if (!name) {
		return nil;
	}
	
	if (!bundleOrNil) {
		bundleOrNil = [NSBundle mainBundle];
	}
	
	SAMSoundEffect *cachedSoundEffect = [[self _cache] objectForKey:name];
	if (!cachedSoundEffect) {
		NSString *fileName = [[[name pathComponents] lastObject] stringByDeletingPathExtension];
		NSString *fileExtension = [name pathExtension];
		if ([fileExtension isEqualToString:@""]) {
			fileExtension = @"caf";
		}
		
		cachedSoundEffect = [[SAMSoundEffect alloc] initWithContentsOfFile:[bundleOrNil pathForResource:fileName ofType:fileExtension]];
		if (cachedSoundEffect) {
			[[self _cache] setObject:cachedSoundEffect forKey:name];
		} else {
			NSLog(@"[SAMSoundEffect] Could not find file named: %@ in bundle: %@", name, bundleOrNil.bundleIdentifier);
		}
	}
	
	return cachedSoundEffect;
}


+ (instancetype)playSoundEffectNamed:(NSString *)name {
	return [self playSoundEffectNamed:name inBundle:nil];
}


+ (instancetype)playSoundEffectNamed:(NSString *)name inBundle:(NSBundle *)bundleOrNil {
	SAMSoundEffect *soundEffect = [SAMSoundEffect soundEffectNamed:name inBundle:bundleOrNil];
	[soundEffect play];
	return soundEffect;
}


#pragma mark - Instance Methods

- (instancetype)initWithContentsOfFile:(NSString *)path {
	if ((self = [super init])) {
		NSURL *fileURL = [NSURL fileURLWithPath:path];
		
		if (!fileURL) {
			NSLog(@"[SAMSoundEffect] NSURL is nil for path: %@", path);
			return nil;
		}

		if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:NULL]) {
			NSLog(@"[SAMSoundEffect] File doesn't exist at path: %@", path);
			return nil;
		}
		
		self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
		[self.player prepareToPlay];
	}
	return self;
}


- (void)play {
	if (!self.player) {
		NSLog(@"[SAMSoundEffect] Could not play sound - no effectPlayer. %@", self);
	}
	
	[self.player play];
}


- (void)stop {
	[self.player stop];
}


- (BOOL)isPlaying {
	return self.player.playing;
}

@end
