//
//  AppDelegate.h
//  Yamaha RX-Controller for MAC
//
//  Created by Sven Schiffer on 08/02/2017.
//  Copyright © 2017 Sven Schiffer. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CommunicationController.h"
#import "StatusBarMenu.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

// Status Bar
@property CommunicationController *cmdcstrl;

@property (strong, nonatomic) NSStatusItem *statusBar;
@property (weak) IBOutlet StatusBarMenu *statusMenu;
@property (weak) IBOutlet NSMenuItem *volumeSliderItem;
@property (weak) IBOutlet NSView *volumeSliderView;

- (IBAction)onToggleMutePressed:(id)sender;
- (IBAction)onVolumeUpPressed:(id)sender;
- (IBAction)onVolumeDownPressed:(id)sender;
- (IBAction)onPreferencesPressed:(id)sender;
- (IBAction)onQuitPressed:(id)sender;
- (IBAction)onDevicePowerOnPressed:(id)sender;
- (IBAction)onDevicePowerOffPressed:(id)sender;
- (IBAction)volumeSliderHasChanged:(id)sender;



@end

