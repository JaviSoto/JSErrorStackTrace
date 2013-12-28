//
//  NSError+JSErrorStackTrace.m
//  JSErrorStackTrace_SampleProject
//
//  Created by Javier Soto on 3/20/13.
//  Copyright (c) 2013 Javier Soto. All rights reserved.
//

#import "NSError+JSErrorStackTrace.h"

#import <objc/runtime.h>

#if TARGET_OS_IPHONE
NSString *const JSErrorStackTraceKey = @"com.javisoto.errorstacktracekey";
#else
#import <ExceptionHandling/ExceptionHandling.h>
#define JSErrorStackTraceKey NSStackTraceKey
#endif

@implementation NSError (JSErrorStackTrace)

- (NSString *)js_stackTrace
{
    NSArray *stacktrace = [self.userInfo objectForKey:JSErrorStackTraceKey];
    
    const NSUInteger linesToRemoveInStackTrace = 1; // This init method
    stacktrace = [stacktrace subarrayWithRange:NSMakeRange(linesToRemoveInStackTrace, stacktrace.count - linesToRemoveInStackTrace)];
    
    return stacktrace.description;
}

#pragma mark - Swizzled Method

- (id)init_jsswizzledInitWithDomain:(NSString *)domain code:(NSInteger)code userInfo:(NSDictionary *)dict
{
    if (![dict objectForKey:JSErrorStackTraceKey])
    {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:dict];
        [userInfo setObject:[NSThread callStackSymbols] forKey:JSErrorStackTraceKey];
        dict = userInfo;
    }
    
    // Call original implementation
    return [self init_jsswizzledInitWithDomain:domain code:code userInfo:dict];
}

@end

static void __attribute__((constructor)) JSErrorStackTraceInstall()
{
    Class NSErrorClass = [NSError class];

    Method originalInitMethod = class_getInstanceMethod(NSErrorClass, @selector(initWithDomain:code:userInfo:));
    Method swizzledInitMethod = class_getInstanceMethod(NSErrorClass, @selector(init_jsswizzledInitWithDomain:code:userInfo:));

    method_exchangeImplementations(originalInitMethod, swizzledInitMethod);
}
