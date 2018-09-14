//
//  AddCustomer.m
//  AAA
//
//  Created by MingzhaoChen on 11/26/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "AddCustomer.h"
#import "path.h"

@implementation AddCustomer

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

- (IBAction)run:(id)sender {
    NSString *myString = [_get stringValue];
    NSString *myString2 = [_get2 stringValue];
    NSString *myString3 = [_get3 stringValue];
    char a[150];
    NSString * a0 = [GlobalData sharedGlobalData].A;
    //"/Users/cmz/Desktop/database_proj2/AAA/AAA/test.sh";
    char a1[] = "java myjdbc 4";
    sprintf(a, "%s \"%s %s %s %s\"",[a0 UTF8String], a1, [myString UTF8String], [myString2 UTF8String], [myString3 UTF8String]);
    system(a);
    NSString *path = [GlobalData sharedGlobalData].path;
    //@"/Users/cmz/Desktop/database_proj2/AAA/AAA/out.txt";
    NSError *error = nil;
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        [_out setStringValue:str];
    }
}


@end
