//
//  CommonViewController.swift
//  sthlmmetro
//
//  Created by Rikard Javelind on 17/04/16.
//  Copyright © 2016 Rikard Javelind. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        let button = UIBarButtonItem()
        button.title = ""
        
        self.navigationItem.backBarButtonItem = button
    }

}

class CommonTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        let button = UIBarButtonItem()
        button.title = ""
        
        self.navigationItem.backBarButtonItem = button
    }
    
}
