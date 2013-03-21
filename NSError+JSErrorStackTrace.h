//
//  NSError+JSErrorStackTrace.h
//  JSErrorStackTrace_SampleProject
//
//  Created by Javier Soto on 3/20/13.
//  Copyright (c) 2013 Javier Soto. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @warning loading this category on a project involves some memory overhead since it will store the -init stack trace of every NSError object.
 */
@interface NSError (JSErrorStackTrace)

- (NSString *)js_stackTrace;

@end
