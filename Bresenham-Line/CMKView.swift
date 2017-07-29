//
//  CMKView.swift
//  Bresenham-Line
//
//  Created by Cirno MainasuK on 2017-3-17.
//  Copyright © 2017年 Cirno MainasuK. All rights reserved.
//

import Cocoa

class CMKView: NSView {

    typealias Line = BresenhamLine

    var lines = [Line]()
    var currentLine: Line?

    var runOnce = false
    var circlePoints:[CGPoint] = []
    
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

        if (!runOnce){
            runOnce = true
            
            for i in 0...100{
                circlePoints.append(contentsOf: Bresenham.pointsAlongCircle(xc: 100, yc: 100, r: i))
            }
            
            
        }
        
        // Fill background to white
        context.setFillColor(.white)
        context.fill(bounds)
        context.setFillColor(.black)
        
        // Draw circle from pixels calculated
        context.fillPixels(circlePoints)
        
       
        // Draw lines
        for line in lines {
           let result =  Bresenham.pointsAlongLineBresenham(line)
            context.fillPixels(result)
        }

        if let currentLine = currentLine {
           let result =  Bresenham.pointsAlongLineBresenham(currentLine)
            context.fillPixels(result)
        }
    }

}


extension CGContext {

    func fillPixels(_ pixels: [CGPoint]) {
        for pixel in pixels{
          fill(CGRect(origin: pixel, size: CGSize(width: 1.0, height: 1.0)))
        }
    }
    
    func fill(_ pixel: CGPoint) {
        fill(CGRect(origin: pixel, size: CGSize(width: 1.0, height: 1.0)))
    }
}

