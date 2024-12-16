//
//  File.swift
//  WeatherPing
//
//  Created by Richa Mulchandani on 09/12/24.
//

import Foundation

struct Reminder {
    let condition: String
    let message: String
}

class ReminderManager {
    static let shared = ReminderManager()
    private var reminders: [Reminder] = []

    func addReminder(condition: String, message: String) {
        let newReminder = Reminder(condition: condition, message: message)
        reminders.append(newReminder)
        saveReminders()
    }

    func checkReminders(for weatherCondition: String) {
        reminders.forEach { reminder in
            if reminder.condition.lowercased() == weatherCondition.lowercased() {
                NotificationManager.shared.scheduleNotification(
                    title: "Weather Alert",
                    body: reminder.message,
                    timeInterval: 5
                )
            }
        }
    }

    private func saveReminders() {
        // Save reminders to UserDefaults or CoreData
    }

    private func loadReminders() {
        // Load reminders from UserDefaults or CoreData
    }
}
