//
//  HabitViewModel.swift
//  HabitTracker
//
//  Created by Vitor Trimer on 30/09/22.
//

import Foundation
import CoreData

class HabitViewModel: ObservableObject {
    
    @Published var addNewHabit: Bool = false
    
    @Published var title: String = ""
    @Published var habitColor: String = "Card-1"
    @Published var weekDays: [String] = []
    @Published var isReminderOn: Bool = false
    @Published var reminderText: String = ""
    @Published var reminderDate: Date = Date()
    
}
