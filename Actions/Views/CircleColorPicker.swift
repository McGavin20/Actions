//
//  CircleColorPicker.swift
//  Actions
//
//  Created by Sharma on 05/09/2023.
//

import SwiftUI

struct CircleColorPicker: View {
    @StateObject var habitModel: HabitViewModel = .init()
    @Binding var selectedColor: Color
    
    
//    let colors: [Color] = [
//        .customGrayLight,
//        .customGreenDark,
//        .customGrayMedium,
//        .customGreenLight,
//        .customSalmonLight,
//        .customIndigoMedium,
//        .customGreenMedium
//    ]
    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...7, id: \.self) { index in
                let color = "Card-\(index)"
                Circle()
                    .fill(Color(color))
                    .frame(width: 30, height: 30)
                    .overlay(content: {
                        if color == habitModel.habitColor {
                            Image(systemName: "checkmark")
                                .font(.caption.bold())
                        }
                    })
                    .onTapGesture {
                        withAnimation {
                            habitModel.habitColor = color
                        }
                    }
            }
        }
    }
}

struct CircleColorPicker_Previews: PreviewProvider {
    @State static var previewSelectedColor = Color.customGreenLight // Initial color for preview
    static var previews: some View {
        CircleColorPicker(selectedColor: $previewSelectedColor)
    }
}
