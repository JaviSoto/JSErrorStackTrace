//
//  NSError+JSErrorStackTrace.m
//  JSErrorStackTrace_SampleProject
//
//  Created by Javier Soto on 3/20/13.
//  Copyright (c) 2013 Javier Soto. All rights reserved.
//

#import "NSError+JSErrorStackTrace.h"

#import <objc/runtime.h>

static char JSErrorStackTraceKey;

@interface NSError (JSErrorStackTrace_Private)

@property (nonatomic, copy) NSString *js_stackTrace;

@end

@implementation NSError (JSErrorStackTrace)

- (void)setJs_stackTrace:(NSString *)js_stackTrace
{
    objc_setAssociatedObject(self, &JSErrorStackTraceKey, js_stackTrace, OBJC_ASSOCIATION_COPY);
}

- (NSString *)js_stackTrace
{
    return objc_getAssociatedObject(self, &JSErrorStackTraceKey);
}

#pragma mark - Swizzled Method

- (id)init_jsswizzledInitWithDomain:(NSString *)domain code:(NSInteger)code userInfo:(NSDictionary *)dict
{
    // Call original implementation
    if ((self = [self init_jsswizzledInitWithDomain:domain code:code userInfo:dict]))
    {
        const NSUInteger linesToRemoveInStackTrace = 1; // This init method

        NSArray *stacktrace = [NSThread callStackSymbols];
        stacktrace = [stacktrace subarrayWithRange:NSMakeRange(linesToRemoveInStackTrace, stacktrace.count - linesToRemoveInStackTrace)];

        self.js_stackTrace = [stacktrace description];
    }

    return self;
}

@end

static void __attribute__((constructor)) JSErrorStackTraceInstall()
{
    Class NSErrorClass = [NSError class];

    Method originalInitMethod = class_getInstanceMethod(NSErrorClass, @selector(initWithDomain:code:userInfo:));
    Method swizzledInitMethod = class_getInstanceMethod(NSErrorClass, @selector(init_jsswizzledInitWithDomain:code:userInfo:));

    method_exchangeImplementations(originalInitMethod, swizzledInitMethod);
}
