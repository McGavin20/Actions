//
//  HabitData.swift
//  Actions
//
//  Created by Sharma on 13/09/2023.
//

import Foundation
import SwiftUI
import CoreData

class HabitData: ObservableObject {
    @Published var habits: [Habit] = [] // Stores the user's habits here
}
