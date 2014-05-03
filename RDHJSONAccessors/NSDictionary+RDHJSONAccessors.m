//
//  NSDictionary+RDHJSONAccessors.m
//  RDHJSONAccessors
//
//  Created by Richard Hodgkins on 03/05/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import "RDHJSONAccessors.h"

#import "RDHCoercion.h"

@implementation NSDictionary (RDHJSONAccessors)

#pragma mark - Checking if an Object Exists

-(BOOL)objectExistsForKey:(NSString *)aKey
{
    return self[aKey] != nil;
}


#pragma mark - Checking for null

-(BOOL)isObjectNullForKey:(NSString *)aKey
{
    return [self[aKey] isEqual:[NSNull null]];
}

-(id)objectOrNilIfNSNullForKey:(NSString *)aKey
{
    id object = self[aKey];
    if ([object isEqual:[NSNull null]]) {
        object = nil;
    }
    return object;
}


#pragma mark - Accessing String Objects

-(NSString *)stringForKey:(NSString *)aKey
{
    return [self stringForKey:aKey defaultValue:nil];
}

-(NSString *)stringForKey:(NSString *)aKey defaultValue:(NSString *)defaultValue
{
    return [self objectForKey:aKey ofClass:[NSString class] defaultValue:defaultValue];
}


#pragma mark - Accessing Numbers Objects

-(NSNumber *)numberForKey:(NSString *)aKey
{
    return [self numberForKey:aKey defaultValue:nil];
}

-(NSNumber *)numberForKey:(NSString *)aKey defaultValue:(NSNumber *)defaultValue
{
    return [self objectForKey:aKey ofClass:[NSNumber class] defaultValue:defaultValue];
}


#pragma mark - Accessing Decimal Numbers Objects

-(NSDecimalNumber *)decimalNumberForKey:(NSString *)aKey
{
    return [self decimalNumberForKey:aKey defaultValue:nil];
}

-(NSDecimalNumber *)decimalNumberForKey:(NSString *)aKey defaultValue:(NSDecimalNumber *)defaultValue
{
    return [self objectForKey:aKey ofClass:[NSDecimalNumber class] defaultValue:defaultValue];
}

#pragma mark - Accessing Collection Objects

-(NSDictionary *)dictionaryForKey:(NSString *)aKey
{
    return [self objectForKey:aKey ofClass:[NSDictionary class]];
}

-(NSArray *)arrayForKey:(NSString *)aKey
{
    return [self objectForKey:aKey ofClass:[NSArray class]];
}


#pragma mark - Accessing Objects by Class

-(id)objectForKey:(NSString *)aKey ofClass:(Class)cls
{
    return [self objectForKey:aKey ofClass:cls defaultValue:nil];
}

-(id)objectForKey:(NSString *)aKey ofClass:(Class)cls defaultValue:(id)defaultValue
{
    return RDHObjectAsClass(self[aKey], cls, defaultValue);
}

@end
