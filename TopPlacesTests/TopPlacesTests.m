//
//  TopPlacesTests.m
//  TopPlacesTests
//
//  Created by Rupert Rebentisch on 20.07.13.
//  Copyright (c) 2013 Rupert Rebentisch. All rights reserved.
//

#import "TopPlacesTests.h"
#import "FlickrFetcher.h"

@implementation TopPlacesTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    NSLog(@"%@",[FlickrFetcher topPlaces]);
    STFail(@"Unit tests are not implemented yet in TopPlacesTests");
}

@end
