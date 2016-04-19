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
    var errorMessage: String? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.preservesSuperviewLayoutMargins = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update() {
        print("updating cell...")
    }
    
    func getHeight() -> CGFloat {
        if self.errorMessage != nil {
            return 80
        }
        
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
        md.cellWidth = self.frame.size.width
        self.frame.origin.x = 15
        self.frame.size.width = self.bounds.size.width - 30
        
        if errorMessage != nil {
            md.drawLineText(self.errorMessage!, column:1, row: 2)
            
            return
        }
        
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
            
            let outFormatter = NSDateFormatter()
            outFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            outFormatter.dateFormat = "mm:ss"
            let now = NSDate()
            var time = route.fromDate.offsetFrom(now)
            
            let offsetFromMinutes = route.fromDate.offsetFromMinutes(now)
            let offsetFromSeconds = route.fromDate.offsetFromSeconds(now)
            
            if offsetFromMinutes >=  8 {
                time = ""
            }
            
            var timeLeftColor = UIColor.lightTextColor()
            
            if (offsetFromMinutes <= 3) {
                timeLeftColor = UIColor.redColor()
            } else {
                timeLeftColor = UIColor.lightGrayColor()
            }
            
            if offsetFromSeconds <= 0 && offsetFromMinutes == 0 {
                time = "Nyss"
                timeLeftColor = UIColor.lightGrayColor()
            }
            
            md.drawLineText(time, column:20, row: CGFloat(i) * rows_height + 1, color: timeLeftColor)
            
            md.drawLineText(fromTime, column:27, row: CGFloat(i) * rows_height + 1)
            md.drawLineText(toTime, column: 27, row: CGFloat(i) * rows_height + 5)
            md.drawLineText(String(format: "%@ (%@)", toStation, route.lineNumber), column: 1, row: CGFloat(i) * rows_height + 5)
            
            i = i + 1
        }
    }
}

extension NSDate {
    
    func offsetFrom(date:NSDate) -> String {
        
        let dayHourMinuteSecond: NSCalendarUnit = [.Day, .Hour, .Minute, .Second]
        let difference = NSCalendar.currentCalendar().components(dayHourMinuteSecond, fromDate: date, toDate: self, options: [])
        
        let seconds = "\(difference.second)s"
        let minutes = "\(difference.minute)m" + " " + seconds
        let hours = "\(difference.hour)h" + " " + minutes
        let days = "\(difference.day)d" + " " + hours
        
        if difference.day    > 0 { return days }
        if difference.hour   > 0 { return "" }
        if difference.minute > 0 { return minutes }
        if difference.second > 0 { return seconds }
        return ""
    }
    
    func offsetFromMinutes(date:NSDate) -> Int {
        
        let dayHourMinuteSecond: NSCalendarUnit = [.Day, .Hour, .Minute, .Second]
        let difference = NSCalendar.currentCalendar().components(dayHourMinuteSecond, fromDate: date, toDate: self, options: [])
        
        return difference.minute
    }
    
    func offsetFromSeconds(date:NSDate) -> Int {
        
        let dayHourMinuteSecond: NSCalendarUnit = [.Day, .Hour, .Minute, .Second]
        let difference = NSCalendar.currentCalendar().components(dayHourMinuteSecond, fromDate: date, toDate: self, options: [])
        
        return difference.second
    }
    
}
