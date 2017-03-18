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

        Swift.print("")
        Swift.print("----- Drawing -----")

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

        guard !line.from.equalTo(line.to) else { return }

        var dx = abs(Int(line.to.x - line.from.x))
        var dy = abs(Int(line.to.y - line.from.y))
        let xSign = Int(line.to.x - line.from.x).sign()
        let ySign = Int(line.to.y - line.from.y).sign()

        // Swap dx, dy
        var isSwap = false
        if dy > dx {
            (dx, dy) = (dy, dx)
            isSwap = true
        }
        var e = 2 * dy - dx

        var x = Int(line.from.x)
        var y = Int(line.from.y)

        for _ in 0...dx {
            fill(CGPoint(x: x, y: y))

            if e >= 0 {
                if isSwap   { x += xSign }
                else        { y += ySign }

                e -= 2 * dx
            }

            if isSwap   { y += ySign }
            else        { x += xSign }

            e += 2 * dy
        }
    }

}
