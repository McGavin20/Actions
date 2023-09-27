//
//  ActionsApp.swift
//  Actions
//
//  Created by Sharma on 17/08/2023.
//

import SwiftUI

@main
struct ActionsApp: App {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            HomeHabitsView(habitData: HabitData(), isDarkMode: $isDarkMode)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
