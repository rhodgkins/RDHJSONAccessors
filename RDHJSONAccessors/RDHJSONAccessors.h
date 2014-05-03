//
//  RDHJSONAccessors.h
//  RDHJSONAccessors
//
//  Created by Richard Hodgkins on 03/05/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Allows easy runtime checking and accessing of objects in a `NSDictionary` when deserialising JSON.
 */
@interface NSDictionary (RDHJSONAccessors)

#pragma mark - Checking if an Object Exists
/// @name Checking if an Object Exists

/// @returns `YES` if an object entry exists for the key, `NO` otherwise.
-(BOOL)objectExistsForKey:(NSString *)aKey;


#pragma mark - Checking for null
/// @name Checking for null

/// @returns `YES` if the object entry for the key is `[NSNull null]`, `NO` otherwise.
-(BOOL)isObjectNullForKey:(NSString *)aKey;

/// @returns the object entry for the key, or `nil` if the entry is `[NSNull null]`.
-(id)objectOrNilIfNSNullForKey:(NSString *)aKey;


#pragma mark - Accessing String Objects
/// @name Accessing String Objects

/// @returns the string object for the key, or `nil` if either the object cannot be coerced as a `NSString` or no object is present.
-(NSString *)stringForKey:(NSString *)aKey;

/// @returns the string object for the key, or `defaultValue` if either the object cannot be coerced as a `NSString` or no object is present.
-(NSString *)stringForKey:(NSString *)aKey defaultValue:(NSString *)defaultValue;


#pragma mark - Accessing Numbers Objects
/// @name Accessing Numbers Objects

/// @returns the number object for the key, or `nil` if either the object is not a `NSNumber` or no object is present.
-(NSNumber *)numberForKey:(NSString *)aKey;

/// @returns the number object for the key, or `defaultValue` if either the object cannot be coerced as `NSNumber` or no object is present.
-(NSNumber *)numberForKey:(NSString *)aKey defaultValue:(NSNumber *)defaultValue;


#pragma mark - Accessing Decimal Numbers Objects
/// @name Accessing Decimal Numbers Objects

/// @returns the number object for the key, or `nil` if either the object cannot be coerced as a `NSDecimalNumber` or no object is present.
-(NSDecimalNumber *)decimalNumberForKey:(NSString *)aKey;

/// @returns the number object for the key, or `defaultValue` if either the object cannot be coerced as `NSDecimalNumber` or no object is present.
-(NSDecimalNumber *)decimalNumberForKey:(NSString *)aKey defaultValue:(NSDecimalNumber *)defaultValue;


#pragma mark - Accessing Collection Objects
/// @name Accessing Collection Objects

/// @returns the dictionary object for the key, or `nil` if either the object is not a `NSDictionary` or no object is present.
-(NSDictionary *)dictionaryForKey:(NSString *)aKey;

/// @returns the array object for the key, or `nil` if either the object is not a `NSArray` or no object is present.
-(NSArray *)arrayForKey:(NSString *)aKey;


#pragma mark - Accessing Objects by Class
/// @name Accessing Objects by Class

/**
 * @returns the object for the key, or `nil` if either the object is not of the provided class, cannot be coerced to the provided class or no object is present.
 * @warning `cls` must be one of `NSString`, `NSNumber`, `NSDecimalNumber`, `NSNull`, `NSDictionary` or `NSArray`.
 */
-(id)objectForKey:(NSString *)aKey ofClass:(Class)cls;

/**
 * @returns the object for the key, or `defaultValue` if either the object is not of the provided class, cannot be coerced to the provided class or no object is present.
 * @warning `cls` must be one of `NSString`, `NSNumber`, `NSDecimalNumber`, `NSNull`, `NSDictionary` or `NSArray`.
 * @warning `defaultValue` must be of the same class as the provided class.
 */
-(id)objectForKey:(NSString *)aKey ofClass:(Class)cls defaultValue:(id)defaultValue;

@end


/**
 * Allows easy runtime checking and accessing of objects in a `NSArray` when deserialising JSON.
 */
@interface NSArray (RDHJSONAccessors)

#pragma mark - Checking for null
/// @name Checking for null

/// @returns `YES` if the object at the index is `[NSNull null]`, `NO` otherwise.
-(BOOL)isObjectNullAtIndex:(NSUInteger)index;

/// @returns the object at the index, or `nil` if the entry is `[NSNull null]`.
-(id)objectOrNilIfNSNullAtIndex:(NSUInteger)index;


#pragma mark - Accessing String Objects
/// @name Accessing String Objects

/// @returns the string object at the index, or `nil` if either the object cannot be coerced as a `NSString` or no object is present.
-(NSString *)stringAtIndex:(NSUInteger)index;

/// @returns the string object at the index, or `defaultValue` if either the object cannot be coerced as a `NSString` or no object is present.
-(NSString *)stringAtIndex:(NSUInteger)index defaultValue:(NSString *)defaultValue;


#pragma mark - Accessing Numbers Objects
/// @name Accessing Numbers Objects

/// @returns the number object at the index, or `nil` if either the object is not a `NSNumber` or no object is present.
-(NSNumber *)numberAtIndex:(NSUInteger)index;

/// @returns the number object at the index, or `defaultValue` if either the object cannot be coerced as `NSNumber` or no object is present.
-(NSNumber *)numberAtIndex:(NSUInteger)index defaultValue:(NSNumber *)defaultValue;


#pragma mark - Accessing Decimal Numbers Objects
/// @name Accessing Decimal Numbers Objects

/// @returns the number object at the index, or `nil` if either the object cannot be coerced as a `NSDecimalNumber` or no object is present.
-(NSDecimalNumber *)decimalNumberAtIndex:(NSUInteger)index;

/// @returns the number object at the index, or `defaultValue` if either the object cannot be coerced as `NSDecimalNumber` or no object is present.
-(NSDecimalNumber *)decimalNumberAtIndex:(NSUInteger)index defaultValue:(NSDecimalNumber *)defaultValue;


#pragma mark - Accessing Collection Objects
/// @name Accessing Collection Objects

/// @returns the dictionary object at the index, or `nil` if either the object is not a `NSDictionary` or no object is present.
-(NSDictionary *)dictionaryAtIndex:(NSUInteger)index;

/// @returns the array object at the index, or `nil` if either the object is not a `NSArray` or no object is present.
-(NSArray *)arrayAtIndex:(NSUInteger)index;


#pragma mark - Accessing Objects by Class
/// @name Accessing Objects by Class

/**
 * @returns the object at the index, or `nil` if either the object is not of the provided class, cannot be coerced to the provided class or no object is present.
 * @warning `cls` must be one of `NSString`, `NSNumber`, `NSDecimalNumber`, `NSNull`, `NSDictionary` or `NSArray`.
 */
-(id)objectAtIndex:(NSUInteger)index ofClass:(Class)cls;

/**
 * @returns the object at the index, or `defaultValue` if either the object is not of the provided class, cannot be coerced to the provided class or no object is present.
 * @warning `cls` must be one of `NSString`, `NSNumber`, `NSDecimalNumber`, `NSNull`, `NSDictionary` or `NSArray`.
 * @warning `defaultValue` must be of the same class as the provided class.
 */
-(id)objectAtIndex:(NSUInteger)index ofClass:(Class)cls defaultValue:(id)defaultValue;

@end
