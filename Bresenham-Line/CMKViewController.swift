//
//  ViewController.swift
//  Bresenham-Line
//
//  Created by Cirno MainasuK on 2017-3-17.
//  Copyright © 2017年 Cirno MainasuK. All rights reserved.
//

import Cocoa

class CMKViewController: NSViewController {

    @IBOutlet weak var mouseLocationLabel: NSTextField! {
        didSet { mouseLocationLabel.font = NSFont.monospacedDigitSystemFont(ofSize: mouseLocationLabel.font!.pointSize, weight: NSFontWeightRegular) }
    }

    static let kPenTipWidth: Int = 2 * 5

    var mouseLocation: NSPoint = NSPoint() {
        didSet { mouseLocationLabel.stringValue = mouseLocation.debugDescription }
    }

    var isDebug = true {
        didSet { penTipView.isHidden = !isDebug }
    }

    lazy var penTipView: NSView = {
        let view = NSView(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: kPenTipWidth, height: kPenTipWidth)))
        view.layer = CALayer()
        view.layer?.backgroundColor = NSColor.red.cgColor
        view.layer?.cornerRadius = CGFloat(kPenTipWidth / 2)

        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Just assert the width is a multiple of 2
        assert(type(of: self).kPenTipWidth % 2 == 0)
        view.addSubview(penTipView, positioned: .above, relativeTo: view)
    }



}

extension CMKViewController: CMKMouseTrackDelegate {

    func mouseMoved(with position: NSPoint) {
        let point = position.integral()
        let width = penTipView.bounds.width

        mouseLocation = NSPoint(x: point.x, y: point.y)

        penTipView.frame.origin = CGPoint(x: point.x - width / 2.0, y: point.y - width / 2.0)
        view.setNeedsDisplay(penTipView.frame)
    }
    
}
