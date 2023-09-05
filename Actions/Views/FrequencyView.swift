//
//  FrequencyView.swift
//  Actions
//
//  Created by Sharma on 05/09/2023.
//

import SwiftUI

struct FrequencyView: View {
    var body: some View {
        VStack {
            Text("How often do you want to do it?")
            HStack() {
                Button(action: {
                    
                }, label: {
                    ZStack {
                        Capsule()
                            .fill(Color.customIndigoMedium)
                            .frame(width: 80, height: 50 )
                        Text("Daily")
                            .foregroundColor(.white)
                    }
                })
                
                Button(action: {
                    
                }, label: {
                    ZStack {
                        Capsule()
                            .fill(Color.customIndigoMedium)
                            .frame(width: 80, height: 50 )
                        Text("Weekly")
                            .foregroundColor(.white)
                    }
                })
                    
            }
        }
    }
}

struct FrequencyView_Previews: PreviewProvider {
    static var previews: some View {
        FrequencyView()
    }
}
