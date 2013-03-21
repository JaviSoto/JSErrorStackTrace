//
//  JSAppDelegate.m
//  JSErrorStackTrace_SampleProject
//
//  Created by Javier Soto on 3/20/13.
//  Copyright (c) 2013 Javier Soto. All rights reserved.
//

#import "JSAppDelegate.h"

#import "NSError+JSErrorStackTrace.h"

@implementation JSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    NSError *sampleError = [NSError errorWithDomain:NSCocoaErrorDomain code:1337 userInfo:nil];

    NSLog(@"Error creation stack trace: %@", sampleError.js_stackTrace);

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
