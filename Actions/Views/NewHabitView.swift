//
//  NewHabitView.swift
//  Actions
//
//  Created by Sharma on 17/08/2023.
//

import SwiftUI
import CoreData

struct NewHabitView: View {
    // Properties
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.self) var env
    @StateObject var habitModel: HabitViewModel = .init()
    @StateObject var vm = HabitViewModel()
    @State private var habitTitle = ""
    @State private var selectedColor: Color = .customGrayLight // Default Color
    @State private var isHomeHabitsViewActive = false
        

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Habit")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("Name it something short and memorable.")
                        .font(.caption2)
                        .foregroundColor(Color.customGrayLight)
                } //Title
                
                //TextField for Ttile
                TextField("Habit Title", text: $habitModel.title)
                    .padding(.vertical, 10)
                    .background(Color.customGrayMedium.opacity(0.4), in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                
                Divider()
                    .padding(.vertical, 10)
                CircleColorPicker(selectedColor: $selectedColor)
                    .padding(.vertical)
                Divider()
                    .padding(.vertical, 10)
                FrequencyView()
                    .padding()
                Divider()
                    .padding(.vertical, 10)
                
                
                // Hiding if Notification Access is rejected
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Reminder")
                            .fontWeight(.semibold)
                        
                        Text("Just Notification")
                            .font(.caption)
                            .foregroundColor(.customSalmonLight)
                    }
                    .frame(maxWidth: .infinity, alignment: .top)
                    
                    Toggle(isOn: $habitModel.isRemainderOn) {}
                        .labelsHidden()
                }
                .opacity(habitModel.notificationAccess ? 1 : 0)
                
                HStack(spacing: 12) {
                    Label {
                        Text(habitModel.remainderDate.formatted(date: .omitted, time: .shortened))
                    } icon: {
                        Image(systemName: "clock")
                    }
                    .padding(.horizontal)
                    .padding(.vertical,12)
                    .background(Color.customSalmonLight.opacity(0.4), in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                    .onTapGesture {
                        habitModel.showTimePicker.toggle()
                    }
                    TextField("Remainder Text", text: $habitModel.remainderText)
                        .padding(.vertical, 10)
                        .background(Color.customGrayMedium.opacity(0.4), in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                }
                .frame(height: habitModel.isRemainderOn ? nil : 0)
                .opacity(habitModel.isRemainderOn ? 1 : 0)
                .opacity(habitModel.notificationAccess ? 1 : 0)
            }
            .animation(.easeInOut, value: habitModel.isRemainderOn)
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        env.dismiss()
                        print("Button pressed: Cancel")
                    }, label: {
                        Text("Cancel")
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        if habitModel.deleteHabit(context: env.managedObjectContext) {
                            print("Button pressed: Delete")
                            env.dismiss()
                        }
                        
                    }, label: {
                        Image(systemName: "trash")
                    })
                    .tint(.red)
                    .opacity(habitModel.editHabit == nil ? 0 : 1)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        Task {
                            if await habitModel.addNewHabit(context: env.managedObjectContext) {
                                env.dismiss()
                            }
                        }
                    }, label: {
                        Text("Save")
                    })
                    .padding()
                    .tint(.customSalmonLight)
                    .disabled(!habitModel.doneStatus())
                    //.background(NavigationLink("", destination: HomeHabitsView(habitData: habitData, isDarkMode: .constant(true)), isActive: $isHomeHabitsViewActive))
                }
                
            }
        }
        .overlay {
            if habitModel.showTimePicker {
                ZStack {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture {
                            habitModel.showTimePicker.toggle()
                        }
                    
                    DatePicker.init("", selection: $habitModel.remainderDate, displayedComponents: [.hourAndMinute])
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.customSalmonLight)
                        }
                        .padding()
                }
            }
        }
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitView()
            .environmentObject(HabitViewModel())
    }
}
