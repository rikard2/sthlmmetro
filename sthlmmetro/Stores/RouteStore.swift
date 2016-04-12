//
//  RouteStore.swift
//  sthlmmetro
//
//  Created by Rikard Javelind on 10/04/16.
//  Copyright © 2016 Rikard Javelind. All rights reserved.
//

import Foundation
import PromiseKit

class RouteStore {
    static func GetRoutes(myRoute: MyRoute) -> Promise<Array<Array<Route>>> {
        return fetchRoutes(myRoute).then({ body -> Array<Array<Route>> in
            do {
                let arr = NSMutableArray()
                
                let json = try NSJSONSerialization.JSONObjectWithData(body, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                
                for j in json {
                    let routes = NSMutableArray()
                    let routesArr = j as! NSArray
                    
                    for r in routesArr {
                        let route = Route(from: "", to: "", line: "")
                        
                        let dateFormat = NSDateFormatter()
                        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
                        route.fromStation = r["fromStation"] as! String
                        route.toStation = r["toStation"] as! String
                        let fromDateString = r["fromDate"] as! String
                        let toDateString = r["toDate"] as! String
                        
                        route.fromDate = dateFormat.dateFromString(fromDateString)!
                        route.toDate = dateFormat.dateFromString(toDateString)!
                        
                        route.line = r["line"] as! String
                        
                        routes.addObject(route)
                    }
                    
                    arr.addObject(NSArray(array: routes) as! Array<Route>)
                }
                
                return NSArray(array: arr) as! Array<Array<Route>>
            } catch {
                // Something went wrong
            }
            
            return NSArray() as! Array<Array<Route>>
        })
    }
    
    static func fetchRoutes(myRoute: MyRoute) -> URLDataPromise {
        let url = String(format: "http://sthlmmetro.azurewebsites.net/api/route?fromStationId=%d&toStationId=%d", myRoute.fromStationId, myRoute.toStationId)
        print("fetching routes", url)
        let req =  NSURLRequest(URL: NSURL(string: url)!)
        
        return NSURLConnection.promise(req)
    }
}

class Route {
    var fromStation: String = ""
    var toStation: String = ""
    var line: String = ""
    var fromDate: NSDate = NSDate()
    var toDate: NSDate = NSDate()
    
    init(from: String, to: String, line: String) {
        self.fromStation = from
        self.toStation = to
        self.line = line
    }
}