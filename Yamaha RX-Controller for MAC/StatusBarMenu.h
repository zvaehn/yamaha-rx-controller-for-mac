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
#import "PreferencesWindowController.h"

@interface StatusBarMenu : NSMenu <NSMenuDelegate>

@property CommunicationController *comctrl;
@property PreferencesWindowController *prefWinCon;
@property BOOL isConnected;
@property NSString *powerStatus;
@property NSString *versionNumber;
@property NSString *modelNumber;


// Main Menu
@property (weak) IBOutlet NSView *volumeSliderView;
@property (weak) IBOutlet NSMenuItem *statusMenuItem;
@property (weak) IBOutlet NSSlider *volumeSlider;
@property (weak) IBOutlet NSMenuItem *toggleMuteMenuItem;
@property (weak) IBOutlet NSMenuItem *volumeSliderItem;

// Device Submenu
@property (weak) IBOutlet NSMenuItem *deviceMenuItem;
@property (weak) IBOutlet NSMenuItem *deviceInfoMenuItem;
@property (weak) IBOutlet NSMenuItem *devicePowerOnMenuItem;
@property (weak) IBOutlet NSMenuItem *devicePowerOffMenuItem;

- (IBAction)onVolumeHasChanged:(id)sender;
- (IBAction)onToggleMuteClicked:(id)sender;
- (IBAction)onPreferencesClicked:(id)sender;
- (IBAction)onQuitPressed:(id)sender;
- (IBAction)onDevicePowerOnClicked:(id)sender;
- (IBAction)onDevicePowerOffClicked:(id)sender;



@end
