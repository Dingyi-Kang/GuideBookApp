//
//  MapViewController.swift
//  Guidebook
//
//  Created by OSU App Center on 6/26/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    //MARK: -- variables and property
    
    @IBOutlet weak var mapView: MKMapView!
    
    var place:Place?
    
    //MARK: -- viewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if place != nil {
            
            //create a location object, which is CLlocationCoodinate2D
            let location = CLLocationCoordinate2D(latitude: place!.latitude, longitude: place!.longitude)
            
            //create a pin object with property of that location
            let pin = MKPointAnnotation()
            pin.coordinate = location
            
            //add it to the map
            mapView.addAnnotation(pin)
            
            //create a region to zoom in to the pin location
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 100, longitudinalMeters: 100)
           //call the func of MapKit class to set that region into the mapView
            mapView.setRegion(region, animated: false)
            
        }
    }


}
