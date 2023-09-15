//
//  AddButtonView.swift
//  Actions
//
//  Created by Sharma on 11/09/2023.
//

import SwiftUI

struct AddButtonView: View {
    
    @State private var isAnimated: Bool = false
    
    var body: some View {
        Button(action: {
            // Add action here for when the button is tapped
            print("Add Button was pressed.")
        }) {
            ZStack {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 65, height: 65)
                    .foregroundColor(.customSalmonLight)
                    .scaleEffect(isAnimated ? 0.6 : 1)
                    .onAppear() {
                        withAnimation(Animation.easeInOut(duration: 0.5).repeatForever()) {
                            self.isAnimated.toggle()
                        }
                    }
                
                Circle()
                    .fill(Color.customSalmonLight.opacity(0.4))
                    .frame(width: 90, height: 90)
                    .scaleEffect(isAnimated ? 1.2 : 1)
                
                Circle()
                    .fill(Color.customSalmonLight.opacity(0.3))
                    .frame(width: 110, height: 1100)
                    .scaleEffect(isAnimated ? 1.2 : 1)
            }
        }
    }
}


struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView()
    }
}
