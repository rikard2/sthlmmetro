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
    static var greenLineColor: UIColor = MetroDrawing.colorFromRgb(17, g: 182, b: 15)
    static var blueLineColor: UIColor = MetroDrawing.colorFromRgb(27, g: 127, b: 247)
    static var redLineColor: UIColor = MetroDrawing.colorFromRgb(252, g: 17, b: 35)
    static var connectingLineColor: UIColor = MetroDrawing.colorFromRgb(230, g: 230, b: 230)
    static var lineTextColor: UIColor = MetroDrawing.colorFromRgb(0, g: 0, b: 0)
    
    var context: CGContextRef
    var width: CGFloat = 10.0
    var cellWidth: CGFloat = 200;
    
    init(withContext: CGContextRef) {
        self.context = withContext
    }
    
    static func colorFromRgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 0.8)
    }
    
    static func lineColorFromString(line: NSString) -> UIColor {
        if (line == "green") {
            return greenLineColor
        } else if (line == "blue") {
            return blueLineColor
        }
        
        return redLineColor
    }
    
    func drawLineText(s: NSString, column: CGFloat, row: CGFloat, color: UIColor) {
        
        let f = UIFont(name: "Avenir-Medium", size: 18)!
        
        let textAttributes: [String: AnyObject] = [
            NSForegroundColorAttributeName : color,
            NSFontAttributeName : f
        ]
        
        var x = column * width + 27
        var textWidth: CGFloat = 250
        let y = row * width - 7
        
        if column == 27 {
            x = self.cellWidth - 75
            textWidth = 75
        }
        
        if column == 20 {
            x = self.cellWidth - 150
            textWidth = 75
        }
        
        let rect: CGRect = CGRectMake(x, y, textWidth, 25)
        
        s.drawInRect(rect, withAttributes: textAttributes)
    }
    
    func drawLineText(s: NSString, column: CGFloat, row: CGFloat) {
        self.drawLineText(s, column: column, row: row, color: MetroDrawing.lineTextColor)
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
        CGContextSetStrokeColorWithColor(context, MetroDrawing.connectingLineColor.CGColor)
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, fromColumn * width + width / 2, fromRow * width + width / 2)
        CGContextAddLineToPoint(context, toColumn  * width + width / 2, toRow * width + width / 2)
        CGContextStrokePath(context)
    }
}