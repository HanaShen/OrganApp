//
//  LocationManager.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/10/19.
//

import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
    static let span : CLLocationDegrees = 0.01
    var showsUserLocation = true
   let locationManager : CLLocationManager
    override init(){
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }


    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.2637095, longitude: -76.6748222), span:MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span))

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            switch manager.authorizationStatus{
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
                showsUserLocation = true
            default:
                locationManager.stopUpdatingLocation()
                showsUserLocation = false
            }
        }
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
//            let newCoordinates = locations.map{$0.coordinate}
//            //if let coordinate = newCoordinates.first {
//              //  print
//            //}
//        }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){

        }

}
