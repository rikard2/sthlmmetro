//
//  RouteTableViewController.swift
//  sthlmmetro
//
//  Created by Rikard Javelind on 09/04/16.
//  Copyright © 2016 Rikard Javelind. All rights reserved.
//

import UIKit
import SwiftyJSON

class RouteTableViewController: UITableViewController {

    var routesContents = [
        [
            [
                "from": "Blåsut",
                "to": "Medis",
                "line": "green"
            ],
            [
                "from": "Medis",
                "to": "Hornstull",
                "line": "red"
            ]
        ]
    ]
    var routesJson: JSON = []
    
    override func viewDidLoad() {
        routesJson = JSON(routesContents)
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Avgångar"
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routesContents.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let routeCell: RouteTableViewCell = RouteTableViewCell()
        
        routeCell.routesJson = self.routesJson[indexPath.row]
        print(routeCell.routesJson)
        
        return routeCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let routeCell: RouteTableViewCell = RouteTableViewCell()
        routeCell.routesJson = self.routesJson[indexPath.row]

        return routeCell.getHeight()
    }
}