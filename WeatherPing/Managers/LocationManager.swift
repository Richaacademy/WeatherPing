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
    @Published var error: Error?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest // High accuracy
    }
    
    func requestLocation() {
        isLoading = true
        
        // Check and request permission
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        case .denied, .restricted:
            print("Location access denied or restricted.")
            error = NSError(domain: "Location Access", code: 1, userInfo: [NSLocalizedDescriptionKey: "Location access denied."])
            isLoading = false
        @unknown default:
            print("Unknown authorization status.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error.localizedDescription)")
        self.error = error
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location access granted.")
            manager.requestLocation()
        case .denied, .restricted:
            print("Location access denied/restricted.")
            error = NSError(domain: "Location Access", code: 1, userInfo: [NSLocalizedDescriptionKey: "Location access denied."])
            isLoading = false
        case .notDetermined:
            print("Location authorization not determined.")
        @unknown default:
            print("Unknown authorization status.")
        }
    }
}

        
        
           
    
    
