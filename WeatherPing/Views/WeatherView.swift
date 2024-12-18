//
//  WeatherView.swift
//  WeatherPing
//
//  Created by Richa Mulchandani on 05/12/24.
//

import SwiftUI

struct WeatherView: View {
    
    var weather: ResponseBody
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                VStack {
                    
                    // City name and date
                    VStack(alignment: .leading, spacing: 5) {
                        Text(weather.name)
                            .bold()
                            .font(.title)
                            .accessibilityLabel("City name: \(weather.name)")
                        
                        Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                            .fontWeight(.light)
                            .accessibilityLabel("Today's date and time")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    // Weather Image and Description
                    VStack {
                        HStack {
                            VStack(spacing: 20) {
                                Image(systemName: "cloud")
                                    .font(.system(size: 60))
                                    .padding()
                                    .accessibilityLabel("Weather icon. Cloudy.")
                                
                                Text("\(weather.weather[0].main)")
                                    .accessibilityLabel("Weather condition: \(weather.weather[0].main)")
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            Spacer()
                            
                            Text(weather.main.feelsLike.roundDouble() + "°")
                                .font(.system(size: 100))
                                .fontWeight(.bold)
                                .padding()
                                .accessibilityLabel("Feels like temperature is \(weather.main.feelsLike.roundDouble()) degrees")
                        }
                        
                        Spacer()
                            .frame(height: 80)
                        
                        // Background Image
                        AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350)
                                .accessibilityHidden(true) // Decorative Image
                        } placeholder: {
                            ProgressView()
                                .accessibilityLabel("Loading weather background image")
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Weather Details Section
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Weather now")
                            .bold()
                            .padding(.bottom)
                            .accessibilityLabel("Current weather details")
                        
                        HStack {
                            WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.roundDouble() + "°"))
                                .accessibilityElement(children: .combine)
                                .accessibilityLabel("Minimum temperature \(weather.main.tempMin.roundDouble()) degrees")
                            
                            Spacer()
                            
                            WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                                .accessibilityElement(children: .combine)
                                .accessibilityLabel("Maximum temperature \(weather.main.tempMax.roundDouble()) degrees")
                        }
                        
                        HStack {
                            WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                                .accessibilityElement(children: .combine)
                                .accessibilityLabel("Wind speed \(weather.wind.speed.roundDouble()) meters per second")
                            
                            Spacer()
                            
                            WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                                .accessibilityElement(children: .combine)
                                .accessibilityLabel("Humidity \(weather.main.humidity.roundDouble()) percent")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, 20)
                    .padding(.horizontal, 27)
                    .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                    .background(.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            .preferredColorScheme(.dark)
            
            // Toolbar Button
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ReminderView()) {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.white)
                            .font(.title)
                            .accessibilityLabel("Open reminders")
                            .accessibilityHint("Navigate to the reminder settings page")
                    }
                }
            }
        }
    }
}
