//
//  result.m
//  AAA
//
//  Created by MingzhaoChen on 11/26/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "result.h"
#import "path.h"

@implementation result

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [GlobalData sharedGlobalData].path;
    NSString *path2 = [GlobalData sharedGlobalData].B;
    NSError *error = nil;
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    NSString *str2 = [NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:&error];
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
             [_text setStringValue:str];
         [_schema setStringValue:str2];
    }


    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}


@end
