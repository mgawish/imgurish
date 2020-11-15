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
            //MARK:- Title
            Text(post.title)
                .font(.title)
            
            //MARK:- Subtitle
            HStack {
                Text("Points: \(post.points)")
                    .font(.subheadline)
            }
            
            //MARK:- Image
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
            
            //MARK:- CTAs
            HStack(spacing: 16) {
                //MARK:- Up Points
                Button(action: {
                    print("Up Points")
                }) {
                    Image(systemName: "arrow.down")
                        .foregroundColor(.gray)
                }
                .buttonStyle(BorderlessButtonStyle())
                .frame(minWidth: 0, maxWidth: .infinity)
                
                //MARK:- Down Votes
                Button(action: {
                    print("Down Votes")
                }) {
                    Image(systemName: "arrow.up")
                        .foregroundColor(.gray)
                }
                .buttonStyle(BorderlessButtonStyle())
                .frame(minWidth: 0, maxWidth: .infinity)
                
                //MARK:- Comments
                Button(action: {
                    print("Comments")
                }) {
                    Image(systemName: "bubble.right")
                        .foregroundColor(.gray)
                }
                .buttonStyle(BorderlessButtonStyle())
                .frame(minWidth: 0, maxWidth: .infinity)
                
                //MARK:- Favorites
                Button(action: {
                    print("Favorites")
                }) {
                    Image(systemName: "heart")
                        .foregroundColor(.gray)
                }
                .buttonStyle(BorderlessButtonStyle())
                .frame(minWidth: 0, maxWidth: .infinity)
                
                //MARK:- Share
                Button(action: {
                    print("Share")
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.gray)
                }
                .buttonStyle(BorderlessButtonStyle())
                .frame(minWidth: 0, maxWidth: .infinity)
               
            }
            .frame(maxWidth: .infinity)
            
            HStack(spacing: 16) {
                ForEach(post.tags, id: \.id) { tag in
                    Text("\(tag.name)")
                }
            }
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
        List {
            PostView(post: Post(id: "1",
                                title: "Meme",
                                ups: 2,
                                downs: 1,
                                points: 10,
                                images: [],
                                tags: []))
            PostView(post: Post(id: "1",
                                title: "Meme",
                                ups: 2,
                                downs: 1,
                                points: 10,
                                images: [],
                                tags: []))
        }
       
    }
}
