//
//  table.m
//  AAA
//
//  Created by MingzhaoChen on 11/26/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "table.h"
#import "path.h"
@implementation table

//char a0[] ="/Users/cmz/Desktop/database_proj2/AAA/AAA/test.sh";
NSString * a0;
NSString * path;
//@"/Users/cmz/Desktop/database_proj2/AAA/AAA/schema.txt";

- (void)viewDidLoad {
    [super viewDidLoad];
    path = [GlobalData sharedGlobalData].B;
    a0 = [GlobalData sharedGlobalData].A;
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}


-(IBAction) show_logs:(id)sender
{
    char a[150];
    char a1[] = "java myjdbc 1 0";
    sprintf(a, "%s \"%s\"",[a0 UTF8String], a1);
    system(a);
    NSString *str = @"Logs(log#, user_name, operation, op_time, table_name, tuple_pkey)";
    
    NSError *error = nil;
     [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
}


- (IBAction)show_products:(id)sender {
    
    char a[150];
    char a1[] = "java myjdbc 1 5";
    sprintf(a, "%s \"%s\"",[a0 UTF8String], a1);
    system(a);
    
    NSString *str = @"Products(pid, name, qoh, qoh_threshold, original_price, discnt_category)";
    
    NSError *error = nil;
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    
}


- (IBAction)show_suppliers:(id)sender {
    char a[150];
    char a1[] = "java myjdbc 1 2";
    sprintf(a, "%s \"%s\"",[a0 UTF8String], a1);
    system(a);
    NSString *str = @"Suppliers(sid, name, city, telephone#, email)";
    
    NSError *error = nil;
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
}


- (IBAction)show_supplies:(id)sender {
    char a[150];
    char a1[] = "java myjdbc 1 1";
    sprintf(a, "%s \"%s\"",[a0 UTF8String], a1);
    system(a);
    NSString *str = @"Supplies(sup#, pid, sid, sdate, quantity)";
    
    NSError *error = nil;
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
}


- (IBAction)show_customers:(id)sender {
    char a[150];
    char a1[] = "java myjdbc 1 7";
    sprintf(a, "%s \"%s\"",[a0 UTF8String], a1);
    system(a);
    NSString *str = @"Customers(cid, name, telephone#, visits_made, last_visit_date)";
    
    NSError *error = nil;
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
}


- (IBAction)show_employees:(id)sender {
    char a[150];
    char a1[] = "java myjdbc 1 6";
    sprintf(a, "%s \"%s\"",[a0 UTF8String], a1);
    system(a);
    NSString *str = @"Employees(eid, name, telephone#, email)";
    
    NSError *error = nil;
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
}

- (IBAction)show_discounts:(id)sender {
    char a[150];
    char a1[] = "java myjdbc 1 3";
    sprintf(a, "%s \"%s\"",[a0 UTF8String], a1);
    system(a);
    NSString *str = @"Discounts(discnt_category, discnt_rate)";
    
    NSError *error = nil;
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    
}

- (IBAction)show_purchases:(id)sender {
    char a[150];
    char a1[] = "java myjdbc 1 4";
    sprintf(a, "%s \"%s\"",[a0 UTF8String], a1);
    system(a);
    NSString *str = @"Purchases(pur#, eid, pid, cid, qty, ptime, total_price)";
    
    NSError *error = nil;
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    
}


@end
