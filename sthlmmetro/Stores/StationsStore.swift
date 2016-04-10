//
//  StationsStore.swift
//  sthlmmetro
//
//  Created by Rikard Javelind on 10/04/16.
//  Copyright © 2016 Rikard Javelind. All rights reserved.
//

import Foundation
import PromiseKit

class StationsStore {
    static func error() {
        
    }
    static func GetStations() -> Promise<Array<Station>> {
        return fetchStations().then({ body -> Array<Station> in
            do {
                let arr = NSMutableArray()
                
                let json = try NSJSONSerialization.JSONObjectWithData(body, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                
                for j in json {
                    let name = j["name"] as! String
                    let id = j["id"] as! NSInteger
                    print("j", j)
                    
                    let station = Station(name: name)
                    station.id = id
                    
                    arr.addObject(station)
                }
                
                return NSArray(array: arr) as! Array<Station>
            } catch {
                // Something went wrong
            }
            
            return NSArray() as! Array<Station>
        })
    }
    
    static func fetchStations() -> URLDataPromise {
        let req =  NSURLRequest(URL: NSURL(string: "http://sthlmmetro.azurewebsites.net/api/stations")!)
    
        return NSURLConnection.promise(req)
    }
}

class Station {
    var name: String = ""
    var id: Int = 0
    
    init(name: String) {
        self.name = name
    }
}