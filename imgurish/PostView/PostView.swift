//
//  PostView.swift
//  imgurish
//
//  Created by Gawish on 07/11/2020.
//

import SwiftUI

struct PostView: View {
    var post: Post
    @StateObject var imageLoader: ImageLoader

    init(post: Post) {
        self.post = post
        _imageLoader = StateObject(wrappedValue: ImageLoader(post.firstImage?.link ?? "",
                                                             cache: Environment(\.imageCache).wrappedValue))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(post.title)
                .font(.title)
            Group {
                if imageLoader.image != nil {
                    Image(uiImage: imageLoader.image!)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200, alignment: .top)
                        .clipped()
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.green))
                        .frame(height: 200, alignment: .center)
                }
            }
            HStack(spacing: 16) {
                Text("\(post.ups)")
                    .foregroundColor(.green)
                Text("\(post.downs)")
                    .foregroundColor(.red)
                Text("\(post.points)")
            }
            HStack(spacing: 16) {
                ForEach(post.tags, id: \.id) { tag in
                    Text("\(tag.name)")

                }
            }
            Text("\(post.images?.first?.link ?? "")")
        }
        .onAppear {
            if imageLoader.image == nil {
                DispatchQueue.main.async {
                    imageLoader.load()
                }
            }
        }
        .colorScheme(.light)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: Post(id: "1",
                            title: "Meme",
                            ups: 2,
                            downs: 1,
                            points: 10,
                            images: [],
                            tags: []))
    }
}
