//
//  ContentView.swift
//  nasa-swiftui
//
//  Created by Brynner Ventura on 7/20/23.
//

import SwiftUI

struct ContentView: View {
    @State private var date = Date()
    @State private var size = 50.0
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            Text("NASA Image")
                .font(.title)
                .fontWeight(.semibold)
            NasaImageView()
            DatePicker(
                "Image Date",
                selection: $date,
                displayedComponents: [.date]
            )
            Slider(
                value: $size,
                in: 0...100,
                step: 5,
                onEditingChanged: { editing in
                    isEditing = editing
                }
            )
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
