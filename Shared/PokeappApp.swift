//
//  PokeappApp.swift
//  Shared
//
//  Created by Marco Cordoba on 24-08-22.
//

import SwiftUI

@main
struct PokeappApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
