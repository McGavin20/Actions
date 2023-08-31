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
    
    var body: some View {
        NavigationView {
            TextField("Title", text: $habitTitle)
                .textFieldStyle(.roundedBorder)
                .padding()
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitView()
    }
}
