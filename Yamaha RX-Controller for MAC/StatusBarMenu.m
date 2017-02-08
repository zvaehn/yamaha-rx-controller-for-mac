//
//  StatusBarMenu.m
//  Yamaha RX-Controller for MAC
//
//  Created by Sven Schiffer on 08/02/2017.
//  Copyright © 2017 Sven Schiffer. All rights reserved.
//

#import "StatusBarMenu.h"

@implementation StatusBarMenu

- (void)menuWillOpen:(StatusBarMenu *)menu {
    NSLog(@"menu opened");
}

- (void)menuDidClose:(NSMenu *)menu {
    NSLog(@"menu closed");
}

- (void)viewDidLoad{
    NSLog(@"menu asdasdasda");
}

@end
