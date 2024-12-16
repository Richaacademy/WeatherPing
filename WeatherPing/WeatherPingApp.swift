//
//  WeatherPingApp.swift
//  WeatherPing
//
//  Created by Richa Mulchandani on 05/12/24.
//

import SwiftUI

@main
struct WeatherPingApp: App {
    
    init () {
        NotificationManager.shared.requestAuthorization()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
