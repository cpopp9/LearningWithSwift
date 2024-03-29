//
//  ContentView.swift
//  UIKit-SwiftUI-Wrapper
//
//  Created by Cory Popp on 3/29/24.
//

import SwiftUI

struct ContentView: View {
    @State var title: String = "Awaiting Title"
    @State var description: String = "Our View Controller hasn't updated our SwiftUI View yet..."
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text(description)
                ViewControllerWrapper(title: $title, description: $description)
            }
            .padding()
            .navigationTitle(title)
        }
    }
}

#Preview {
    ContentView()
}
