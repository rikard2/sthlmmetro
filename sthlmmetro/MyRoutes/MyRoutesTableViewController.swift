//
//  MyRoutesTableViewController.swift
//  sthlmmetro
//
//  Created by Rikard Javelind on 09/04/16.
//  Copyright © 2016 Rikard Javelind. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyRoutesTableViewController: UITableViewController {
    var myRoutes: Array<MyRoute> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selection" {
            let selectedRoute = sender as! MyRoute
            let view: RouteTableViewController = segue.destinationViewController as! RouteTableViewController
            
            view.myRoute = selectedRoute
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.myRoutes = MyRoutesStore.getMyRoutes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRoutes.count
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        MyRoutesStore.deleteRoute(indexPath.row)
        self.myRoutes = MyRoutesStore.getMyRoutes()
        
        self.tableView.reloadData()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("stationCell", forIndexPath: indexPath)
        let text: UILabel = cell.viewWithTag(1) as! UILabel
        let myRoute = self.myRoutes[indexPath.row]
        let from = myRoute.fromStation
        let to = myRoute.toStation
        
        text.text = String(format: "%@ → %@", from, to)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let route = self.myRoutes[indexPath.row]
        
        self.performSegueWithIdentifier("selection", sender: route)
    }
}
