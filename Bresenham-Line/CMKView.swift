//
//  CMKView.swift
//  Bresenham-Line
//
//  Created by Cirno MainasuK on 2017-3-17.
//  Copyright © 2017年 Cirno MainasuK. All rights reserved.
//

import Cocoa

class CMKView: NSView {

    typealias Line = CGContext.BresenhamLine

    var lines = [Line]()
    var currentLine: Line?

    // Optimize the rendering
    override var isOpaque: Bool {
        return true
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        for _ in 0..<3 { Swift.print("") }

        guard let context: CGContext = NSGraphicsContext.current()?.cgContext else {
            consolePrint("Cannot get graphics context")
            return
        }

        // Fill background to white
        context.setFillColor(.white)
        context.fill(bounds)

        context.setFillColor(.black)
        context.setLineWidth(1.0)
        context.setStrokeColor(.black)

        for line in lines {
            context.addLine(line)
        }

        if let currentLine = currentLine {
            context.addLine(currentLine)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension CMKView {

    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)

        let pixel = convert(event.locationInWindow, from: nil).integral()
        currentLine = (pixel, pixel)

        setNeedsDisplay(bounds)
    }

    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        
        let pixel = convert(event.locationInWindow, from: nil).integral()
        currentLine?.1 = pixel

        setNeedsDisplay(bounds)
    }

    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)

        let pixel = convert(event.locationInWindow, from: nil).integral()
        currentLine?.1 = pixel
        currentLine.flatMap { lines.append($0) }

        setNeedsDisplay(bounds)
    }

}
extension CGContext {

    typealias BresenhamLine = (from: CGPoint, to: CGPoint)

    func fill(_ pixel: CGPoint) {
        fill(CGRect(origin: pixel, size: CGSize(width: 1.0, height: 1.0)))
    }

    func addLine(_ line: BresenhamLine) {
        consolePrint("Draw bresenham line from \(line.0) to \(line.1)")
    }

}
