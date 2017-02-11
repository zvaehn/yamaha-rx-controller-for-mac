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
    statusImage.size = NSMakeSize(20.0, 18.0);
    self.statusBar.image = statusImage;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}



@end
