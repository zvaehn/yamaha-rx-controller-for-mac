//
//  StatusBarMenu.h
//  Yamaha RX-Controller for MAC
//
//  Created by Sven Schiffer on 08/02/2017.
//  Copyright © 2017 Sven Schiffer. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StatusBarMenu : NSMenu <NSMenuDelegate>

@property (weak) IBOutlet NSView *volumeSliderView;
@property (weak) IBOutlet NSSlider *volumeSlider;

@end
