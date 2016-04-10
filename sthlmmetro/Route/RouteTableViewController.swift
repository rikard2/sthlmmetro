//
//  RouteTableViewController.swift
//  sthlmmetro
//
//  Created by Rikard Javelind on 09/04/16.
//  Copyright © 2016 Rikard Javelind. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit

class RouteTableViewController: UITableViewController {

    var routes: Array<Array<Route>> = [[]]
    
    override func viewDidLoad() {
        self.tableView.separatorColor = UIColor.clearColor()
        self.tableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        self.tableView.separatorInset = UIEdgeInsetsMake(50, 0, 50, 0)
        
        self.title = "Blåsut → Kungsträdgården"
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        RouteStore.GetRoutes().then { routes in
            self.refreshRoutes(routes)
        }
    }
    
    func refreshRoutes(r: Array<Array<Route>>) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        self.routes = r
        self.tableView.reloadData()
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return routes.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let u = UIView()
        u.backgroundColor = UIColor.clearColor()
        
        return u
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let routeCell: RouteTableViewCell = RouteTableViewCell()
        routeCell.indentationLevel = 2
        
        routeCell.routes = self.routes[indexPath.section]
        
        let layer = routeCell.layer
        layer.cornerRadius = 4
        
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 40
        layer.shadowOffset = CGSizeMake(1, 1)
        layer.backgroundColor = UIColor.whiteColor().CGColor
        layer.masksToBounds = true
        
        routeCell.contentView.layoutMargins = UIEdgeInsetsMake(0, 15, 0, 15)
        routeCell.frame = CGRectMake(15, 15, 100, 100)
        routeCell.contentView.frame = CGRectMake(15, 15, 100, 100)
        routeCell.bounds.origin.x = -10
        routeCell.bounds.origin.y = -10
        
        return routeCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let routeCell: RouteTableViewCell = RouteTableViewCell()
        routeCell.routes = self.routes[indexPath.section]
        

        return routeCell.getHeight()
    }
}