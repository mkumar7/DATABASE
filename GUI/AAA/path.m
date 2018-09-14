//
//  path.m
//  AAA
//
//  Created by MingzhaoChen on 11/28/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "path.h"

@implementation GlobalData
@synthesize path;
static GlobalData *sharedGlobalData = nil;

+ (GlobalData*)sharedGlobalData {
    if (sharedGlobalData == nil) {
        sharedGlobalData = [[super allocWithZone:NULL] init];
        
        // initialize your variables here
        sharedGlobalData.path = @"/Users/cmz/Desktop/database_proj2/submission/GUI/AAA/out.txt";
        sharedGlobalData.A = @"/Users/cmz/Desktop/database_proj2/submission/GUI/AAA/test.sh";
        sharedGlobalData.B = @"/Users/cmz/Desktop/database_proj2/submission/GUI/AAA/schema.txt";
    }
    return sharedGlobalData;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self)
    {
        if (sharedGlobalData == nil)
        {
            sharedGlobalData = [super allocWithZone:zone];
            return sharedGlobalData;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}


@end
