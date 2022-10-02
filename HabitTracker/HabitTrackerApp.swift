//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Vitor Trimer on 30/09/22.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
