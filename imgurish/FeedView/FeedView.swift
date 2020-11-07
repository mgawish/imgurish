//
//  ContentView.swift
//  imgurish
//
//  Created by Gawish on 05/11/2020.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel = FeedViewModel()
   
    var body: some View {
        VStack {
            Picker(selection: $viewModel.selectedPicker, label: Text("")) {
                ForEach(0..<GallerySection.allCases.count, id: \.self) { index in
                    Text("\(GallerySection.allCases[index].rawValue.capitalized)").tag(index)
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
