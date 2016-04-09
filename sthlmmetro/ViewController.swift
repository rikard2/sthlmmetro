//
//  ViewController.swift
//  sthlmmetro
//
//  Created by Rikard Javelind on 08/04/16.
//  Copyright © 2016 Rikard Javelind. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var HelloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HelloLabel.text = "whatever";
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

