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
        List(viewModel.posts) { post in
            Text(post.title)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        return FeedView()
    }
}
