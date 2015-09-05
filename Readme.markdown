# SAMSoundEffect

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A simple way to play a sound effect on iOS.

## Installation

[CocoaPods](http://cocoapods.org) is recommended. Add the following to your Podfile:

``` ruby
pod 'SAMSoundEffect'
```

You can also just download and put the the two files in your project. You'll need to add AVFoundation to your target as well.

## Usage

Simple as:

```objective-c
[SAMSoundEffect playSoundEffectNamed:@"shutter"];
```

You can also do:

```objective-c
SAMSoundEffect *sound = [SAMSoundEffect soundEffectNamed:@"shutter"];
[sound play];
```

You can interrupt it too:

```objective-c
[sound stop];
```

**You'll probably want to add this in your `application:didFinishLaunchingWithOptions:`** so they don't stop audio from other applications.

``` objective-c
[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
```
