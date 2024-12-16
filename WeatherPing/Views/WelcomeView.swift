//
//  WelcomeView.swift
//  WeatherPing
//
//  Created by Richa Mulchandani on 05/12/24.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to Weather Ping!")
                    .bold()
                    .font(.title)
                
                Text("We use your location to show accurate forecasts")
                    .padding()
                
                    .multilineTextAlignment(.center)
                    .padding()
                
                
                // LocationButton from CoreLocationUI
                
                LocationButton(.shareCurrentLocation) {
                    locationManager.requestLocation()
                }
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    struct WelcomeView_Previews: PreviewProvider {
        static var previews: some View {
            WelcomeView()
        }
    }
}
