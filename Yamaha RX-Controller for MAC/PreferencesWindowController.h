//
//  PreferencesWindowController.h
//  Yamaha RX-Controller for MAC
//
//  Created by Sven Schiffer on 10/02/2017.
//  Copyright © 2017 Sven Schiffer. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferencesWindowController : NSWindowController

@property (weak) IBOutlet NSView *preferencesView;

// Defaults declarations
@property NSString *defaultsRecieverIpKey;


@property NSUserDefaults *userDefaults;
@property (weak) IBOutlet NSTextField *ipTextField;
@property (weak) IBOutlet NSTextField *statusLabel;

- (IBAction)onCancelPressed:(id)sender;
- (IBAction)onApplyPressed:(id)sender;


@end
