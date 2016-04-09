//
//  RouteTableViewCell.swift
//  sthlmmetro
//
//  Created by Rikard Javelind on 09/04/16.
//  Copyright © 2016 Rikard Javelind. All rights reserved.
//

import UIKit
import SwiftyJSON

class RouteTableViewCell: UITableViewCell {

    var routesJson: JSON = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.preservesSuperviewLayoutMargins = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func getHeight() -> CGFloat {
        return CGFloat(routesJson.count) * 70 + 10
    }
    
    override func layoutMarginsDidChange() {
    }
    
    /*
        Draw the lines.
    */
    override func drawRect(rect: CGRect) {
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        
        let md: MetroDrawing = MetroDrawing(withContext: context)
        self.frame.origin.x = 15
        self.frame.size.width = self.bounds.size.width - 30
        //CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor) // vit bakgrund
       // CGContextFillRect(context, self.bounds)
        
        for (index, route): (String, JSON) in routesJson {
            let i = NSInteger(index)!
            
            let fromStation = route["from"].stringValue
            let toStation = route["to"].stringValue
            
            let color = MetroDrawing.lineColorFromString(route["line"].stringValue)
            
            md.drawConnectingLine(1, fromRow: CGFloat(i) * 6 + 1, toColumn: 1, toRow: CGFloat(i) * 6 + 5)
            md.drawStopCircle(color, column: 1, row: CGFloat(i) * 6 + 1)
            md.drawStopCircle(color, column: 1, row: CGFloat(i) * 6 + 5)
            
            md.drawLineText(fromStation, column: 1, row: CGFloat(i) * 6 + 1)
            md.drawLineText("Två minuter (13:37)", column: 18, row: CGFloat(i) * 6 + 1)
            md.drawLineText(toStation, column: 1, row: CGFloat(i) * 6 + 5)
        }
    }
}
