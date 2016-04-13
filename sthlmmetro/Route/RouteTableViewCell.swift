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
        
        if (x == 2) {
            return 160;
        }
        
        return CGFloat(x) * 60 + 30;
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
            let rows_height: CGFloat = 7
            
            let color = MetroDrawing.lineColorFromString(route.line)
            md.drawConnectingLine(1, fromRow: CGFloat(i) * rows_height + 1, toColumn: 1, toRow: CGFloat(i) * rows_height + 5)
            md.drawStopCircle(color, column: 1, row: CGFloat(i) * rows_height + 1)
            md.drawStopCircle(color, column: 1, row: CGFloat(i) * rows_height + 5)
            
            md.drawLineText(fromStation, column: 1, row: CGFloat(i) * rows_height + 1)
            let fromTime = dateFormat.stringFromDate(route.fromDate)
            let toTime = dateFormat.stringFromDate(route.toDate)
            md.drawLineText(fromTime, column:27, row: CGFloat(i) * rows_height + 1)
            md.drawLineText(toTime, column: 27, row: CGFloat(i) * rows_height + 5)
            md.drawLineText(toStation, column: 1, row: CGFloat(i) * rows_height + 5)
            
            i = i + 1
        }
    }
}
