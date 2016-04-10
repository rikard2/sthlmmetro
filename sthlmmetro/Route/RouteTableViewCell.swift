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

    var routes: Array<Route> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.preservesSuperviewLayoutMargins = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func getHeight() -> CGFloat {
        let x = self.routes.count
        
        return CGFloat(x) * 70                                                                                    
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
        
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "HH:mm"
        
        var i = 0
        for route in routes {
            let fromStation = route.fromStation
            let toStation = route.toStation
            
            let color = MetroDrawing.lineColorFromString(route.line)
            
            md.drawConnectingLine(1, fromRow: CGFloat(i) * 6 + 1, toColumn: 1, toRow: CGFloat(i) * 6 + 5)
            md.drawStopCircle(color, column: 1, row: CGFloat(i) * 6 + 1)
            md.drawStopCircle(color, column: 1, row: CGFloat(i) * 6 + 5)
            
            md.drawLineText(fromStation, column: 1, row: CGFloat(i) * 6 + 1)
            let fromTime = dateFormat.stringFromDate(route.fromDate)
            let toTime = dateFormat.stringFromDate(route.toDate)
            md.drawLineText(fromTime, column: 18, row: CGFloat(i) * 6 + 1)
            md.drawLineText(toTime, column: 18, row: CGFloat(i) * 6 + 5)
            md.drawLineText(toStation, column: 1, row: CGFloat(i) * 6 + 5)
            
            i = i + 1
        }
    }
}
