//
//  MyRoutesTableViewController.swift
//  sthlmmetro
//
//  Created by Rikard Javelind on 09/04/16.
//  Copyright © 2016 Rikard Javelind. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyRoutesTableViewController: UITableViewController {
    var myRoutes: JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myRoutes = MyRoutesStore.GetMyRoutes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRoutes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("stationCell", forIndexPath: indexPath)
        let text: UILabel = cell.viewWithTag(1) as! UILabel
        let from = myRoutes[indexPath.row]["From"].stringValue
        let to = myRoutes[indexPath.row]["To"].stringValue
        
        text.text = String(format: "%@ → %@", from, to)
        
        return cell
    }
}
