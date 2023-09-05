//
//  NewHabitView.swift
//  Actions
//
//  Created by Sharma on 17/08/2023.
//

import SwiftUI

struct NewHabitView: View {
    //Properties
    @State private var habitTitle = ""
    @State private var selectedColor: Color = .customGrayLight //Default Color
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $habitTitle)
                    .textFieldStyle(.roundedBorder)
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
