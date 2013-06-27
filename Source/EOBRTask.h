//
//  EOBRTask.h
//  KMBEOBR
//
//  Created by bmahloch on 3/1/13.
//  Copyright (c) 2013 JJ Keller. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EOBRRequestPacket;
@class EOBRResponsePacket;

@interface EOBRTask : NSObject

- (void)start:(dispatch_queue_t)queue request:(EOBRRequestPacket *)request completion:(void(^)(EOBRResponsePacket *))completionBlock;

@end
