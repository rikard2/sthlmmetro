//
//  StationPickerViewController.swift
//  sthlmmetro
//
//  Created by Rikard Javelind on 09/04/16.
//  Copyright © 2016 Rikard Javelind. All rights reserved.
//

import UIKit
import PromiseKit

class AddRouteViewController: UIViewController {

    @IBOutlet weak var fromPicker: UIPickerView!
    @IBOutlet weak var toPicker: UIPickerView!
    
    var stations: Array<Station> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromPicker.dataSource = self
        toPicker.dataSource = self
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let p = StationsStore.GetStations()
        
        p.then { stations in
            self.reload(stations)
        }
        
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        activityView.center = self.view.center
        activityView.startAnimating()
        self.view.addSubview(activityView)
        
        self.title = "Välj station"
    }
    
    func reload(stations: Array<Station>) {
        self.stations = stations;
        
        self.fromPicker.reloadAllComponents();
        self.toPicker.reloadAllComponents();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let myRoute = MyRoute()
        
        let fromRow = fromPicker.selectedRowInComponent(0)
        let toRow = toPicker.selectedRowInComponent(0)
        
        myRoute.fromStation = self.stations[fromRow].name
        myRoute.toStation = self.stations[toRow].name
        
        MyRoutesStore.addRoute(myRoute)
    }
}

extension AddRouteViewController : UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stations.count
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = stations[row].name
        
        return NSAttributedString(string: title)
    }
    
}

extension AddRouteViewController : UIPickerViewDelegate {
}