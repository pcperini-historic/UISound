#UISound#



Inherits From:    NSObject

Declared In:      UISound.h


##Overview##

The `UISound` class provides a simple interface for loading and playing audio files. This class supports the same audio encodings and file formats that are supported by Audio Toolbox.

To use this class, initialize a new instance with the desired file name. Play your audio data either as an alert or simply sound. Playback occurs synchronously, with vibration where applicable for alerts, and asynchronously otherwise, so that your application can continue doing work.

You should retrain `UISound` objects before initiating playback or make sure you have a strong reference to them in a garbage-collected environment. Upon deallocation, a sound object stops playback of the sound so that it can free up the corresponding audio resources. If you want to deallocate a sound object immediately after playback, assign a delegate and use the `sound:didFinishPlaying:` method to deallocate it. 

##Tasks##

###Configuring Sounds###
    name        (property)
    delegate    (property)

###Creating Sounds###
    - initWithName:
    - initWithContentsOfURL:
    + soundNamed:
    + soundWithContentsOfURL:
    
###Getting Sound Information####
    + soundUnfilteredTypes

###Playing Sounds###
    - play
    - alert

##Properties##

**name**

>The name of the audio file to be played.

        (copy) NSString *name

**delegate**

>The sound's delegate.

        (retain) id delegate


##Class Methods##

**soundNamed:**

>Returns the `UISound` instance associated with the given name.

        + (UISound *)soundNamed:(NSString *)soundName

>*Parameters:*

>`soundName`

>>The name that identifies sound data.

>*Return Value:*

>`UISound` instance initialized with the sound data identified by `soundName`.

**soundUnfilteredTypes**

>Provides the file types the `UISound` class understands.

        + (NSArray *)soundUnfilteredTypes

>*Return Value:*

>Array of UTIs identifying the file types the `UISound` class understands.

**soundWithContentsOfURL:**

>Returns the `UISound` instance associated with the given URL.

        + (UISound *)soundWithContentsOfURL:(NSURL *)url

>*Parameters:*

>`url`

>>URL that identifies sound data.

>*Return Value:*

>`UISound` instance initialized with the sound data identified by `url`.

##Instance Methods##

**alert:**

>Initiates audio playback, with vibration where applicable.

        - (void)alert

**initWithName:**

>Initializes the receiver with the audio data associated with the given name.

        + (id)initWithName:(NSString *)soundName

>*Parameters:*

>`soundName`

>>The name that identifies sound data.

>*Return Value:*

>`UISound` instance initialized with the sound data identified by `soundName`.

**initWithContentsOfURL:**

>Initializes the receiver with the audio data associated with the given URL.

        + (id)initWithContentsOfURL:(NSURL *)url

>*Parameters:*

>`url`

>>URL that identifies sound data.

>*Return Value:*

>`UISound` instance initialized with the sound data identified by `url`.

**play:**

>Initiates audio playback.

        - (void)play
        
#UISoundDelegate Protocol Reference#



Declared In:      UISound.h


##Overview##

The `UISoundDelegate` protocol defines the optional methods implemented by delegates of `UISound` objects. 

##Tasks##

###Playing Sounds###
    - sound:didFinishPlaying:

##Instance Methods##

**sound:didFinishPlaying:**

>This delegate method is called when a `UISound` instance has completed playback of its sound data.

        - (void)sound:(UISound *)sound didFinishPlaying:(BOOL)finishedPlaying

>*Parameters:*

>`sound`

>>The `UISound` that has completed playback of its sound data.

>`finishedPlaying`

>>`YES` when playback was successful; `NO` otherwise.