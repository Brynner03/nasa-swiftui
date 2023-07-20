//
//  ContentView.swift
//  nasa-swiftui
//
//  Created by Brynner Ventura on 7/20/23.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var date = Date()
    @State private var size = 50.0
    @State private var isEditing = false
    @StateObject private var viewModel = ImageViewModel(date: Date())

    var body: some View {
        VStack {
            Text("NASA Image")
                .font(.title)
                .fontWeight(.semibold)
            NasaImageView(viewModel: viewModel, size: CGFloat(size)) // Pass the size value to NasaImageView
            DatePicker(
                "Image Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .onChange(of: date) { _ in
                viewModel.date = date
                viewModel.fetchImageURL()
            }
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
