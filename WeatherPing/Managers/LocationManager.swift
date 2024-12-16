//
//  LocationManager.swift
//  WeatherPing
//
//  Created by Richa Mulchandani on 05/12/24.
//

import Foundation
import CoreLocation
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    
    override init() {
        super.init()
        
        
        // Assigning a delegate to CLLocationManager instance
               manager.delegate = self
           }
           
           
           func requestLocation() {
               isLoading = true
               manager.requestLocation()
           }
           
           // Set the location coordinates to the location variable
           func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
               location = locations.first?.coordinate
               isLoading = false
           }
           
           
           // This function will be called if we run into an error
           func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
               print("Error getting location", error)
               isLoading = false
           }
       }

        
        
           
    
    
