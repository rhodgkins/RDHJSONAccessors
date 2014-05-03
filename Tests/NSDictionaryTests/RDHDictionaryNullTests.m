//
//  RDHDictionaryNullTests.m
//  RDHJSONAccessors
//
//  Created by Richard Hodgkins on 03/05/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

@interface RDHDictionaryNullTests : XCTestCase

@property (nonatomic, copy) NSDictionary *dictionary;

@end

@implementation RDHDictionaryNullTests

-(void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.dictionary = @{@"NULL" : [NSNull null],
                    @"NOT_NULL" : @"STRING"};
}

-(void)test_isObjectNullForKey
{
    expect([self.dictionary isObjectNullForKey:@"NULL"]).to.beTruthy();
    expect([self.dictionary isObjectNullForKey:@"NOT_NULL"]).to.beFalsy();
}

-(void)test_objectOrNilIfNSNullForKey
{
    expect([self.dictionary objectOrNilIfNSNullForKey:@"NULL"]).to.beNil();
    expect([self.dictionary objectOrNilIfNSNullForKey:@"NOT_NULL"]).toNot.beNil();
    expect([self.dictionary objectOrNilIfNSNullForKey:@"NOT_NULL"]).toNot.beInstanceOf([NSNull class]);
}

-(void)test_objectForKeyofClass
{
    expect([self.dictionary objectForKey:@"NULL" ofClass:[NSNull class]]).to.beIdenticalTo([NSNull null]);
    expect([self.dictionary objectForKey:@"NULL" ofClass:[NSString class]]).to.beNil();
    
    expect([self.dictionary objectForKey:@"NOT_NULL" ofClass:[NSString class]]).toNot.beNil();
    expect([self.dictionary objectForKey:@"NOT_NULL" ofClass:[NSNull class]]).to.beNil();
}

@end
