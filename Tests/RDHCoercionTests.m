//
//  RDHCoercionTests.m
//  RDHJSONAccessors
//
//  Created by Richard Hodgkins on 03/05/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

#import "RDHCoercion.h"

@interface RDHCoercionTests : XCTestCase

@end

@implementation RDHCoercionTests

-(void)testDefaultValues
{
    // Default matching the specified type
    expect(RDHObjectAsClass(nil, [NSString class], @"STRING")).to.equal(@"STRING");
    expect(RDHObjectAsClass(nil, [NSNumber class], @1)).to.equal(@1);
    expect(RDHObjectAsClass(nil, [NSDecimalNumber class], [NSDecimalNumber one])).to.equal([NSDecimalNumber one]);
    expect(RDHObjectAsClass(nil, [NSDictionary class], @{@"K" : @"V"})).to.equal(@{@"K" : @"V"});
    expect(RDHObjectAsClass(nil, [NSArray class], @[@"1", @"2"])).to.equal(@[@"1", @"2"]);
    
    // Defaults not matching the specified types
    expect(^{ RDHObjectAsClass(@"", [NSString class], [NSNull null]); }).to.raise(NSInternalInconsistencyException);
    expect(^{ RDHObjectAsClass(@"", [NSNumber class], [NSNull null]); }).to.raise(NSInternalInconsistencyException);
    expect(^{ RDHObjectAsClass(@"", [NSDecimalNumber class], [NSNull null]); }).to.raise(NSInternalInconsistencyException);
    expect(^{ RDHObjectAsClass(@"", [NSDictionary class], [NSNull null]); }).to.raise(NSInternalInconsistencyException);
    expect(^{ RDHObjectAsClass(@"", [NSArray class], [NSNull null]); }).to.raise(NSInternalInconsistencyException);
    expect(^{ RDHObjectAsClass(@"", [NSNull class], @1); }).to.raise(NSInternalInconsistencyException);
}

-(void)testAllowedClasses
{
    expect(^{ RDHObjectAsClass(@"", [NSString class], @""); }).toNot.raise(NSInternalInconsistencyException);
    expect(^{ RDHObjectAsClass(@"", [NSNumber class], @1); }).toNot.raise(NSInternalInconsistencyException);
    expect(^{ RDHObjectAsClass(@"", [NSDecimalNumber class], [NSDecimalNumber one]); }).toNot.raise(NSInternalInconsistencyException);
    expect(^{ RDHObjectAsClass(@"", [NSDictionary class], @{}); }).toNot.raise(NSInternalInconsistencyException);
    expect(^{ RDHObjectAsClass(@"", [NSArray class], @[]); }).toNot.raise(NSInternalInconsistencyException);
    expect(^{ RDHObjectAsClass(@"", [NSNull class], [NSNull null]); }).toNot.raise(NSInternalInconsistencyException);
    
    // Not allowed
    expect(^{ RDHObjectAsClass(@"", [NSDate class], [NSDate date]); }).to.raise(NSInternalInconsistencyException);
}

-(void)testNSStrings
{
    // String conversion
    expect(RDHObjectAsClass(@"STRING", [NSString class], nil)).to.equal(@"STRING");
    expect(RDHObjectAsClass(nil, [NSString class], nil)).to.beNil();
    expect(RDHObjectAsClass([NSNull null], [NSString class], @"STRING")).to.equal(@"STRING");
    
    // Number conversion
    
    expect(RDHObjectAsClass(@"STRING", [NSDictionary class], nil)).to.beNil();
    expect(RDHObjectAsClass(@"STRING", [NSArray class], nil)).to.beNil();
    expect(RDHObjectAsClass(@"STRING", [NSNull class], nil)).to.beNil();
}

-(void)testNSNumbers
{
    expect(RDHObjectAsClass(@1, [NSNumber class], nil)).to.equal(@1);
    
    expect(RDHObjectAsClass(@1, [NSString class], nil)).to.equal(@"1");
    
    expect(RDHObjectAsClass(@"1", [NSNumber class], nil)).to.equal(@1);
    
    expect(RDHObjectAsClass(@"STRING", [NSNumber class], nil)).to.beNil();
}

-(void)testNSDecimalNumbers
{
    expect(RDHObjectAsClass([NSDecimalNumber one], [NSDecimalNumber class], nil)).to.equal([NSDecimalNumber one]);
    
    expect(RDHObjectAsClass([NSDecimalNumber one], [NSString class], nil)).to.equal(@"1");
    
    expect(RDHObjectAsClass(@"1", [NSDecimalNumber class], nil)).to.equal([NSDecimalNumber one]);
    
    expect(RDHObjectAsClass(@"STRING", [NSDecimalNumber class], nil)).to.beNil();
}

-(void)testNSDictionaryConversions
{
    expect(RDHObjectAsClass(@{@"K" : @"V"}, [NSDictionary class], nil)).to.equal(@{@"K" : @"V"});
    
    expect(RDHObjectAsClass(@"", [NSDictionary class], nil)).to.beNil();
    
    expect(RDHObjectAsClass(@"", [NSDictionary class], @{@"K" : @"V"})).to.equal(@{@"K" : @"V"});
    
    expect(RDHObjectAsClass(@"STRING", [NSDictionary class], nil)).to.beNil();
}

-(void)testNSArrayConversions
{
    expect(RDHObjectAsClass(@[@"1", @"2"], [NSArray class], nil)).to.equal(@[@"1", @"2"]);
    
    expect(RDHObjectAsClass(@"", [NSArray class], nil)).to.beNil();
    
    expect(RDHObjectAsClass(@"", [NSArray class], @[@"1", @"2"])).to.equal(@[@"1", @"2"]);
    
    expect(RDHObjectAsClass(@"STRING", [NSArray class], nil)).to.beNil();
}

@end
