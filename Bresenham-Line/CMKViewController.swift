//
//  ViewController.swift
//  Bresenham-Line
//
//  Created by Cirno MainasuK on 2017-3-17.
//  Copyright © 2017年 Cirno MainasuK. All rights reserved.
//

import Cocoa

class CMKViewController: NSViewController {

    @IBOutlet var drawBoardView: CMKView!
    @IBOutlet weak var mouseLocationLabel: NSTextField! {
        didSet { mouseLocationLabel.font = NSFont.monospacedDigitSystemFont(ofSize: mouseLocationLabel.font!.pointSize, weight: NSFontWeightRegular) }
    }

    var mouseLocation: NSPoint = NSPoint() {
        didSet { mouseLocationLabel.stringValue = mouseLocation.debugDescription }
    }

}

// MAKR: - CMKMouseTrackDelegate
extension CMKViewController: CMKMouseTrackDelegate {

    func mouseMoved(with position: NSPoint) {
        let point = position.integral()

        mouseLocation = NSPoint(x: point.x, y: point.y)
    }
    
}

extension CMKViewController {

    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)

        let point = event.locationInWindow.integral()
        mouseLocation = NSPoint(x: point.x, y: point.y)
    }
}

// MARK: - CMKColorsPickerDelegate
extension CMKViewController: CMKColorsPickerDelegate {

    func pick(color: NSColor) {
        consolePrint("Pick \(color)")
        drawBoardView.pick(color: color)
    }

}
