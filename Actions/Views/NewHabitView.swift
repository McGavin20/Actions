//
//  NewHabitView.swift
//  Actions
//
//  Created by Sharma on 17/08/2023.
//

import SwiftUI

struct NewHabitView: View {
    //Properties
    @Environment(\.presentationMode) var presentationMode
    @State private var habitTitle = ""
    @State private var selectedColor: Color = .customGrayLight //Default Color
    
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
                        print("Button pressed: Done")
                    }, label: {
                        Text("Done")
                    })
                }
                .padding()
                TextField("Habit Title", text: $habitTitle)
                    .textFieldStyle(.plain)
                    .padding()
                //Spacer()
                CircleColorPicker(selectedColor: $selectedColor)
                
                FrequencyView()
                    .padding()
                
   
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
