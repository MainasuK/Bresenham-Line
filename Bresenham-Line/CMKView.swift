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
                let pts = Bresenham.pointsAlongCircle(xc: 100, yc: 100, r: i)
                circlePoints.append(contentsOf: pts)
            }
        }
        
        // Fill background to white
        context.setFillColor(.white)
        context.fill(bounds)
        context.setFillColor(.black)

       
        // Draw lines
        for line in lines {
           let pts =  Bresenham.pointsAlongLineBresenham(line)
            context.fillPixels(pts)
        }

        if let currentLine = currentLine {
           let pts =  Bresenham.pointsAlongLineBresenham(currentLine)
            context.fillPixels(pts)
        }
        
        // Draw circle
        context.fillPixels(circlePoints)
        
        // Mid point algorithm
        // context.setFillColor(.red)
        let pts = Bresenham.pointsAlongMidPoint(xc: 200, yc: 200, r: 50)
        context.fillPixels(pts)
        
    }

}


extension CGContext {

    func fillPixels(_ pixels: [CGPoint]) {
        var size:CGSize?
        if Screen.retinaScale > 1{
            size = CGSize(width: 2.0, height: 2.0)
        }else{
            size = CGSize(width: 1.0, height: 1.0)
        }

        for pixel in pixels{
          fill(CGRect(origin: pixel, size: size!))
        }
    }
    
    func fill(_ pixel: CGPoint) {
        fill(CGRect(origin: pixel, size: CGSize(width: 1.0, height: 1.0)))
    }
}

