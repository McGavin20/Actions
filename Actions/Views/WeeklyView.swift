//
//  WeeklyView.swift
//  Actions
//
//  Created by Sharma on 06/09/2023.
//

import SwiftUI

struct WeeklyView: View {
    @Binding var selectedDays: String
    var body: some View {
        
        let days = Calendar.current.weekdaySymbols
        
        HStack(spacing: 8) {
            
            ForEach(days, id: \.self) { day in
                let index = HabitEntity.weekDays.firstIndex { value in
                    return value == day
                } ?? -1
                ZStack {
                    Circle()
                        .fill(index != -1 ? Color(HabitEntity.habitColor) :
                                .customIndigoMedium.opacity(0.4))
                        .frame(width: 49, height: 49)
                        .opacity(0.4)
                    
                    Text(day.prefix(2))
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                        .padding(.vertical, 12)
                }
                .onTapGesture {
                    withAnimation {
                        if index !=  -1 {
                            HabitEntity.weekDays.remove(at: index)
                        } else {
                            HabitEntity.weekDays.append((day))
                        }
                    }
                }
            }
        }
    }
}

struct WeeklyView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyView(selectedDays: .constant())
    }
}
