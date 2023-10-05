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
    @FetchRequest(entity: HabitEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \HabitEntity.dateAdded, ascending: false)], predicate: nil, animation: .easeInOut) var habits: FetchedResults<HabitEntity>
    @StateObject var habitModel: HabitViewModel = .init()
    private let soundPlayer = SoundPlayer()
    private let feedback = UIImpactFeedbackGenerator(style: .light)
    @State private var onAddHabitToggle: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                // Navigation Title
                HStack {
                    Text("Actions")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading)
                        .foregroundColor(.customSalmonLight)
//                    Spacer()
//                    Button(action: {
//                        // TOGGLE APPEARANCE
//                        isDarkMode.toggle()
//                        soundPlayer.playSound(soundFileName: "sound-tap")
//                        feedback.impactOccurred()
//                    }, label: {
//                        Image(systemName:  self.isDarkMode ? "moon.circle.fill" :  "moon.circle")
//                            .resizable()
//                            .frame(width: 24, height: 24)
//                            .font(.system(.title, design: .rounded))
//                    })
//                    .padding(.trailing)
//                    .foregroundColor(Color.customSalmonLight)
                } // HSTACK
                .padding(.bottom, 10)
                
                // Main View
                ScrollView(habits.isEmpty ? .init() : .vertical, showsIndicators: false) {
                    VStack(spacing: 15) {
                        // Displayed Habits to be tracked.
                        ForEach(habits) { habit in
                            HabitCardView(habit: habit)
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding()
                    .sheet(isPresented: $habitModel.addNewHabit) {
                        habitModel.resetData()
                    } content: {
                        NewHabitView()
                            .environmentObject(habitModel)
                    }
                }
                
                
                //Button to add new habit
                AddButtonView()
                    .onTapGesture {
                        onAddHabitToggle.toggle()
                        habitModel.addNewHabit.toggle()
                    }
                    
            }
            .sheet(isPresented: $onAddHabitToggle) {
                NewHabitView()
            }
            
        }
        
        .navigationBarBackButtonHidden(true)
    }
    // Habit Card View
    
    func HabitCardView(habit: HabitEntity)->some View {
        VStack(spacing: 6){
            HStack{
                Text(habit.title ?? "")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                
                Image(systemName: "ball.badge.fill")
                    .font(.callout)
                    .foregroundColor(habit.color ?? .customGrayMedium)
                    .scaleEffect(0.9)
                    .opacity(habit.isRemainderOn ? 1 : 0)
                
                Spacer()
                
                let count = (habit.weekDays?.count ?? 0)
                Text(count == 7 ? "Daily": "\(count) times a week")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 10)
            
            // Displaying Current Week and Marking Active Dates of Habit
            let calender = Calendar.current
            let currentWeek = calender.dateInterval(of: .weekOfMonth, for: Date())
            let symbols = calender.weekdaySymbols
            let startDate = currentWeek?.start ?? Date()
            let activeWeekDays = habit.weekDays ?? []
            let activePlot = symbols.indices.compactMap { index -> (String, Date) in
                let currentDate = calender.date(byAdding: .day, value: index, to: startDate)
                return (symbols[index], currentDate!)
            }
            
            HStack(spacing: 10) {
                ForEach(activePlot.indices, id: \.self) {index in
                    let item = activePlot[index]
                    
                    VStack(spacing: 6) {
                        // Limiting to first three letters
                        Text(item.0.prefix(3))
                            .font(.caption)
                            .foregroundColor(.customGrayMedium)
                        
                        let status = activeWeekDays.contains { day in
                            return day == item.0
                        }
                        
                        Text(getDate(date: item.1))
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .padding(8)
                            .background {
                                Circle()
                                    .fill(Color(habit.color ?? Color.customGrayMedium))
                                    .opacity(status ? 1 : 0)
                            }
                    }
                    .frame().frame(maxWidth: .infinity)
                    
                }
            }
            .padding(.top, 15)
        }
        .padding(.vertical)
        .padding(.horizontal, 6)
        .background() {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.customIndigoMedium.opacity(0.5))
        }
        .onTapGesture {
            // Editing Habit
            habitModel.editHabit = habit
            habitModel.restoreEditData()
            habitModel.addNewHabit.toggle()
        }
    }
    
    // Formatting date
    func getDate(date: Date)->String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        
        return formatter.string(from: date)
    }
}

struct HomeHabitsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
