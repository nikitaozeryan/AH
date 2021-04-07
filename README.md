
# AH

# Libraries:

## ReactiveSwift, ReactiveCocoa

ReactiveSwift offers composable, declarative, and flexible primitives that are built around the grand concept of streams of values over time.

These primitives can be used to uniformly represent common Cocoa and generic programming patterns that are fundamentally an act of observation, e.g. delegate pattern, callback closures, notifications, control actions, responder chain events, futures/promises, and key-value observing (KVO).

# Dependency manager

## Swift Package Manager

1) It’s the new standard build by Apple to create Swift apps.

2) Automatically manage a dependency’s dependencies. If a dependency relies on another dependency, Swift Package Manager will handle it for you.

3) Anyone inside the project will easily know what dependencies your app is using.

# Implementation choices motivations

## CoreData

1) Native Apple database

2) Optimizing Core Data Performance using NSFetchedResultsController

2) Much better memory management. With a plist you must load the entire thing into memory; with Core Data only the objects you're currently using need to be loaded. Also, once objects are loaded, they're normally placeholder "fault" objects whose property data doesn't load until you need it.

3) Related to the above, when you have changed, you can save only the changed objects, not the entire data set.

4) You can read/write your model objects directly instead of converting them to/from something like an NSDictionary.

5) Built-in sorting of objects when you fetch them from the data store.

6) Rich system of predicates for searching your data set for objects of interest.

7) Relationships between entities are handled directly, as properties on the related objects. With a plist you would need to do something like store an object ID for a relationship, and then look up the related object.

8) Optional automatic validation of property values.

## SDWebImage

 1) Categories for UIImageView, UIButton, MKAnnotationView adding web image and cache management
 
 3) An asynchronous image downloader
 
 4) An asynchronous memory + disk image caching with automatic cache expiration handling
 
 5) A background image decompression to avoid frame rate drop
 
 6) Progressive image loading (including animated image, like GIF showing in Web browser)
 
 7) Thumbnail image decoding to save CPU && Memory for large images
 
 8) Extendable image coder to support massive image format, like WebP
 
 9) Full-stack solution for animated images which keep a balance between CPU && Memory
 
 10) Customizable and composable transformations can be applied to the images right after download
 
 11) Customizable and multiple caches system
 
 12) Customizable and multiple loaders system to expand the capabilities, like Photos Library
 
 13) Image loading indicators
 
 14) Image loading transition animation
 
 15) A guarantee that the same URL won't be downloaded several times
 
 16) A guarantee that bogus URLs won't be retried again and again
 
 17) A guarantee that main thread will never be blocked
 
 18) Modern Objective-C and better Swift support
 
 19) Performances!

 ## Snapkit

 SnapKit is a DSL to make Auto Layout easy on both iOS and OS X.

 ## Preview
<a href="https://user-images.githubusercontent.com/16369351/113867273-01cdb580-97b7-11eb-9271-ca4592523db1.mp4" target="_blank">
 <img src="https://user-images.githubusercontent.com/16369351/113869872-e1ebc100-97b9-11eb-849d-315b70d4facb.jpeg" alt="Preview video" width="177.2" height="384" border="10" />
</a>
