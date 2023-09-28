//
//  ContentView.swift
//  OrzContacts
//
//  Created by joker on 2023/9/28.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: AppModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            model.fetchAllContacts()
        }
    }
}

#Preview {
    ContentView()
}
