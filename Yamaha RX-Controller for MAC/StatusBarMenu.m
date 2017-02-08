//
//  StatusBarMenu.m
//  Yamaha RX-Controller for MAC
//
//  Created by Sven Schiffer on 08/02/2017.
//  Copyright © 2017 Sven Schiffer. All rights reserved.
//

#import "StatusBarMenu.h"

@implementation StatusBarMenu

- (void)menuWillOpen:(NSMenu *)menu {
    NSLog(@"open");
}

- (void)menuDidClose:(NSMenu *)menu {
    NSLog(@"close");
}

@end
