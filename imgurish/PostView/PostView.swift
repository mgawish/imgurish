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

    var onTapUp: ()->Void
    var onTapDown: ()->Void
    var onTapComment: ()->Void
    var onTapFav: ()->Void
    var onTapShare: ()->Void
    
    init(post: Post,
         onTapUp: @escaping ()->Void = {},
         onTapDown: @escaping ()->Void = {},
         onTapComment: @escaping ()->Void = {},
         onTapFav: @escaping ()->Void = {},
         onTapShare: @escaping ()->Void = {}) {
        self.post = post
        _imageLoader = StateObject(wrappedValue: ImageLoader(post.firstImage?.link ?? "",
                                                             cache: Environment(\.imageCache).wrappedValue))
        self.onTapUp = onTapUp
        self.onTapDown = onTapDown
        self.onTapComment = onTapComment
        self.onTapFav = onTapFav
        self.onTapShare = onTapShare
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            //MARK:- Title
            Text(post.title)
                .font(.title)
            
            Text(post.id)
            
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
                Button(action: onTapUp) {
                    Image(systemName: "arrow.down")
                        .foregroundColor(.gray)
                }
                .buttonStyle(BorderlessButtonStyle())
                .frame(minWidth: 0, maxWidth: .infinity)
                
                //MARK:- Down Votes
                Button(action: onTapDown) {
                    Image(systemName: "arrow.up")
                        .foregroundColor(.gray)
                }
                .buttonStyle(BorderlessButtonStyle())
                .frame(minWidth: 0, maxWidth: .infinity)
                
                //MARK:- Comments
                Button(action: onTapComment) {
                    Image(systemName: "bubble.right")
                        .foregroundColor(.gray)
                }
                .buttonStyle(BorderlessButtonStyle())
                .frame(minWidth: 0, maxWidth: .infinity)
                
                //MARK:- Favorites
                Button(action: onTapFav) {
                    if post.favorite {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.green)
                    } else {
                        Image(systemName: "heart")
                            .foregroundColor(.gray)
                    }
                    
                }
                .buttonStyle(BorderlessButtonStyle())
                .frame(minWidth: 0, maxWidth: .infinity)
                
                //MARK:- Share
                Button(action: onTapShare) {
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
    
    func applyFavorite() {
        
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
                                tags: [],
                                favorite: false))
            PostView(post: Post(id: "1",
                                title: "Meme",
                                ups: 2,
                                downs: 1,
                                points: 10,
                                images: [],
                                tags: [],
                                favorite: true))
        }
       
    }
}
