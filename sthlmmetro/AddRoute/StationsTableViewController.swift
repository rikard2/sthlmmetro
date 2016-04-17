//
//  StationsTableViewController.swift
//  sthlmmetro
//
//  Created by Rikard Javelind on 14/04/16.
//  Copyright © 2016 Rikard Javelind. All rights reserved.
//

import UIKit

class StationsTableViewController: UITableViewController {

    var stations: Array<Station> = []
    var station = Station(name: "")
    
    var myRoute: MyRoute = MyRoute()
    
    var didSelectFrom: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let p = StationsStore.GetStations()
        
        p.then { stations in
            self.reloadStations(stations)
        }
        
        let button = UIBarButtonItem()
        button.title = ""
        
        self.navigationItem.backBarButtonItem = button
        
        self.navigationItem.setRightBarButtonItem(nil, animated: false)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! AddRouteTableViewController
        
        if self.tableView.indexPathForSelectedRow!.section == 0 && self.didSelectFrom {
            self.station = Station(name: "Närmaste station")
            self.station.id = -1
        } else {
            self.station = self.stations[self.tableView.indexPathForSelectedRow!.row]
        }
        
        if self.didSelectFrom {
            self.myRoute.fromStation = self.station.name
            self.myRoute.fromStationId = self.station.id
        } else {
            self.myRoute.toStation = self.station.name
            self.myRoute.toStationId = self.station.id
        }
        
        dest.myRoute = self.myRoute
    }
    
    func reloadStations(stations: Array<Station>) {
        self.stations = stations;
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.didSelectFrom ? 2 : 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && self.didSelectFrom {
            return 1
        }
        
        return self.stations.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 && self.didSelectFrom {
            return ""
        }
        
        return "Stationer"
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("stationCell", forIndexPath: indexPath)

        let stationLabel = cell.viewWithTag(1) as! UILabel
        
        if indexPath.row == 0 && indexPath.section == 0 && self.didSelectFrom {
            stationLabel.text = "Närmaste station"
        } else {
            let station = self.stations[indexPath.row]
            
            stationLabel.text = station.name
        }

        return cell
    }
}
