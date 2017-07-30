//
//  NSCursor.swift
//  Bresenham-Line
//
//  Created by Cirno MainasuK on 2017-7-30.
//  Copyright © 2017年 Cirno MainasuK. All rights reserved.
//

import Cocoa

extension NSCursor {

    public convenience init(radius: CGFloat, color: NSColor) {
        let size = NSSize(width: 2 * radius, height: 2 * radius)
        let image = NSImage(size: size)
        let path = NSBezierPath(roundedRect: NSRect(origin: .zero, size: size), xRadius: radius, yRadius: radius)

        // Set fill color
        image.lockFocus()
        color.setFill()
        path.fill()
        image.unlockFocus()

        self.init(image: image, hotSpot: NSPoint(x: radius, y: radius))
    }
}
