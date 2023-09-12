//
//  HomeHabitsView.swift
//  Actions
//
//  Created by Sharma on 29/08/2023.
//

import SwiftUI

struct HomeHabitsView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                // Displayed Habits to be tracked.
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        AddButtonView()
                            .padding(25)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
}

struct HomeHabitsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHabitsView()
    }
}
