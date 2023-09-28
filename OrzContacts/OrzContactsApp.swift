//
//  OrzContactsApp.swift
//  OrzContacts
//
//  Created by joker on 2023/9/28.
//

import SwiftUI

@main
struct OrzContactsApp: App {
    
    @StateObject private var model = AppModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
