//
//  HabitData.swift
//  Actions
//
//  Created by Sharma on 13/09/2023.
//

import SwiftUI
import CoreData
import UserNotifications
import UserNotificationsUI

class HabitViewModel: ObservableObject {
    @Published var  addNewHabit: Bool = false
    @Published var title: String = ""
    @Published var habitColor = Color(Color.customSalmonLight as! CGColor)
    @Published var weekDays: [String] = []
    @Published var isRemainderOn: Bool = false
    @Published var remainderText: String = ""
    @Published var remainderDate: Date = Date()
    // Reminder Time Picker
    @Published var showTimePicker: Bool = false
    
    // editting habits
    @Published var editHabit: HabitEntity?
    
    // Notification Access
    @Published var notificationAccess: Bool = false
    //@Published var notificationIDs: String = ""
    //MARK: FUNCTIONS
    
    // Notification Access
    
    init() {
        requestNotificationAcess()
    }
    
    func requestNotificationAcess() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.alert]) { status, _ in
            DispatchQueue.main.async {
                self.notificationAccess = status
            }
        }
    }
    // Adding Data to Database
    func addNewHabit(context: NSManagedObjectContext)->Bool {
        
        // Editing Data
        var habit: HabitEntity!
        if let editHabit = editHabit {
            habit = editHabit
            //Reemoving all pending notifications
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: editHabit.notificationIDs ?? [])
        } else {
            habit = HabitEntity(context: context)
        }
        
        habit.title = title
        habit.color = habitColor
        habit.weekDays = weekDays
        habit.isRemainderOn = isRemainderOn
        habit.notificationDate = remainderDate
        habit.notificationIDs = []
        
        if isRemainderOn {
            // Scheduling Notification
            if let ids = try? await scheduleNotification() {
                habit.notificationIDs = ids
                if let _ = try? context.save() {
                    return true
                }
            }
        } else {
            if let _ = try? context.save() {
                return true
            }
        }
        return false
    }
    
    // Adding Notifications
    func scheduleNotification()async throws->[String] {
        let content = UNMutableNotificationContent()
        content.title = "Habit Remainder"
        content.subtitle = remainderText
        content.sound = UNNotificationSound.default
        
        //  Schedule Identification
        var notificationIDs: [String] = []
        let calendar = Calendar.current
        let weekdaySymbols: [String] = calendar.weekdaySymbols
        
        // MARK: Scheduling Notiification
        for weekDay in weekDays {
            //Umique ID for Each Notification
            let id = UUID().uuidString
            let hour = calendar.component(.hour, from: remainderDate)
            let min = calendar.component(.minute, from: remainderDate)
            let day = weekdaySymbols.firstIndex { currentDay in
                return currentDay == weekDay
            } ?? -1
            // Since Week day starts from 1-7
            // Thus adding + 1 to Index
            
            if day != -1 {
                var components = DateComponents()
                components.hour = hour
                components.minute = min
                components.weekday = day + 1
                
                //This will trigger notification on each selected day
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                
                // Notification Request
                
                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                
                try await UNUserNotificationCenter.current().add(request)
                
                //Adding ID
                notificationIDs.append(id)
            }
        }
        
        return notificationIDs
    }
    
    //Erase Data from Darabase
    func resetData() {
        title = ""
        habitColor = Color.customGrayMedium
        weekDays = []
        isRemainderOn = false
        remainderDate = Date()
        remainderText = ""
        editHabit = nil
    }
    
    // Deleting Habits
    
    func deleteHabit(context: NSManagedObjectContext)->Bool {
        if let editHabit = editHabit {
            if editHabit.isRemainderOn {
                //Removing all pending notifications
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: editHabit.notificationIDs ?? [])
            }
            context.delete(editHabit)
            if let _ = try? context.save() {
                return true
            }
        }
        return false
    }
    //Restoring Edit Data
    func restoreEditData() {
        if let editHabit = editHabit {
            title = editHabit.title ?? ""
            habitColor = editHabit.color ?? Color.customGrayMedium
            weekDays = editHabit.weekDays ?? []
            isRemainderOn = editHabit.isRemainderOn
            remainderDate = editHabit.notificationDate ?? Date()
            remainderText = editHabit.remainderText ?? ""
            
        }
    }
    
    // Done Button Status
    func doneStatus()->Bool {
        let reminderStatus = isRemainderOn ? remainderText == "" : false
        
        if title == "" || weekDays.isEmpty || reminderStatus {
            return false
        }
        return true
    }    
}
