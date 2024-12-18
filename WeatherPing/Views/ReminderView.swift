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
    @State private var reminderDate = Date()
    @State private var repeatOption = "Never" // Default Repeat Option
    
    // Repeat options list
    let repeatOptions = ["Never", "Daily", "Weekdays", "Weekends", "Weekly", "Monthly"]
    
    var body: some View {
        NavigationStack {
                
            VStack(spacing: 20) {
                
                // Input for Condition
                TextField("Condition (e.g., Rain)", text: $condition)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .accessibilityLabel("Condition input")
                    .accessibilityHint("Enter a weather condition such as rain or snow.")
                
                // Input for Message
                TextField("Message (e.g., Carry an umbrella)", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .accessibilityLabel("Message input")
                    .accessibilityHint("Enter a message to remind yourself, such as carry an umbrella.")
                
                // Day Picker
                DatePicker("Reminder Day", selection: $reminderDate, displayedComponents: .date)
                    .padding(.horizontal)
                    .accessibilityLabel("Select reminder day")
                    .accessibilityHint("Choose a specific day for the reminder.")
                
                // Time Picker
                DatePicker("Reminder Time", selection: $reminderDate, displayedComponents: .hourAndMinute)
                    .padding(.horizontal)
                    .accessibilityLabel("Select reminder time")
                    .accessibilityHint("Choose a specific time for the reminder.")
                
                // Repeat Picker
                Picker("Repeat", selection: $repeatOption) {
                    ForEach(repeatOptions, id: \.self) { option in
                        Text(option)
                    .accessibilityLabel(option)
                    }
                }
                .pickerStyle(.navigationLink)
                                .foregroundStyle(.primary)
                                .padding(.horizontal)
                                .accessibilityLabel("Repeat option")
                                .accessibilityHint("Select how often the reminder should repeat, such as daily or weekly.")
                            }
                            .padding(.bottom, 20)
                            .navigationTitle("New Reminder")
                            .navigationBarTitleDisplayMode(.inline)
                            
                            // Add Reminder Button
                            Button(action: {
                                ReminderManager.shared.addReminder(
                                    condition: condition,
                                    message: message,
                                    date: reminderDate,
                                    pattern: ReminderManager.shared.getPattern(repeatOption: repeatOption)
                                )
                                // Reset inputs
                                condition = ""
                                message = ""
                                reminderDate = Date()
                                repeatOption = "Never"
                            }) {
                                Text("Add Reminder")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .accessibilityLabel("Add Reminder Button")
                                    .accessibilityHint("Tap to add a new reminder with the entered details.")
                            }
                            .padding(.horizontal)
                            
                            Spacer()
                        }
                        .padding(.top)
                    }
                }

                #Preview {
                    ReminderView()
                }
