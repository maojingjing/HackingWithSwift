//
//  iTourApp.swift
//  iTour
//
//  Created by Jingjing Mao on 2/15/24.
//

import SwiftUI
import SwiftData

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
