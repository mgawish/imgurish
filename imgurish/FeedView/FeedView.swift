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
            //MARK:- Picker
            Picker(selection: $viewModel.selectedPicker, label: Text("")) {
                ForEach(0..<GallerySection.allCases.count, id: \.self) { index in
                    Text("\(GallerySection.allCases[index].rawValue.capitalized)").tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle())
            .background(Color.white)
            
            Spacer()
            
            //MARK: Content
            if viewModel.posts.isEmpty {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.green))
                Spacer()
            } else {
                List(viewModel.posts) { post in
                    PostView(post: post,
                             onTapUp: { viewModel.onTapUp(post) },
                             onTapDown: { viewModel.onTapDown(post) },
                             onTapFav: { viewModel.onTapFav(post) })
                }
            }
        }
        .background(Color.background)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        GallerySection.allCases.forEach { section in
        }
        return FeedView()
    }
}
