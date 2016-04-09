//
//  StationPickerViewController.swift
//  sthlmmetro
//
//  Created by Rikard Javelind on 09/04/16.
//  Copyright © 2016 Rikard Javelind. All rights reserved.
//

import UIKit
import SwiftyJSON

class StationPickerViewController: UIViewController {

    @IBOutlet weak var fromPicker: UIPickerView!
    @IBOutlet weak var toPicker: UIPickerView!
    
    var stations = [
        ["name": "Blåsut"],
        ["name": "Odenplan"]
    ]
    var stationsJson: JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fromPicker.dataSource = self
        toPicker.dataSource = self
        
        self.title = "Välj station"
        
        stationsJson = JSON(stations)
        
        let button = UIBarButtonItem(title: "Nästa", style: .Plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = button
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

extension StationPickerViewController : UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return stationsJson.count
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = stationsJson[row]["name"].stringValue
        
        return NSAttributedString(string: title)
    }
    
}

extension StationPickerViewController : UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stationsJson[row]["name"].stringValue
    }
}