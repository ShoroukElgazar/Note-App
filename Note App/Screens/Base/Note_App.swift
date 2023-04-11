//
//  Note_App.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/6/23.
//

import SwiftUI

@main
struct Note_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashScreen.build()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
