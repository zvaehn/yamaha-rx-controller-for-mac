//
//  StatusBarMenu.m
//  Yamaha RX-Controller for MAC
//
//  Created by Sven Schiffer on 08/02/2017.
//  Copyright © 2017 Sven Schiffer. All rights reserved.
//

#import "StatusBarMenu.h"
#import "CommunicationController.h"

@implementation StatusBarMenu

- (void)awakeFromNib {
    self.cmdcstrl = [[CommunicationController alloc] init];
}

- (void)menuWillOpen:(NSMenu *)menu {
    
}

- (void)menuDidClose:(NSMenu *)menu {
    
}


- (IBAction)onVolumeHasChanged:(id)sender {
    int dbValue = 70 - [sender intValue];
    
    [self.cmdcstrl sendCommand: [NSString stringWithFormat: @"<YAMAHA_AV cmd=\"PUT\"><Main_Zone><Volume><Lvl><Val>-%d0</Val><Exp>1</Exp><Unit>dB</Unit></Lvl></Volume></Main_Zone></YAMAHA_AV>", dbValue]];
}

- (IBAction)onToggleMuteClicked:(id)sender {
    NSLog(@"mute clicked");
    [self.cmdcstrl sendCommand:@"<YAMAHA_AV cmd=\"PUT\"><Main_Zone><Volume><Mute>On/Off</Mute></Volume></Main_Zone></YAMAHA_AV>"];
}

- (IBAction)onPreferencesClicked:(id)sender {
    NSLog(@"pref clicked");
}

- (IBAction)onQuitPressed:(id)sender {
     [NSApp performSelector:@selector(terminate:) withObject:nil afterDelay:0.0];
}

@end
