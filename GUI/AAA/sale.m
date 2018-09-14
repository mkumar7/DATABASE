//
//  sale.m
//  AAA
//
//  Created by MingzhaoChen on 11/26/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "sale.h"
#import "path.h"

@implementation sale


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
    
    char a[150];

    NSString *a0 = [GlobalData sharedGlobalData].A;
    //[[GlobalData sharedGlobalData].path UTF8String];
   // "/Users/cmz/Desktop/database_proj2/AAA/AAA/test.sh";
    char a1[] = "java myjdbc 3";
    sprintf(a, "%s \"%s %s\"",[a0 UTF8String], a1, [myString UTF8String]);
    system(a);
    NSString *path =[GlobalData sharedGlobalData].path;
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
