//
//  ContentView.swift
//  imgurish
//
//  Created by Gawish on 05/11/2020.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel = FeedViewModel()
    @State var selectedPicker = 0
   
    
    var body: some View {
        VStack {
            Picker("picker", selection: $selectedPicker) {
                ForEach(GallerySection.allCases, id: \.self) { section in
                    Text("\(section.rawValue.capitalized)")
                }
            }.pickerStyle(SegmentedPickerStyle())
            Spacer()

            if viewModel.posts.isEmpty {
                ProgressView()
                Spacer()
            } else {
                List(viewModel.posts) { post in
                    Text(post.title)
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        GallerySection.allCases.forEach { section in
        }
        return FeedView()
    }
}
