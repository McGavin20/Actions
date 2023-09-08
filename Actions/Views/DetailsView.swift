//
//  DetailsView.swift
//  Actions
//
//  Created by Sharma on 17/08/2023.
//

import SwiftUI

struct DetailsView: View {
    @Binding var name: String?
    @Binding var age: String?
    @Binding var location: String?
    @Binding var showNewHabitView: Bool
    @State private var isNavigating: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            
            VStack {
                
                TextField("Name", text: nonOptionalBinding($name))
                    .textFieldStyle(RoundedBorderTextFieldStyle())                   
                    .padding()
                
                TextField("Age", text: nonOptionalBinding($age))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Location", text: nonOptionalBinding($location))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Spacer()
                
                HStack {
                    // Buttons
                    NavigationLink(
                        destination: NewHabitView(),
                        isActive: $isNavigating,
                        label: { EmptyView() }
                    )
                    .hidden()
                    .id(UUID())
                    Button(action: {
                        showNewHabitView = true
                        print("Proceed button was pressed.")
                        isNavigating = true
                    }, label: {
                        Text("Proceed")
                    })
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                
                    
                    Button("Dismiss") {
                        print("Dismiss Button was pressed.")
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
                }
                Spacer()
                
            }
            .padding()
            
        }
        
    }
    
    // Helper function to convert optional binding to non-optional
        private func nonOptionalBinding(_ binding: Binding<String?>) -> Binding<String> {
            return Binding<String>(
                get: { binding.wrappedValue ?? "" },
                set: { newValue in binding.wrappedValue = newValue }
            )
        }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(name: .constant(""), age: .constant(""), location: .constant(""), showNewHabitView: .constant(false))
    }
}

