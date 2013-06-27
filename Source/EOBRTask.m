//
//  EOBRTask.m
//  KMBEOBR
//
//  Created by bmahloch on 3/1/13.
//  Copyright (c) 2013 JJ Keller. All rights reserved.
//

#import "EOBRTask.h"
#import "EAController.h"
#import "EOBRResponsePacket.h"
#import "EOBRRequestPacket.h"

@implementation EOBRTask

- (void)start:(dispatch_queue_t)queue request:(EOBRRequestPacket *)request completion:(void(^)(EOBRResponsePacket *))completionBlock
{
    dispatch_async(queue, ^(){
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        __block EOBRResponsePacket *result = [[EOBRResponsePacket alloc] init];
        
        [[EAController sharedController] sendPacket:request completion:^(EOBRResponsePacket *response){
            
            result = response;
            dispatch_semaphore_signal(sema);
            
        }];
        
        dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, (RESPONSE_TIME_OUT * NSEC_PER_SEC));
        dispatch_semaphore_wait(sema, timeout);
        
        completionBlock(result);

    });
}

@end
