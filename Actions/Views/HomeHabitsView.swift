//
//  HomeHabitsView.swift
//  Actions
//
//  Created by Sharma on 29/08/2023.
//

import SwiftUI
import CoreData
import AVFoundation

class SoundPlayer {
    var audioPlayer: AVAudioPlayer?

    func playSound(soundFileName: String, ofType: String = "mp3") {
        if let path = Bundle.main.path(forResource: soundFileName, ofType: ofType) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.volume = 1.0
                audioPlayer?.numberOfLoops = 0
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}

struct HomeHabitsView: View {
    @ObservedObject var habitData: HabitData
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    private let soundPlayer = SoundPlayer()
    private let feedback = UIImpactFeedbackGenerator(style: .light)
    @State private var onAddHabitToggle: Bool = false

    var body: some View {
        NavigationView {
            VStack(alignment: .trailing) {
                Button(action: {
                    // TOGGLE APPEARANCE
                    isDarkMode.toggle()
                    soundPlayer.playSound(soundFileName: "sound-tap")
                    feedback.impactOccurred()
                }, label: {
                    Image(systemName: isDarkMode ? "moon.circle.fill" :  "moon.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .font(.system(.title, design: .rounded))
                })
                .padding()
                .foregroundColor(Color.customSalmonLight)
                
                // Displayed Habits to be tracked.
                List {
                    ForEach(habitData.habits) { habit in
                        Text("Habit Title: \(habit.title ?? "")")
                            .foregroundColor(.customGrayLight)
                    }
                    .onDelete(perform: deleteHabit)
                }
                
                //Button to add new habit
                AddButtonView(habitData: habitData)
                    .onTapGesture {
                        onAddHabitToggle.toggle()
                    }
                    .padding()
            }
            .sheet(isPresented: $onAddHabitToggle) {
                NewHabitView(habitData: habitData)
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func deleteHabit(offsets: IndexSet) {
        // Handle deletion here, including removing the habit from habitData.habits
    }
}

struct HomeHabitsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHabitsView(habitData: HabitData())
    }
}
