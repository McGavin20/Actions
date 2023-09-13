//
//  NewHabitView.swift
//  Actions
//
//  Created by Sharma on 17/08/2023.
//

import SwiftUI
import CoreData

struct NewHabitView: View {
    // Properties
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @State private var habitTitle = ""
    @State private var selectedColor: Color = .customGrayLight // Default Color
    @State private var isHomeHabitsViewActive = false
    @ObservedObject var habitData: HabitData // Inject the habit data
        

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                        print("Button pressed: Cancel")
                    }, label: {
                        Text("Cancel")
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        if !habitTitle.isEmpty {
                            // Perform the action when habitTitle is not empty
                            print("Button pressed: Done")
                            // Activate the navigation to HomeHabitsView and pass the habitData
                            self.isHomeHabitsViewActive = true
                        } else {
                            // Show an alert or provide some feedback to the user
                            // indicating that the title should not be empty.
                            // For example:
                            // self.showEmptyTitleAlert = true
                        }
                    }, label: {
                        Text("Done")
                    })
                    .padding()
                    .background(NavigationLink("", destination: HomeHabitsView(habitData: habitData), isActive: $isHomeHabitsViewActive))

                }
                .padding()
                
                
                TextField("Habit Title", text: $habitTitle)
                    .textFieldStyle(.plain)
                    .padding()
                CircleColorPicker(selectedColor: $selectedColor)
                FrequencyView()
                    .padding()
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    // Functions
    
    private func saveHabit() {
        guard !habitTitle.isEmpty else {
            // Show an alert or provide feedback to the user about the empty title.
            return
        }
        
        let newHabit = Habit(context: viewContext)
        newHabit.title = habitTitle
        newHabit.themeColor = selectedColor.description
        
        do {
            try viewContext.save()
        } catch {
            // Handle the error here.
            print("Error saving habit: \(error.localizedDescription)")
        }
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitView(habitData: HabitData())
    }
}
