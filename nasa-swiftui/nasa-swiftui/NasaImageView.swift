//
//  NasaImageView.swift
//  nasa-swiftui
//
//  Created by Brynner Ventura on 7/20/23.
//

import Foundation
import SwiftUI

struct NasaImageView: View {
    @ObservedObject var viewModel: ImageViewModel
    
    var body: some View {
        VStack {
            if !viewModel.imageURL.isEmpty {
                AsyncImage(url: URL(string: viewModel.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Text("Loading...")
                    .padding()
            }
        }
        .onAppear {
            viewModel.fetchImageURL()
        }
        .onChange(of: viewModel.date) { _ in
            viewModel.fetchImageURL()
        }
    }
}

class ImageViewModel: ObservableObject {
    @Published var date: Date
    @Published var imageURL: String = ""
    
    init(date: Date) {
        self.date = date
    }
    
    func fetchImageURL() {
        let apiKey = "kLH4jGZKbGLtfCOxfmyMzKwVQ3mIZYHwdcyfzpxW"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)&date=\(formattedDate)"
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(APODResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.imageURL = result.url
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
            .resume()
        }
    }
}

struct APODResponse: Codable {
    let url: String
}
