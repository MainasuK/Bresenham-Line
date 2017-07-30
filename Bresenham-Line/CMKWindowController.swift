//
//  WindowViewController.swift
//  Bresenham-Line
//
//  Created by Cirno MainasuK on 2017-3-17.
//  Copyright © 2017年 Cirno MainasuK. All rights reserved.
//

import Cocoa

class CMKWindowController: NSWindowController {

    weak var colorsPickerDelegate: CMKColorsPickerDelegate?

    override func windowDidLoad() {
        super.windowDidLoad()

        guard let controller = contentViewController as? CMKViewController,
            let window = window as? CMKWindow else {
            return
        }

        colorsPickerDelegate = controller

        window.mouseTrackdelegate = controller
        window.acceptsMouseMovedEvents = true
    }

    override func changeColor(_ sender: Any?) {
        guard let colorPanel = sender as? NSColorPanel else { return }
        colorsPickerDelegate?.pick(color: colorPanel.color)
    }
    
}
