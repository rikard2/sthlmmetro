//
//  AddRouteTableViewController.swift
//  sthlmmetro
//
//  Created by Rikard Javelind on 14/04/16.
//  Copyright © 2016 Rikard Javelind. All rights reserved.
//

import UIKit

class AddRouteTableViewController: UITableViewController {

    var myRoute: MyRoute = MyRoute()
    var didSelectFrom: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        
        if myRoute.fromStationId > -2 && myRoute.toStationId > -2 {
            self.navigationItem.rightBarButtonItem?.enabled = true
        }
        
        let button = UIBarButtonItem()
        button.title = ""
        
        self.navigationItem.backBarButtonItem = button
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is StationsTableViewController {
            let stationsView = segue.destinationViewController as! StationsTableViewController
        
            stationsView.didSelectFrom = (self.tableView.indexPathForSelectedRow!.row == 0)
        
            stationsView.myRoute = self.myRoute
        } else {
            MyRoutesStore.addRoute(self.myRoute)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Resa"
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("stationCell", forIndexPath: indexPath)
        
        let directionLabel = cell.viewWithTag(1) as! UILabel
        let stationLabel = cell.viewWithTag(2) as! UILabel
        
        if indexPath.row == 0 {
            directionLabel.text = "Från"
            stationLabel.text = myRoute.fromStation
        } else if indexPath.row == 1 {
            directionLabel.text = "Till"
            stationLabel.text = myRoute.toStation
        }

        return cell
    }
}
