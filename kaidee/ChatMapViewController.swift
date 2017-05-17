//
//  ChatMapViewController.swift
//  kaidee
//
//  Created by toktak on 5/17/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ChatMapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    
    struct shareStr {
        var lat : String!
        var long: String!
    }
    
    var selectedLocation : shareStr!
    
    var callback : ((shareStr) -> Void)?

    
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    let locationManager = CLLocationManager()
    let locationPin = MKPointAnnotation()


    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
            
            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotationOnLongPress(gesture:)))
            
            longPressGesture.minimumPressDuration = 0.5
            
            self.mapView.addGestureRecognizer(longPressGesture)
        }
        
    }
    @IBAction func ShareButtonOnTouch(_ sender: Any) {
        
        callback?(selectedLocation)
        
        self.dismiss(animated: true, completion: {});
        
    }
    
    @IBAction func CancelOnTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: {});

    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        print("regionDidChangeAnimated")
        
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        print("regionWillChangeAnimated")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        locationPin.coordinate = location.coordinate
        
        selectedLocation = shareStr.init(lat:"\(location.coordinate.latitude)", long: "\(location.coordinate.longitude)")
        print("auto location \(selectedLocation)")

        mapView.addAnnotation(locationPin)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        
        //pause
        
    }
    
    func addAnnotationOnLongPress(gesture: UILongPressGestureRecognizer) {
        
        
        if gesture.state == .ended {
            
            
            let allAnnotations = self.mapView.annotations
            self.mapView.removeAnnotations(allAnnotations)
            
            let point = gesture.location(in: self.mapView)
            let coordinate = self.mapView.convert(point, toCoordinateFrom: self.mapView)
            selectedLocation = shareStr.init(lat:"\(coordinate.latitude)", long:"\(coordinate.longitude)")

            
            print("custom location \(selectedLocation)")
            //Now use this coordinate to add annotation on map.
            var annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            
            
            //Set title and subtitle if you want
//            annotation.title = ""
//            annotation.subtitle = "subtitle"
            self.mapView.addAnnotation(annotation)
            
        }
    }
}
