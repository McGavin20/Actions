//
//  ContentView.swift
//  Actions
//
//  Created by Sharma on 17/08/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var habitData: HabitData
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Habit.timestamp, ascending: true)],
        animation: .default)
    var habits: FetchedResults<Habit> // Remove 'private' here

    var body: some View {
        NavigationView {
            List {
                ForEach(habits) { habit in
                    NavigationLink {
                        Text("Habit Title: \(habit.title ?? "")")
                    } label: {
                        Text("Habit Title: \(habit.title ?? "")")
                    }
                }
                .onDelete(perform: deleteHabits)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addHabit) {
                        Label("Add Habit", systemImage: "plus")
                    }
                }
            }
            Text("Select a habit")
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

