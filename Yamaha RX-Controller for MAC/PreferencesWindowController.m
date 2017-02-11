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
    if(self == nil){
        return nil;
    }
    
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
//    [NSApp activateIgnoringOtherApps:YES];
    
    //Open the preferences Window
    [self showWindow:self.preferencesView];
    
    
    NSLog(@"pref loaded");
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
