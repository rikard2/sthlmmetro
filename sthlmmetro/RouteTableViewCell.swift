//
//  RouteTableViewCell.swift
//  sthlmmetro
//
//  Created by Rikard Javelind on 09/04/16.
//  Copyright © 2016 Rikard Javelind. All rights reserved.
//

import UIKit

class RouteTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func drawRect(rect: CGRect) {
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        
        let md: MetroDrawing = MetroDrawing(withContext: context)
        
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor) // vit bakgrund
        CGContextFillRect(context, self.bounds)
        
        md.drawConnectingLine(1, fromRow: 1, toColumn: 1, toRow: 6)
        md.drawConnectingLine(1, fromRow: 8, toColumn: 1, toRow: 12)
        
        md.drawStopCircle(md.greenLineColor, column: 1, row: 1)
        md.drawStopCircle(md.greenLineColor, column: 1, row: 6)
        
        md.drawLineText("Blåsut", column: 1, row: 1)
        md.drawLineText("Slussen", column: 1, row: 6)
        
        md.drawStopCircle(md.redLineColor, column: 1, row: 8)
        md.drawStopCircle(md.redLineColor, column: 1, row: 12)
        md.drawLineText("Slussen", column: 1, row: 8)
        md.drawLineText("Mariatorget", column: 1, row: 12)
    }
}
