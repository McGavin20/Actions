//
//  HomeHabitsView.swift
//  Actions
//
//  Created by Sharma on 29/08/2023.
//

import SwiftUI
import CoreData

struct HomeHabitsView: View {
    @ObservedObject var habitData: HabitData // Inject the habit data
    
    var body: some View {
        NavigationView {
            ZStack {
                // Displayed Habits to be tracked.
                
                List {
                    ForEach(habitData.habits) { habit in
                        Text("Habit Title: \(habit.title ?? "")")
                    }
                    .onDelete(perform: deleteHabit)
                }

                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        AddButtonView()
                            .padding(25)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private func deleteHabit(offsets: IndexSet) {
        // Handle deletion here, including removing the habit from habitData.habits
    }
}


struct HomeHabitsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHabitsView(habitData: HabitData())
    }
}
