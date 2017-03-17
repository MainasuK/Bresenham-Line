//
//  NSPoint.swift
//  Bresenham-Line
//
//  Created by Cirno MainasuK on 2017-3-17.
//  Copyright © 2017年 Cirno MainasuK. All rights reserved.
//

import Cocoa

extension NSPoint {

    func integral() -> NSPoint {
        return NSPoint(x: Int(self.x + 0.5), y: Int(self.y + 0.5))
    }

}
