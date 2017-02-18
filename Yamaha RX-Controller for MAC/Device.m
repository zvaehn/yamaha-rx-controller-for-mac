//
//  Device.m
//  Yamaha RX-Controller for MAC
//
//  Created by Sven Schiffer on 17/02/2017.
//  Copyright © 2017 Sven Schiffer. All rights reserved.
//

#import "Device.h"

@implementation Device

-(id) init {
    self.isConnected = NO;
    
    if(self == nil){
        return nil;
    }
    
    return self;
}

-(bool)setSystemConfig:(NSDictionary *)systemConfig {
    self.modelNumber = [systemConfig valueForKeyPath: @"Model_Name.text"];
    self.versionNumber = [systemConfig valueForKeyPath: @"Version.text"];
    
    self.availableInputs = [systemConfig valueForKeyPath:@"Name.Input"];
    self.availableFeatures = [systemConfig valueForKeyPath:@"Feature_Existence"];
    
    return true;
}

-(bool)setBasicStatus:(NSDictionary *)basicStatus {
    NSDictionary *volume = [basicStatus valueForKeyPath:@"Volume"];
    
    self.powerStatus = [basicStatus valueForKeyPath:@"Power_Control.Power.text"];
    self.selectedInput = [basicStatus valueForKeyPath:@"Input.Input_Sel.text"];
    
    NSString *rawVolLevel = [volume valueForKeyPath:@"Lvl.Val.text"];
    NSNumber *volLevel = [NSNumber numberWithInt: [rawVolLevel intValue]];
    
    self.volume = [volLevel doubleValue];
    self.muteString = [volume valueForKeyPath:@"Mute.text"];
    
    
    
    return true;
}

-(NSMutableArray *)getFeatures {
    NSMutableArray *sortedValues = [NSMutableArray array];
    NSArray *sortedFeatureKeys = [[self.availableFeatures allKeys] sortedArrayUsingSelector: @selector(compare:)];
    
    for (NSString *key in sortedFeatureKeys) {
        NSLog(@"%@", [self.availableInputs objectForKey: key]);
        if([[self.availableInputs objectForKey: key] isEqual:@"1"]) {
            
        }
        else {
            [sortedValues addObject: key];
        }
    }
    
    return sortedValues;
}


-(NSMutableArray *)getInputs {
    NSMutableArray *sortedValues = [NSMutableArray array];
    NSArray *sortedInputKeys = [[self.availableInputs allKeys] sortedArrayUsingSelector: @selector(compare:)];
    
    for (NSString *key in sortedInputKeys) {
        [sortedValues addObject: [self.availableInputs objectForKey: key]];
        //[sortedValues addObject: key];
    }
    
    return sortedValues;
}

-(NSString *)getFullAPIUrl {
    return [NSString stringWithFormat:@"http://%@/%@", self.ip, self.ressourceURL];
}

-(bool)isMuted {
    if([self.muteString isEqualToString:@"On"]) {
        return true;
    }
    else {
        return false;
    }
}

-(bool)isStandby {
    return [self.powerStatus isEqualToString:@"Standby"];
}

-(bool)isOnline {
    if(self.isConnected && [self.powerStatus isEqualToString:@"On"]) {
        return true;
    }
    else {
        return false;
    }
}

@end
