//
//  ContentView.swift
//  OrzContacts
//
//  Created by joker on 2023/9/28.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(AppModel.self) var model
    
    var body: some View {
        
        List {
            ForEach(model.contacts) { contact in
                HStack {
                    Text("姓：" + contact.familyName + " " + "名：" + contact.givenName)
                }
            }
        }
        .listStyle(.automatic)
        .task {
            model.fetchAllContacts()
        }

    }
}

#Preview {
    ContentView()
}
