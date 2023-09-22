//
//  ContentView.swift
//  Actions
//
//  Created by Sharma on 17/08/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var habitData: HabitData
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Habit.timestamp, ascending: true)],
        animation: .default)
    var habits: FetchedResults<Habit>
    @State private var isAddingNewHabit = false


    var body: some View {
        NavigationView {
            HomeHabitsView(habitData: habitData)
                .sheet(isPresented: $isAddingNewHabit) {
                    NewHabitView(habitData: habitData)
                }
        }
    }
    
    private func addHabit() {
        withAnimation {
            let newHabit = Habit(context: viewContext)
            newHabit.timestamp = Date()
            habitData.addHabit(newHabit) // Add the new habit to habitData
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteHabits(offsets: IndexSet) {
        withAnimation {
            offsets.map { habits[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(habitData: HabitData())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

