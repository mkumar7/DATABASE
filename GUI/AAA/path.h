//
//  path.h
//  AAA
//
//  Created by MingzhaoChen on 11/28/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//


@interface GlobalData : NSObject {
    NSString *message; // global variable
}

@property (nonatomic, retain) NSString *path;
@property (nonatomic, retain) NSString *A;
@property (nonatomic, retain) NSString *B;

+ (GlobalData*)sharedGlobalData;


@end
