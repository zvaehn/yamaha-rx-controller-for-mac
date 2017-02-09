//
//  CommunicationController.h
//  Yamaha RX-Controller for MAC
//
//  Created by Sven Schiffer on 08/02/2017.
//  Copyright © 2017 Sven Schiffer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLReader.h"//;

@interface CommunicationController : NSObject

@property BOOL isConnected;
@property NSString *ip;
@property NSMutableData *response;
@property XMLReader *xmlReader;

-(BOOL) connect;
-(BOOL) sendCommand:(NSString*)identifiedByString;

@end
