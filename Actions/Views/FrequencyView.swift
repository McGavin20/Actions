//
//  FrequencyView.swift
//  Actions
//
//  Created by Sharma on 05/09/2023.
//

import SwiftUI

struct FrequencyView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedDays: String = "Sun"
    @State private var isWeeklyViewExpanded = false // New state
    
    var body: some View {
        VStack {
            Text("How often do you want to do it?")
            HStack() {
                Button(action: {
                    // Handle Daily button action
                }, label: {
                    ZStack {
                        Capsule()
                            .fill(Color.customIndigoMedium)
                            .frame(width: 80, height: 50)
                        Text("Daily")
                            .foregroundColor(.white)
                    }
                })
                
                Button(action: {
                    isWeeklyViewExpanded.toggle() // Toggle the state to expand/collapse
                }, label: {
                    ZStack {
                        Capsule()
                            .fill(Color.customIndigoMedium)
                            .frame(width: 80, height: 50)
                        Text("Weekly")
                            .foregroundColor(.white)
                    }
                })
                    
            }
            if isWeeklyViewExpanded {
                NavigationLink("", destination: WeeklyView(selectedDays: $selectedDays), isActive: $isWeeklyViewExpanded)
            }
        }
    }
}
