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
    static func GetRoutes() -> Promise<Array<Array<Route>>> {
        
        return fetchUserFeed().then({ body -> Array<Array<Route>> in
            let arr = NSMutableArray()
            
            let routes = NSMutableArray()
            
            routes.addObject(Route(from: "Blåsut", to: "Odenplan", line: "blue"))
            routes.addObject(Route(from: "Blåsut", to: "Odenplan", line: "green"))
            routes.addObject(Route(from: "Blåsut", to: "Odenplan", line: "red"))
            arr.addObject(routes)
            
            let routes2 = NSMutableArray()
            
            routes2.addObject(Route(from: "Blåsut", to: "Odenplan", line: "blue"))
            routes2.addObject(Route(from: "Blåsut", to: "Odenplan", line: "green"))
            arr.addObject(routes2)
            
            return NSArray(array: arr) as! Array<Array<Route>>
        })
    }
    
    static func fetchUserFeed() -> URLDataPromise {
        let req =  NSURLRequest(URL: NSURL(string: "http://www.google.se/")!)
        
        return NSURLConnection.promise(req)
    }
}

class Route {
    var fromStation: String = ""
    var toStation: String = ""
    var line: String = ""
    
    init(from: String, to: String, line: String) {
        self.fromStation = from
        self.toStation = to
        self.line = line
    }
}