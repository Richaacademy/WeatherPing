//
//  ReminderView.swift
//  WeatherPing
//
//  Created by Richa Mulchandani on 09/12/24.
//

import SwiftUI

struct ReminderView: View {
    @State private var condition = ""
    @State private var message = ""

    var body: some View {
        VStack {
            TextField("Condition (e.g., Rain)", text: $condition)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Message (e.g., Carry an umbrella)", text: $message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Add Reminder") {
                ReminderManager.shared.addReminder(condition: condition, message: message)
                condition = ""
                message = ""
            }
            .padding()

            // Display existing reminders
        }
        .navigationTitle("Reminders")
        .padding()
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
