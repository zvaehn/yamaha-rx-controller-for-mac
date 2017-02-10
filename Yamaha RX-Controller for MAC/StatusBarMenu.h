//
//  StatusBarMenu.h
//  Yamaha RX-Controller for MAC
//
//  Created by Sven Schiffer on 08/02/2017.
//  Copyright © 2017 Sven Schiffer. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CommunicationController.h"
#import "StatusBarMenu.h"

@interface StatusBarMenu : NSMenu <NSMenuDelegate>

@property CommunicationController *comctrl;
@property BOOL isConnected;

@property (weak) IBOutlet NSView *volumeSliderView;
@property (weak) IBOutlet NSMenuItem *statusMenuItem;
@property (weak) IBOutlet NSSlider *volumeSlider;
@property (weak) IBOutlet NSMenuItem *toggleMuteMenuItem;
@property (weak) IBOutlet NSMenuItem *deviceMenuItem;

- (IBAction)onVolumeHasChanged:(id)sender;
- (IBAction)onToggleMuteClicked:(id)sender;
- (IBAction)onPreferencesClicked:(id)sender;
- (IBAction)onQuitPressed:(id)sender;
- (IBAction)onDevicePowerOnClicked:(id)sender;
- (IBAction)onDevicePowerOffClicked:(id)sender;



@end
