//
//  ActionsApp.swift
//  Actions
//
//  Created by Sharma on 17/08/2023.
//

import SwiftUI

@main
struct ActionsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            WelcomeView()
//                .preferredColorScheme(.dark)
            ContentView(habitData: HabitData())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
