//
//  MyRoutes.swift
//  sthlmmetro
//
//  Created by Rikard Javelind on 09/04/16.
//  Copyright © 2016 Rikard Javelind. All rights reserved.
//

import Foundation
import SwiftyJSON

class MyRoutesStore {
    static func getMyRoutes() -> Array<MyRoute> {
        let defaults = NSUserDefaults(suiteName: "metro")
         //defaults?.setObject(NSMutableArray(), forKey: "MyRoutesArray")
        
        let routes = defaults?.mutableArrayValueForKey("MyRoutesArray");
        let arr = NSMutableArray()
        
        for r in routes! {
            let myRoute: MyRoute = MyRoute()
            myRoute.fromStation = r.valueForKey("fromStation") as! String
            myRoute.toStation = r.valueForKey("toStation") as! String
            myRoute.fromStationId = r.valueForKey("fromStationId") as! Int
            myRoute.toStationId = r.valueForKey("toStationId") as! Int
            
            arr.addObject(myRoute)
        }
        return NSArray(array: arr) as! Array<MyRoute>
    }
    
    static func deleteRoute(index: Int) {
        print("deleting", index)
        let defaults = NSUserDefaults(suiteName: "metro")
        let arr = defaults?.arrayForKey("MyRoutesArray")
        let routes: NSMutableArray? = NSMutableArray(array: arr!)
        print("routes", routes)
        
        routes?.removeObjectAtIndex(index)
        defaults!.setObject(routes, forKey: "MyRoutesArray")
    }
    
    static func addRoute(myRoute: MyRoute) {
        let defaults = NSUserDefaults(suiteName: "metro")
        let arr = defaults?.arrayForKey("MyRoutesArray");
        let routes: NSMutableArray? = NSMutableArray(array: arr!)
        
        let dict = myRoute.serialize()
        
        routes!.addObject(dict)
        
        defaults!.setObject(routes, forKey: "MyRoutesArray")
        
        return
    }
}

class MyRoute {
    var fromStation: String = ""
    var toStation: String = ""
    var fromStationId: Int = 0
    var toStationId: Int = 0
    
    func serialize() -> AnyObject {
        return [
            "fromStation": fromStation,
            "toStation": toStation,
            "fromStationId": fromStationId,
            "toStationId": toStationId
        ]
    }
}