//
//  AddButtonView.swift
//  Actions
//
//  Created by Sharma on 11/09/2023.
//

import SwiftUI
import AVFoundation

struct AddButtonView: View {
    
    @State private var isAnimated: Bool = false
    @State private var isAddingNewHabit = false
    private let soundPlayer = SoundPlayer()
    
    var body: some View {

        ZStack {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 55, height: 55)
                .foregroundColor(.customSalmonLight)
                .scaleEffect(isAnimated ? 0.6 : 1)
                .onAppear() {
                    withAnimation(Animation.easeInOut(duration: 0.7).repeatForever()) {
                        self.isAnimated.toggle()
                    }
                }
            
            Circle()
                .fill(Color.customSalmonLight.opacity(0.4))
                .frame(width: 80, height: 70)
                .scaleEffect(isAnimated ? 0.6 : 1)
            
            Circle()
                .fill(Color.customSalmonLight.opacity(0.3))
                .frame(width: 80, height: 90)
                .scaleEffect(isAnimated ? 0.6 : 1)
        }
    }
}


struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView()
    }
}



