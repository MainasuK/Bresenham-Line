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

    var penRadius: CGFloat = 4.0 {
        didSet {
            window?.invalidateCursorRects(for: self)
        }
    }
    var penColor: NSColor = .black {
        didSet {
            window?.invalidateCursorRects(for: self)
        }
    }

    var lines = [Line]()
    var currentLine: Line?

    var runOnce = false
    var circlePoints:[CGPoint] = []
    var circleMidPoints:[CGPoint] = []
    var octantPoints:[CGPoint] = []

    // Optimize the rendering
    override var isOpaque: Bool {
        return true
    }

    
    func preCalculateCirclePoints(){
        for i in 0...2 {
            let pts = Bresenham.pointsAlongCircle(xc: 0, yc: 0, r: i*150)
            circlePoints.append(contentsOf: pts)
        }
        
        for i in 0...3{
            let pts = Bresenham.pointsAlongMidPoint(xc: 300, yc: 300, r: i*80)
            circleMidPoints.append(contentsOf: pts)
        }
        
        // Arcs + octants
        let x = 0
        let y = 0
        var r = 2
        while(true) {

            let pts = Bresenham.pointsForOctants(xc: x, yc: y, radialRange: Array(r...r),octants: [0,1])
            octantPoints.append(contentsOf: pts)
            if (r>1100){
                break
            }
            r = r*2
            
        }
        

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
            preCalculateCirclePoints()
        }
        
        // Fill background to white
        context.setFillColor(.white)
        context.fill(bounds)

       
        // Draw lines
        for line in lines {
            let pts = Bresenham.pointsAlongLineBresenham(line)
            context.setFillColor(line.color.cgColor)
            context.fillPixels(pts)
        }

        if let currentLine = currentLine {
            let pts =  Bresenham.pointsAlongLineBresenham(currentLine)
            context.setFillColor(currentLine.color.cgColor)
            context.fillPixels(pts)
        }
        
        context.setFillColor(NSColor.lightGray.cgColor)
        
        // Draw circle
        context.fillPixels(circlePoints)
        
        // Mid point algorithm
        context.fillPixels(circleMidPoints)
        
        // octant segments
        context.setFillColor(NSColor.blue.cgColor)
        context.fillPixels(octantPoints)
        
        
    }

}

extension CGContext {

    func fillPixels(_ pixels: [CGPoint]) {
        var size:CGSize?
        if Screen.retinaScale > 1 {
            size = CGSize(width: 1.5, height: 1.5)
        } else {
            size = CGSize(width: 1.0, height: 1.0)
        }

        for pixel in pixels {
          fill(CGRect(origin: pixel, size: size!))
        }
    }
    
    func fill(_ pixel: CGPoint) {
        fill(CGRect(origin: pixel, size: CGSize(width: 1.0, height: 1.0)))
    }
}

