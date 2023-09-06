//
//  WeeklyView.swift
//  Actions
//
//  Created by Sharma on 06/09/2023.
//

import SwiftUI

struct WeeklyView: View {
    @Binding var selectedDays: String
    
    let days: [String] = [
        "Sun",
        "Mon",
        "Tues",
        "Wed",
        "Thurs",
        "Fri",
        "Sat"
    ]
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(days, id: \.self) { day in
                ZStack {
                    Circle()
                        .fill(selectedDays == day ? Color.customIndigoMedium : Color.customGrayLight)
                        .frame(width: 49, height: 49)
                    
                    Text(day)
                        .foregroundColor(Color.white)
                        .font(.headline)
                }
                .onTapGesture {
                    self.selectedDays = day
                }
            }
        }
    }
}

struct WeeklyView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyView(selectedDays: .constant("Sun"))
    }
}
