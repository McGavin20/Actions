//
//  WelcomeView.swift
//  Actions
//
//  Created by Sharma on 17/08/2023.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var isSheetPresented = false
    @State private var name: String? = nil
    @State private var age: String? = nil
    @State private var location: String? = nil
    @State private var showNewHabitView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                VStack {
                    Text("Actions")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Don't break the chain.")
                        .font(.footnote)
                        .foregroundColor(.customGrayLight)
                }
                Spacer()
                
                Button("Let's start") {
                    print("Let's start Button was pressed.")
                    isSheetPresented.toggle()
                    
                }
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .background(Color.customSalmonLight)
                .cornerRadius(10)
                
                .sheet(isPresented: $isSheetPresented) {
                    DetailsView(name: $name, age: $age, location: $location, showNewHabitView: $showNewHabitView)
                }
                Spacer()
            }
        }
    }
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
