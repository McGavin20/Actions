//
//  CircleColorPicker.swift
//  Actions
//
//  Created by Sharma on 05/09/2023.
//

import SwiftUI

struct CircleColorPicker: View {
    @Binding var selectedColor: Color
    
    
    let colors: [Color] = [
        .customGrayLight,
        .customGreenDark,
        .customGrayMedium,
        .customGreenLight,
        .customSalmonLight,
        .customIndigoMedium,
        .customGreenMedium
    ]
    var body: some View {
        HStack(spacing: 8) {
            ForEach(colors, id: \.self) { color in
                Circle()
                    .fill(color)
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        self.selectedColor = color
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
