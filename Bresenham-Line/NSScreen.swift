//
//  NSScreen.swift
//  Bresenham-Line
//
//  Created by Cirno MainasuK on 2017-7-30.
//  Copyright © 2017年 Cirno MainasuK. All rights reserved.
//

import Cocoa

public typealias Screen = NSScreen

extension NSScreen {
    static var retinaScale: CGFloat {
        return NSScreen.main()!.backingScaleFactor
    }
}
