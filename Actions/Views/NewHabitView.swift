//
//  NewHabitView.swift
//  Actions
//
//  Created by Sharma on 17/08/2023.
//

import SwiftUI

struct NewHabitView: View {
    // Properties
    @Environment(\.presentationMode) var presentationMode
    @State private var habitTitle = ""
    @State private var selectedColor: Color = .customGrayLight // Default Color
    @State private var isHomeHabitsViewActive = false

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
                            // Activate the navigation to HomeHabitsView
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
                    .background(NavigationLink("", destination: HomeHabitsView(), isActive: $isHomeHabitsViewActive))
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
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitView()
    }
}
