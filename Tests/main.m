//
//  main.m
//  RDHOrderedDictionary
//
//  Created by Richard Hodgkins on 23/02/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
#if RDH_TESTS
    return 0;
#else
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Use the tests!" userInfo:nil];
#endif
}

