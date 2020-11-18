//
//  MainView.swift
//  imgurish
//
//  Created by Gawish on 15/11/2020.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Feed")
                }.tag(0)
            UserView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("User")
                }.tag(1)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
