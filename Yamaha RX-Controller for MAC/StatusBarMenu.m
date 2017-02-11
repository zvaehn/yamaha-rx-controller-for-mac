//
//  StatusBarMenu.m
//  Yamaha RX-Controller for MAC
//
//  Created by Sven Schiffer on 08/02/2017.
//  Copyright © 2017 Sven Schiffer. All rights reserved.
//

#import "StatusBarMenu.h"
#import "CommunicationController.h"
#import "AFHTTPSessionManager.h"

@implementation StatusBarMenu

- (void)awakeFromNib {
    self.comctrl = [[CommunicationController alloc] init];
    self.isConnected = NO;
}

- (void) updateMenuAppearance {
    
    [self.statusMenuItem setEnabled:NO];
    [self.volumeSlider setEnabled:NO];
    [self.toggleMuteMenuItem setEnabled:NO];
    [self setMenuItemToBold:NO forMenuItem:self.deviceMenuItem];
    
    // Device Submenu items
    [self.devicePowerOnMenuItem setHidden: NO];
    [self.devicePowerOffMenuItem setHidden: YES];

    
    // Enable items and set mark them as visible
    if(self.isConnected) {
        // Device Submenu items
        if([self.powerStatus isEqualToString:@"Standby"]) {
            [self.statusMenuItem setTitle:[NSString stringWithFormat:@"Standby: %@", self.modelNumber]];
            [self.devicePowerOnMenuItem setHidden: NO];
            [self.devicePowerOffMenuItem setHidden: YES];
        }
        else if([self.powerStatus isEqualToString:@"On"]) {
            [self.statusMenuItem setTitle:[NSString stringWithFormat:@"Connected: %@", self.modelNumber]];
            [self setMenuItemToBold:YES forMenuItem:self.deviceMenuItem];
            [self.volumeSlider setEnabled:YES];
            [self.toggleMuteMenuItem setEnabled:YES];
            [self.devicePowerOnMenuItem setHidden: YES];
            [self.devicePowerOffMenuItem setHidden: NO];
        }
        else {
            // Off ?
            NSLog(@"else in powerstatus: %@", self.powerStatus);
        }
    }
}

- (void)menuDidClose:(NSMenu *)menu {
    
}

- (void)menuWillOpen:(NSMenu *)menu {
    [self.statusMenuItem setTitle:@"Connecting..."];
    
    [self updateMenuAppearance];
    [self getVolumeInformation];
}

-(void)getSystemConfig {
    NSString *xml = @"<YAMAHA_AV cmd=\"GET\"><System><Config>GetParam</Config></System></YAMAHA_AV>";
    
    // Start the request
    NSMutableURLRequest *urlrequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://192.168.178.26/YamahaRemoteControl/ctrl" parameters:nil error:nil];
    [urlrequest setTimeoutInterval:5];
    [urlrequest setHTTPBody:[NSKeyedArchiver archivedDataWithRootObject:xml]];
    
    AFHTTPSessionManager *smanager = [[AFHTTPSessionManager alloc] init];
    smanager.responseSerializer = [AFHTTPResponseSerializer serializer];
    smanager.responseSerializer.acceptableContentTypes =  [smanager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/xml"];
    
    NSURLSessionDataTask *task = [smanager dataTaskWithRequest:urlrequest completionHandler:^(NSURLResponse* _Nonnull response, id  _Nullable responseObject, NSError* _Nullable error) {
        
        if(!error) {
            NSError *parseerror = nil;
            NSString *fetchedXML = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
            
            NSData *data = [fetchedXML dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *dict = [XMLReader dictionaryForXMLData:data
                                                         options:XMLReaderOptionsProcessNamespaces
                                                           error:&parseerror];
            
            self.isConnected = YES;
            [self.statusMenuItem setTitle:@"Status: Connected"];
            
            NSDictionary *config = [dict valueForKeyPath:@"YAMAHA_AV.System.Config"];
            
            self.modelNumber = [config valueForKeyPath: @"Model_Name.text"];
            self.versionNumber = [config valueForKeyPath: @"Version.text"];
            
            [self.statusMenuItem setTitle:[NSString stringWithFormat:@"Connected: %@", self.modelNumber]];
            [self.deviceInfoMenuItem setTitle:[NSString stringWithFormat:@"Firmware Version: %@", self.versionNumber]];
        }
        else {
            [self.statusMenuItem setTitle:@"Unable to connect."];
            self.isConnected = NO;
            
            NSLog(@"Error: %@", error);
        }
        
        [self updateMenuAppearance];
    }];
    
    [task resume];
}

// Recieves Volume information and applies visual changes depending on the recieved information
-(void)getVolumeInformation {
    NSString *xml = @"<YAMAHA_AV cmd=\"GET\"><Main_Zone><Basic_Status>GetParam</Basic_Status></Main_Zone></YAMAHA_AV>";
    
    // Start the request
    NSMutableURLRequest *urlrequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://192.168.178.26/YamahaRemoteControl/ctrl" parameters:nil error:nil];
    [urlrequest setTimeoutInterval:5];
    [urlrequest setHTTPBody:[NSKeyedArchiver archivedDataWithRootObject:xml]];
    
    AFHTTPSessionManager *smanager = [[AFHTTPSessionManager alloc] init];
    smanager.responseSerializer = [AFHTTPResponseSerializer serializer];
    smanager.responseSerializer.acceptableContentTypes =  [smanager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/xml"];
    
    NSURLSessionDataTask *task = [smanager dataTaskWithRequest:urlrequest completionHandler:^(NSURLResponse* _Nonnull response, id  _Nullable responseObject, NSError* _Nullable error) {
        
        if(!error) {
            NSError *parseerror = nil;
            NSString *fetchedXML = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
            
            NSData *data = [fetchedXML dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *dict = [XMLReader dictionaryForXMLData:data
                                                         options:XMLReaderOptionsProcessNamespaces
                                                           error:&parseerror];
            
            
            NSDictionary *basicStatus = [dict valueForKeyPath:@"YAMAHA_AV.Main_Zone.Basic_Status"];
            NSDictionary *volume = [basicStatus valueForKeyPath:@"Volume"];
            
            self.powerStatus = [basicStatus valueForKeyPath:@"Power_Control.Power.text"];
            self.isConnected = YES;
            
            // Get Volume
            NSString *rawVolLevel = [volume valueForKeyPath:@"Lvl.Val.text"];
            NSNumber *volLevel = [NSNumber numberWithInt: [rawVolLevel intValue]];
            
            // Set slider Volume
            [self.volumeSlider setDoubleValue:[volLevel doubleValue]];
            
            // Set Mute status
            NSString *mute = [volume valueForKeyPath:@"Mute.text"];
            
            if([mute isEqualToString:@"On"]) {
                [self.toggleMuteMenuItem setState:1];
            }
            else {
                [self.toggleMuteMenuItem setState:0];
            }
            
            [self getSystemConfig];
        }
        else {
            [self.statusMenuItem setTitle:@"Unable to connect."];
            self.isConnected = NO;
            
            NSLog(@"Error: %@", error);
        }
        
        [self updateMenuAppearance];
    }];
    
    [task resume];
}

- (IBAction)onVolumeHasChanged:(id)sender {
    double rawSiderValue = [sender doubleValue];
    double sliderValue = rawSiderValue/10;
    double roundedSliderValue = round(sliderValue * 2.0) / 2.0; // round to 0, 0.5, 1 ...
    int dbValue = (roundedSliderValue * 10);
    
    [self.comctrl sendCommand: [NSString stringWithFormat: @"<YAMAHA_AV cmd=\"PUT\"><Main_Zone><Volume><Lvl><Val>%d</Val><Exp>1</Exp><Unit>dB</Unit></Lvl></Volume></Main_Zone></YAMAHA_AV>", dbValue]];
    
    // Force the menu to close itself. This is necessary due to sendCommand limitations :/
    [self cancelTracking];
}

- (IBAction)onToggleMuteClicked:(id)sender {
    if([self.toggleMuteMenuItem state] > 0) {
        [self.toggleMuteMenuItem setState:0];
    }
    else {
        [self.toggleMuteMenuItem setState:1];
    }
    
    [self.comctrl sendCommand:@"<YAMAHA_AV cmd=\"PUT\"><Main_Zone><Volume><Mute>On/Off</Mute></Volume></Main_Zone></YAMAHA_AV>"];
}

- (IBAction)onPreferencesClicked:(id)sender {
 
}

- (IBAction)onQuitPressed:(id)sender {
     [NSApp performSelector:@selector(terminate:) withObject:nil afterDelay:0.0];
}

- (IBAction)onDevicePowerOffClicked:(id)sender {
    [self.comctrl sendCommand:@"<YAMAHA_AV cmd=\"PUT\"><Main_Zone><Power_Control><Power>Standby</Power></Power_Control></Main_Zone></YAMAHA_AV>"];
}

- (IBAction)onDevicePowerOnClicked:(id)sender {
    [self.comctrl sendCommand:@"<YAMAHA_AV cmd=\"PUT\"><Main_Zone><Power_Control><Power>On</Power></Power_Control></Main_Zone></YAMAHA_AV>"];
}


- (void)setMenuItemToBold:(bool)bold forMenuItem:(NSMenuItem *)menuItem {
    NSFont *pFont;
    
    if(bold) {
        pFont = [NSFont boldSystemFontOfSize:14];
    }
    else {
        pFont = [NSFont menuFontOfSize:14];
    }
    
    NSDictionary* fontAttribute = [NSDictionary dictionaryWithObjectsAndKeys: pFont, NSFontAttributeName, nil] ;
    NSMutableAttributedString* newTitle = [[NSMutableAttributedString alloc] initWithString:[menuItem title] attributes:fontAttribute];
    [menuItem setAttributedTitle:newTitle];
}

@end
