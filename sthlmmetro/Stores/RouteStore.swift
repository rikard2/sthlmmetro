//
//  RouteStore.swift
//  sthlmmetro
//
//  Created by Rikard Javelind on 10/04/16.
//  Copyright © 2016 Rikard Javelind. All rights reserved.
//

import Foundation
import PromiseKit

enum RouteError: ErrorType {
    case STATIONS_TOO_CLOSE
    case NO_INTERNET
    case UNKNOWN
}

class RouteStore {
    static func GetRoutes(myRoute: MyRoute) -> Promise<Array<Array<Route>>> {
        print("getMyRoutes", String(format: "%@ -> %@", myRoute.fromLat, myRoute.fromLong))
        
        return fetchRoutes(myRoute).then({ body -> Array<Array<Route>> in
            do {
                let arr = NSMutableArray()
                
                let jsonObj = try NSJSONSerialization.JSONObjectWithData(body, options: NSJSONReadingOptions.MutableContainers)
                
                if jsonObj is NSDictionary {
                    let err = (jsonObj as! NSDictionary).objectForKey("errorMessage")
                    
                    if err != nil {
                        throw RouteError.STATIONS_TOO_CLOSE
                    }
                }
                
                let json = jsonObj as! NSArray
                
                for j in json {
                    let routes = NSMutableArray()
                    let routesArr = j as! NSArray
                    var tooEarly: Bool = false
                    
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
                        
                        if route.fromDate.offsetFromMinutes(NSDate()) < 0 {
                            tooEarly = true
                        }
                        
                        routes.addObject(route)
                    }
                    
                    if !tooEarly {
                        arr.addObject(NSArray(array: routes) as! Array<Route>)
                    }
                }
                
                return NSArray(array: arr) as! Array<Array<Route>>
            } catch RouteError.STATIONS_TOO_CLOSE {
                throw RouteError.STATIONS_TOO_CLOSE
            } catch {
                throw RouteError.UNKNOWN
            }
            
            return NSArray() as! Array<Array<Route>>
        });
    }
    
    static func fetchRoutes(myRoute: MyRoute) -> URLDataPromise {
        var url = String(format: "http://sthlmmetro.azurewebsites.net/api/route?fromStationId=%@&toStationId=%@&fromLat=%@&fromLong=%@", myRoute.fromStation, myRoute.toStation, myRoute.fromLat, myRoute.fromLong)
        
        url = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print(url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
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