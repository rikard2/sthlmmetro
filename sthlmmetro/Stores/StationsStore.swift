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
    static func GetStations() -> Promise<Array<Station>> {
        return fetchUserFeed().then({ body -> Array<Station> in
            let arr = NSMutableArray()
            
            arr.addObject(Station(name: "Blåsut"))
            arr.addObject(Station(name: "Skärmarbrink"))
            arr.addObject(Station(name: "Gullmarsplan"))
            arr.addObject(Station(name: "Skanstull"))
            arr.addObject(Station(name: "Medborgarplatsen"))
            arr.addObject(Station(name: "Slussen"))
            arr.addObject(Station(name: "Gamla Stan"))
            arr.addObject(Station(name: "T-centralen"))
            arr.addObject(Station(name: "Hötorget"))
            arr.addObject(Station(name: "Rådmansgatan"))
            arr.addObject(Station(name: "Odenplan"))
            
            return NSArray(array: arr) as! Array<Station>
        })
    }
    
    static func fetchUserFeed() -> URLDataPromise {
        let req =  NSURLRequest(URL: NSURL(string: "http://www.google.se/")!)
    
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