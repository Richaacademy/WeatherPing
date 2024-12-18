//
//  File.swift
//  WeatherPing
//
//  Created by Richa Mulchandani on 09/12/24.
//

import Foundation

enum Pattern {
    case never
    case daily
    case weekly
    case weekdays
    case weekends
    case monthly
}

struct Reminder {
    let condition: String
    let message: String
    let date: Date
    let pattern: Pattern
}

@Observable
class ReminderManager {
    static let shared = ReminderManager() // Singleton instance
    
    private var reminders: [Reminder] = []
    var reminderDate = Date() // State for date selection

    // Add a new reminder
    func addReminder(condition: String, message: String, date: Date, pattern: Pattern) {
        let newReminder = Reminder(condition: condition, message: message, date: date, pattern: pattern)
        reminders.append(newReminder)
        saveReminders()
    }

    // Delete a reminder by condition and date
    func deleteReminder(condition: String, date: Date) {
        reminders.removeAll { reminder in
            reminder.condition.lowercased() == condition.lowercased() && reminder.date == date
        }
        saveReminders()
    }
    
    // Get the list of all reminders
    func getAllReminders() -> [Reminder] {
        return reminders
    }

    // Check reminders based on weather condition
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
    
    // Get pattern based on repeat option string
    func getPattern(repeatOption: String) -> Pattern {
        switch repeatOption {
        case "Daily":
            return .daily
        case "Weekly":
            return .weekly
        case "Weekdays":
            return .weekdays
        case "Weekends":
            return .weekends
        case "Monthly":
            return .monthly
        default:
            return .never
        }
    }

    // Check if notification should be sent based on pattern
    func shouldPushNotifications(for pattern: Pattern) -> Bool {
        let calendar = Calendar.current
        let currentDate = Date()

        switch pattern {
        case .daily:
            return true
        case .weekdays:
            return !calendar.isDateInWeekend(currentDate)
        case .weekends:
            return calendar.isDateInWeekend(currentDate)
        case .weekly:
            return calendar.component(.weekday, from: currentDate) == 1
        case .monthly:
            return calendar.component(.day, from: currentDate) == 1
        default:
            return false
        }
    }

    // Save reminders to persistent storage
    private func saveReminders() {
        // Save reminders to UserDefaults or CoreData
    }

    // Load reminders from persistent storage
    private func loadReminders() {
        // Load reminders from UserDefaults or CoreData
    }
}
