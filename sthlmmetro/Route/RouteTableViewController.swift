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
import PullToRefresh
import CoreLocation

class RouteTableViewController: UITableViewController {

    var routes: Array<Array<Route>> = [[]]
    var fromStation: Station = Station(name: "from")
    var toStation: Station = Station(name: "to")
    var myRoute: MyRoute = MyRoute()
    var locationManager = CLLocationManager()
    
    var isError: Bool = false
    var errorMessage: String = "qweqweeqw"
    
    override func viewDidLoad() {        self.tableView.separatorColor = UIColor.clearColor()
        self.tableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let refreshener = PullToRefresh()
        
        self.navigationController?.navigationBar.translucent = false
        
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        let button = UIBarButtonItem()
        button.title = ""
        
        self.navigationItem.backBarButtonItem = button
        
        requestLocation()
        
        tableView.addPullToRefresh(refreshener, action: {
            self.pullRefresh()
        });
        
        RouteStore.GetRoutes(self.myRoute).then { routes in
            self.refreshRoutes(routes)
        }.error { error in
            if (error is RouteError) {
                if error as! RouteError == RouteError.STATIONS_TOO_CLOSE {
                    self.errorMessage = "För nära slutstationen."
                } else if error as! RouteError == RouteError.NO_INTERNET {
                    self.errorMessage = "Ingen internetuppkoppling."
                } else if error as! RouteError == RouteError.UNKNOWN {
                    self.errorMessage = "Okänt fel."
                }
            } else {
                self.errorMessage = "Ingen internetuppkoppling."
            }
            
            self.isError = true
            
            self.tableView.reloadData()
        }
    }
    
    func pullRefresh() {
        requestLocation()
        
        RouteStore.GetRoutes(self.myRoute).then { routes in
            self.refreshRoutes(routes)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = String(format: "%@ → %@", self.myRoute.fromStation, self.myRoute.toStation)
        self.tableView.reloadData()
        
    }
    
    func refreshRoutes(r: Array<Array<Route>>) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        self.routes = r
        self.tableView.reloadData()
        self.tableView.endRefreshing()
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if isError {
            return 1
        }
        
        return routes.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isError {
            return 1
        }
        
        if (routes.count == 0) {
            return 0
        }
        
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
        if isError {
            let routeCell: RouteTableViewCell = RouteTableViewCell()
            routeCell.errorMessage = self.errorMessage
            
            return routeCell
        }
         
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
        
        routeCell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return routeCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if isError {
            return 50
        }
        
        let routeCell: RouteTableViewCell = RouteTableViewCell()
        routeCell.routes = self.routes[indexPath.section]

        return routeCell.getHeight()
    }
    
    func requestLocation() {
        if (self.myRoute.fromStationId > -1) {
            return;
        }
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse && CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.distanceFilter = kCLDistanceFilterNone
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            
            
            locationManager.startUpdatingLocation()
            locationManager.requestLocation()
            
            let loc = locationManager.location
            
            if loc != nil {
                self.updateLocations(loc!)
            } else {
                self.errorMessage = "Ingen platsservice."
                self.isError = true
            }
        }
    }
    
    func updateLocations(locations: CLLocation) {
        let coord = self.locationManager.location?.coordinate;
        let lat = coord!.latitude
        let long = coord!.longitude
        
        let latString = String(lat)
        let longString = String(long)
        
        self.myRoute.fromLat = latString as String!
        self.myRoute.fromLong = longString as String!
        print("updateLocations", self.myRoute.fromLat, self.myRoute.fromLong)
    }
}

extension RouteTableViewController : CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //self.updateLocations(locations)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
    }
}