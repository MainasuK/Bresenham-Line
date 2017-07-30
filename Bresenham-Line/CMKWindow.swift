//
//  CMKWindow.swift
//  Bresenham-Line
//
//  Created by Cirno MainasuK on 2017-3-17.
//  Copyright © 2017年 Cirno MainasuK. All rights reserved.
//

import Cocoa

class CMKWindow: NSWindow {

    weak var mouseTrackdelegate: CMKMouseTrackDelegate?

    override init(contentRect: NSRect, styleMask style: NSWindowStyleMask, backing bufferingType: NSBackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: bufferingType, defer: flag)

        titleVisibility = .hidden
    }
    
    override func mouseMoved(with event: NSEvent) {
        mouseTrackdelegate?.mouseMoved(with: event.locationInWindow)
    }
    
}
