//
//  RDHCoercion.m
//  RDHJSONAccessors
//
//  Created by Richard Hodgkins on 03/05/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import "RDHCoercion.h"

static id RDHCoerceObjectToClass(id object, Class cls)
{
    NSCParameterAssert(object);
    NSCParameterAssert(cls);
    
    static NSMapTable *allowedCoercionsMap;
    static dispatch_once_t onceTokenCoercion;
    dispatch_once(&onceTokenCoercion, ^{
        allowedCoercionsMap = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory valueOptions:NSMapTableCopyIn];
        
        [allowedCoercionsMap setObject:@[[NSNumber class]] forKey:[NSString class]];
        [allowedCoercionsMap setObject:@[[NSString class]] forKey:[NSNumber class]];
        [allowedCoercionsMap setObject:@[[NSString class], [NSNumber class]] forKey:[NSDecimalNumber class]];
        [allowedCoercionsMap setObject:@[] forKey:[NSDictionary class]];
        [allowedCoercionsMap setObject:@[] forKey:[NSArray class]];
        [allowedCoercionsMap setObject:@[] forKey:[NSNull class]];
    });
    
    NSArray *allowedCoercions = [allowedCoercionsMap objectForKey:cls];
    
#if !defined(NS_BLOCK_ASSERTIONS)
    // Check that cls is one of the allowed types
    NSCAssert(allowedCoercions, @"Specified class '%@' is not one of the allowed types: %@", NSStringFromClass(cls), [[allowedCoercionsMap dictionaryRepresentation] allKeys]);
#endif
    
    BOOL allowedToCoerce = [allowedCoercions indexOfObjectPassingTest:^BOOL(Class allowedClass, NSUInteger idx, BOOL *stop) {
        *stop = [object isKindOfClass:allowedClass];
        return *stop;
    }] != NSNotFound;
    
    if (allowedToCoerce) {
        
        static NSLocale *enUSPOSIXLocale;
        static dispatch_once_t onceTokenLocale;
        dispatch_once(&onceTokenLocale, ^{
            enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            NSCAssert(enUSPOSIXLocale, @"Cannot setup locale for en_US_POSIX");
        });
        
        if (cls == [NSString class]) {
            
            return [object descriptionWithLocale:enUSPOSIXLocale];
            
        } else if (cls == [NSNumber class]) {
            
            static NSNumberFormatter *numberFormatter;
            static dispatch_once_t onceTokenFormatter;
            dispatch_once(&onceTokenFormatter, ^{
                numberFormatter = [NSNumberFormatter new];
                [numberFormatter setLocale:enUSPOSIXLocale];
                [numberFormatter setGeneratesDecimalNumbers:NO];
            });
            
            return [numberFormatter numberFromString:object];
            
        } else if (cls == [NSDecimalNumber class]) {
            
            if ([object isKindOfClass:[NSString class]]) {
                NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:object locale:enUSPOSIXLocale];
                if ([number isEqualToNumber:[NSDecimalNumber notANumber]]) {
                    // Don't allow NaN - its not in the JSON spec
                    number = nil;
                }
                return number;
            } else {
                // If we're not a string try to get a string for it
                return RDHCoerceObjectToClass([object descriptionWithLocale:enUSPOSIXLocale], cls);
            }
        }
    }
    
    // Not allowed to coerce the object to cls
    return nil;
}

id RDHObjectAsClass(id object, Class cls, id defaultObject)
{
    NSCParameterAssert(cls);
    
    // Check that defaultValue is kind of cls if its provided
    if (defaultObject) {
        NSCParameterAssert([defaultObject isKindOfClass:cls]);
    }
    
    id result = defaultObject;
    
    if ([object isKindOfClass:cls]) {
        // If the object matches the provided class just use it as is
        result = object;
    } else if (object) {
        // Try to coerce the object to cls
        id coercedObject = RDHCoerceObjectToClass(object, cls);
        if (coercedObject) {
            // If the object can be coerced use it
            result = coercedObject;
        }
    }
    
    return result;
}
