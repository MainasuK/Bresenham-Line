//
//  Created by Cirno MainasuK on 2017-3-17.
//  Copyright © 2017年 Cirno MainasuK. All rights reserved.
//


import Foundation
import Cocoa


typealias BresenhamLine = (from: CGPoint, to: CGPoint)

class Bresenham:NSObject{
    
    class func pointsAlongLineBresenham(_ line: BresenhamLine)->[CGPoint] {
        consolePrint("Draw bresenham line from \(line.0) to \(line.1)")
        var result: [CGPoint] = []
        guard !line.from.equalTo(line.to) else { return []}
        
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
            let pt = CGPoint(x: x, y: y)
            result.append(pt)
            
            if e >= 0 {
                if isSwap   { x += xSign }
                else        { y += ySign }
                
                // if e >= 0, then minus 2dx
                e -= 2 * dx
            }
            
            if isSwap   { y += ySign }
            else        { x += xSign }
            
            // always plus 2dy
            e += 2 * dy
        }
        return result
    }
    

    // https://en.wikipedia.org/wiki/Midpoint_circle_algorithm
    class func pointsAlongMidPoint( xc:Int,  yc:Int,  r:Int)-> [CGPoint]{
        var  x = 0
        var  y = r
        var  d = 1 -  r
        var result: [CGPoint] = []
        
        while(x <= y){
            x = x + 1
            if(d < 0){
              d = d + 2 * x + 1
            } else{
                y = y - 1;
                d = d + 2 * (x - y) + 1
            }
            result.append(CGPoint(x:xc + x,y:yc + y))
            result.append(CGPoint(x:xc + x,y:yc - y))
            result.append(CGPoint(x:xc - x,y:yc + y))
            result.append(CGPoint(x:xc - x,y:yc - y))
            
            result.append(CGPoint(x:xc + y,y:yc + x))
            result.append(CGPoint(x:xc + y,y:yc - x))
            result.append(CGPoint(x:xc - y,y:yc + x))
            result.append(CGPoint(x:xc - y,y:yc - x))
         
            
        }
        return result
        
    }
    class func  pointsAlongCircle( xc:Int,  yc:Int,  r:Int)-> [CGPoint]
    {
        var  x = 0
        var  y = r
        var  d = 3 - 2 * r
        
        var result: [CGPoint] = []
        
        while(x <= y)
        {
            result.append(CGPoint(x:xc + x,y:yc + y))
            result.append(CGPoint(x:xc + x,y:yc - y))
            result.append(CGPoint(x:xc - x,y:yc + y))
            result.append(CGPoint(x:xc - x,y:yc - y))
            
            result.append(CGPoint(x:xc + y,y:yc + x))
            result.append(CGPoint(x:xc + y,y:yc - x))
            result.append(CGPoint(x:xc - y,y:yc + x))
            result.append(CGPoint(x:xc - y,y:yc - x))
            
            if (d < 0){
                d = d + 4*x + 6;
            } else {
                d = d + 4*(x-y) + 10;
                y = y-1;
            }
            x = x + 1;
        }
        return result
    }
    
}
