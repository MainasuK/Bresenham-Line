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
        currentLine?.to = pixel

        setNeedsDisplay(bounds)
    }

    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)

        let pixel = convert(event.locationInWindow, from: nil).integral()
        currentLine?.to = pixel
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
        let dx = Int(line.to.x - line.from.x)
        let dy = Int(line.to.y - line.from.y)
        var e = 2 * dy - dx

        // Draw start pixel
        fill(line.from)

        // Draw othe pixel
        let xEnd = Int(line.to.x)
        var x = Int(line.from.x)
        var y = Int(line.from.y)

        while (x <= xEnd) {
            x += 1
            y = (e >= 0) ? y + 1 : y

            fill(CGPoint(x: x, y: y))
            
            e = (e >= 0) ? (e + 2 * dy - 2 * dx) : (e + 2 * dy)
        }
    }

}
