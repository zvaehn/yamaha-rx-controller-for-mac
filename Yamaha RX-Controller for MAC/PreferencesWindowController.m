//
//  PreferencesWindowController.m
//  Yamaha RX-Controller for MAC
//
//  Created by Sven Schiffer on 10/02/2017.
//  Copyright © 2017 Sven Schiffer. All rights reserved.
//

#import "PreferencesWindowController.h"

@interface PreferencesWindowController ()

@end

@implementation PreferencesWindowController

-(id) init {
    self = [super initWithWindowNibName:@"PreferencesWindowController"];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    [self showWindow:self.preferencesView];
        
    if(self == nil){
        return nil;
    }
    
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    [NSApp activateIgnoringOtherApps:YES];
    
    NSString *recieverIp = [self.userDefaults stringForKey:@"reciever-ip"];
    
    if(recieverIp) {
        [self.ipTextField setStringValue:recieverIp];
    }
}

- (IBAction)onCancelPressed:(id)sender {
    NSWindow *window = [[NSApplication sharedApplication] keyWindow];
    [window close];
    [self close];
}

- (IBAction)onApplyPressed:(id)sender {
    NSString *recieverIp = [self.ipTextField stringValue];
    
    [self.userDefaults setObject: recieverIp forKey:@"reciever-ip"];
    [self.userDefaults synchronize];
    
    NSWindow *window = [[NSApplication sharedApplication] keyWindow];
    [window close];
    [self close];
}

@end
