//
//  MetroDrawing.swift
//  sthlmmetro
//
//  Created by Rikard Javelind on 09/04/16.
//  Copyright © 2016 Rikard Javelind. All rights reserved.
//

import Foundation
import UIKit

class MetroDrawing {
    var greenLineColor: UIColor = MetroDrawing.colorFromRgb(102, g: 153, b: 51)
    var blueLineColor: UIColor = MetroDrawing.colorFromRgb(0, g: 153, b: 153)
    var redLineColor: UIColor = MetroDrawing.colorFromRgb(255, g: 51, b: 102)
    var connectingLineColor: UIColor = MetroDrawing.colorFromRgb(200, g: 200, b: 200)
    var lineTextColor: UIColor = MetroDrawing.colorFromRgb(0, g: 0, b: 0)
    
    var context: CGContextRef
    var width: CGFloat = 10.0
    
    init(withContext: CGContextRef) {
        self.context = withContext
    }
    
    static func colorFromRgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 0.8)
    }
    
    func drawLineText(s: NSString, column: CGFloat, row: CGFloat) {
        
        let textAttributes: [String: AnyObject] = [
            NSForegroundColorAttributeName : lineTextColor,
            NSFontAttributeName : UIFont.systemFontOfSize(17)
        ]
        
        let x = column * width + 20
        let y = row * width - 5
        
        let rect: CGRect = CGRectMake(x, y, 250, 25)
        
        
        s.drawInRect(rect, withAttributes: textAttributes)
    }
    func drawStopCircle(color: UIColor, column: CGFloat, row: CGFloat) -> Void {
        let x: CGFloat = column * width
        let y: CGFloat = row * width
        
        let rect: CGRect = CGRectMake(x, y, width, width)
        
        CGContextSetLineWidth(context, 5)
        CGContextSetStrokeColorWithColor(context, color.CGColor)
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextBeginPath(context)
        CGContextAddEllipseInRect(context, rect)
        
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
    }
    
    func drawConnectingLine(fromColumn: CGFloat, fromRow: CGFloat, toColumn: CGFloat, toRow: CGFloat) {
        CGContextSetLineWidth(context, 10)
        CGContextSetStrokeColorWithColor(context, connectingLineColor.CGColor)
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, fromColumn * width + width / 2, fromRow * width + width / 2)
        CGContextAddLineToPoint(context, toColumn  * width + width / 2, toRow * width + width / 2)
        CGContextStrokePath(context)
    }
}