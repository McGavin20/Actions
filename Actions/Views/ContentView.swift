//
//  ContentView.swift
//  Actions
//
//  Created by Sharma on 04/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeHabitsView()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
