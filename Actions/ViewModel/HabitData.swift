//
//  HabitData.swift
//  Actions
//
//  Created by Sharma on 13/09/2023.
//

import Foundation
import SwiftUI
import CoreData

class HabitData: ObservableObject {
    @Published var savedEntities: [HabitEntity] = [] // Stores the user's habits here
    
    // The logic to load up coredata
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "HabitContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
               
            }
        }
        fetchHabit()
    }
    
    // Fetch the Habit data
    func fetchHabit() {
        let request = NSFetchRequest<HabitEntity>(entityName: "HabitEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error) ❌")
        }
    }
    
    func addHabit(text: String) {
        let newHabit = HabitEntity(context: container.viewContext)
        newHabit.title = text
        saveData()
    }
    
    func saveData() {
        
        do {
            try container.viewContext.save()
            fetchHabit()
        } catch let error {
            print("Error saving. \(error) ❌")
        }
    }
}

