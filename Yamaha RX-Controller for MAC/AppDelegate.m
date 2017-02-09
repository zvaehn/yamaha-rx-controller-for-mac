//
//  AppDelegate.m
//  Yamaha RX-Controller for MAC
//
//  Created by Sven Schiffer on 08/02/2017.
//  Copyright © 2017 Sven Schiffer. All rights reserved.
//

#import "AppDelegate.h"
#import "StatusBarMenu.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    //  Assign the Menu to the status bar item
    self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusBar.highlightMode = YES;
    self.statusMenu.delegate = self.statusMenu;
    [self.statusBar setMenu:self.statusMenu];
    
    // set menu icon
    NSImage* statusImage = [NSImage imageNamed:@"menu-icon"];
    statusImage.size = NSMakeSize(16.0, 16.0);
    self.statusBar.image = statusImage;
    
    
    // Assign custom view to menu item
    [self.volumeSliderItem setView:self.volumeSliderView];

    //self.cmdcstrl = [[CommunicationController alloc] init];
    
    /*[self.cmdcstrl sendCommand:
     @"<YAMAHA_AV cmd=\"GET\"><System><Config>GetParam</Config></System></YAMAHA_AV>"];*/
    
    /*[self.cmdcstrl sendCommand:
     @"<YAMAHA_AV cmd=\"GET\"><Main_Zone><Basic_Status>GetParam</Basic_Status></Main_Zone></YAMAHA_AV>"];*/
}

/*- (IBAction)onVolumeUpPressed:(id)sender {
    [self.cmdcstrl sendCommand:@"<YAMAHA_AV cmd=\"PUT\"><Main_Zone><Volume><Lvl><Val>Up 2 dB</Val><Exp></Exp><Unit></Unit></Lvl></Volume></Main_Zone></YAMAHA_AV>"];
}

- (IBAction)onVolumeDownPressed:(id)sender {
    [self.cmdcstrl sendCommand:@"<YAMAHA_AV cmd=\"PUT\"><Main_Zone><Volume><Lvl><Val>Down 2 dB</Val><Exp></Exp><Unit></Unit></Lvl></Volume></Main_Zone></YAMAHA_AV>"];
}*/

- (IBAction)onDevicePowerOnPressed:(id)sender {
//     [self.cmdcstrl sendCommand:@"<YAMAHA_AV cmd=\"PUT\"><System><Power_Control><Power>On</Power></Power_Control></System></YAMAHA_AV>"];
}

- (IBAction)onDevicePowerOffPressed:(id)sender {
//    [self.cmdcstrl sendCommand:@"<YAMAHA_AV cmd=\"PUT\"><System><Power_Control><Power>Standby</Power></Power_Control></System></YAMAHA_AV>"];
}



- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}



@end
