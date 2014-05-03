//
//  NSArray+RDHJSONAccessors.m
//  RDHJSONAccessors
//
//  Created by Richard Hodgkins on 03/05/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import "RDHJSONAccessors.h"

#import "RDHCoercion.h"

@implementation NSArray (RDHJSONAccessors)

#pragma mark - Checking for null

-(BOOL)isObjectNullAtIndex:(NSUInteger)index
{
    return [self[index] isEqual:[NSNull null]];
}

-(id)objectOrNilIfNSNullAtIndex:(NSUInteger)index
{
    id object = self[index];
    if ([object isEqual:[NSNull null]]) {
        object = nil;
    }
    return object;
}


#pragma mark - Accessing String Objects

-(NSString *)stringAtIndex:(NSUInteger)index
{
    return [self stringAtIndex:index defaultValue:nil];
}

-(NSString *)stringAtIndex:(NSUInteger)index defaultValue:(NSString *)defaultValue
{
    return [self objectAtIndex:index ofClass:[NSString class] defaultValue:defaultValue];
}

#pragma mark - Accessing Numbers Objects

-(NSNumber *)numberAtIndex:(NSUInteger)index;
{
    return [self numberAtIndex:index defaultValue:nil];
}

-(NSNumber *)numberAtIndex:(NSUInteger)index defaultValue:(NSNumber *)defaultValue
{
    return [self objectAtIndex:index ofClass:[NSNumber class] defaultValue:defaultValue];
}


#pragma mark - Accessing Decimal Numbers Objects

-(NSDecimalNumber *)decimalNumberAtIndex:(NSUInteger)index
{
    return [self decimalNumberAtIndex:index defaultValue:nil];
}

-(NSDecimalNumber *)decimalNumberAtIndex:(NSUInteger)index defaultValue:(NSDecimalNumber *)defaultValue
{
    return [self objectAtIndex:index ofClass:[NSDecimalNumber class] defaultValue:defaultValue];
}


#pragma mark - Accessing Collection Objects

-(NSDictionary *)dictionaryAtIndex:(NSUInteger)index;
{
    return [self objectAtIndex:index ofClass:[NSDictionary class]];
}

-(NSArray *)arrayAtIndex:(NSUInteger)index
{
    return [self objectAtIndex:index ofClass:[NSArray class]];
}


#pragma mark - Accessing Objects by Class

-(id)objectAtIndex:(NSUInteger)index ofClass:(Class)cls;
{
    return [self objectAtIndex:index ofClass:cls defaultValue:nil];
}

-(id)objectAtIndex:(NSUInteger)index ofClass:(Class)cls defaultValue:(id)defaultValue
{
    return RDHObjectAsClass(self[index], cls, defaultValue);
}

@end
