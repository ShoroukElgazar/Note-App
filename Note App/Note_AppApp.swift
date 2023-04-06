//
//  Note_AppApp.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/6/23.
//

import SwiftUI

@main
struct Note_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
