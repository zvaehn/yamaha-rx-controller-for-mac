//
//  Device.h
//  Yamaha RX-Controller for MAC
//
//  Created by Sven Schiffer on 17/02/2017.
//  Copyright © 2017 Sven Schiffer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Device : NSObject

@property NSString *ip;
@property NSString *ressourceURL;
@property BOOL isConnected;
@property double volume;
@property NSString *muteString;
@property NSString *powerStatus;
@property NSString *versionNumber;
@property NSString *modelNumber;
@property NSString *selectedInput;
@property NSDictionary *availableInputs;
@property NSDictionary *availableFeatures;

- (bool)setBasicStatus:(NSDictionary*)basicStatus;
- (bool)setSystemConfig:(NSDictionary*)systemConfig;
- (NSString *)getFullAPIUrl;
- (NSMutableArray *)getFeatures;
- (NSMutableArray *)getInputs;

- (bool)isMuted;
- (bool)isStandby;
- (bool)isOnline;

@end
