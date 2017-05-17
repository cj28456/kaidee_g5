//
//  ChatOpenMap.swift
//  kaidee
//
//  Created by toktak on 5/17/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ChaTOpenMap: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    let locationManager = CLLocationManager()
    let locationPin = MKPointAnnotation()
    var lat :String!
    var long :String!
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        
        let _latitude = (lat as NSString).doubleValue
        let _longitude = (long as NSString).doubleValue
        
        let initialLocation = CLLocation(latitude: _latitude, longitude: _longitude)

        
        let center = CLLocationCoordinate2D(latitude: initialLocation.coordinate.latitude, longitude: initialLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        locationPin.coordinate = initialLocation.coordinate
        
        mapView.addAnnotation(locationPin)
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func CloseOnTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: {});
        
    }
    
}
