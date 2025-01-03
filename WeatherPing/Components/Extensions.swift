//
//  Extensions.swift
//  WeatherPing
//
//  Created by Richa Mulchandani on 05/12/24.
//

import Foundation
import SwiftUI

// Extension for rounded Double to 0 decimals
extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}



extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension Date {
    static func getHourAndMinute() -> (hour: Int, minute: Int) {
        let date = Date.now
        let hour = Calendar.current.component(.hour, from: date)
        let minute = Calendar.current.component(.minute, from: date)
        return (hour, minute)
    }
    
    static func isWeekend() -> Bool {
        let currentDate = Date.now
        let day = Calendar.current.component(.weekday, from: currentDate)
        return day == 1 || day == 7
    }
}
