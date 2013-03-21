JSErrorStackTrace
=================

Category on NSError that stores the stack trace of the creation of the NSError object for later retrieval.

## Usage

Just use the property on `NSError` that it's added via the category:

```objc
#import "NSError+JSErrorStackTrace.h"

NSError *sampleError = [NSError errorWithDomain:NSCocoaErrorDomain code:1337 userInfo:nil];

NSLog(@"Error creation stack trace: %@", sampleError.js_stackTrace);
```

## Compatibility
- Works with ARC and non ARC projects.
- Compatible with iOS and Mac OSX.

## License
Copyright 2013 [Javier Soto](http://twitter.com/javisoto) (ios@javisoto.es)

JSErrorStackTrace is available under the MIT license. See the LICENSE file for more info.
