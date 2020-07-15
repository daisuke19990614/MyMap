//
//  ViewController.swift
//  MyMap
//
//  Created by 宮本大介 on 2020/06/08.
//  Copyright © 2020 Swit-Beginners. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController ,UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputText.delegate = self
    }

    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var dispMap: MKMapView!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let searchKey = textField.text{
            print(searchKey)
            
            let geocoder = CLGeocoder()
            
            geocoder.geocodeAddressString(searchKey, completionHandler:{(placemarks,error)in
                if let unwarpPlacemarks = placemarks{
                    if let firstPlacemark = unwarpPlacemarks.first{
                        if let location = firstPlacemark.location{
                            let targetCoordinate = location.coordinate
                            print(targetCoordinate)
                            let pin = MKPointAnnotation()
                            pin.coordinate = targetCoordinate
                            pin.title = searchKey
                            self.dispMap.addAnnotation(pin)
                            self.dispMap.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                        }
                    }
                }
            })
        }
        return true
    }
    
    @IBAction func changeMapButtonAction(_ sender: Any) {
        switch dispMap.mapType {
        case .standard:         // 標準の地図
            dispMap.mapType = .satellite
            break
        case .satellite:        // 航空写真
            dispMap.mapType = .hybrid
            break
        case .hybrid:           // 標準の地図＋航空写真
            dispMap.mapType = .satelliteFlyover
            break
        case .satelliteFlyover: // 3D航空写真
            dispMap.mapType = .hybridFlyover
            break
        case .hybridFlyover:    // 3D標準の地図＋航空写真
            dispMap.mapType = .mutedStandard
            break
        case .mutedStandard:    // 地図よりもデータを強調
            dispMap.mapType = .standard
            break
        }
    }
    
    
}

