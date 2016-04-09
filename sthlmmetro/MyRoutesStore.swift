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
    static func GetMyRoutes() -> JSON {
        return [
            ["From": "Blåsut", "To": "T-Centralen"]
        ]
    }
    
    static func StoreMyRoutes(json: JSON) -> Void {
    
    }
}