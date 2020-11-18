//
//  UserView.swift
//  imgurish
//
//  Created by Gawish on 15/11/2020.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var viewModel = UserViewModel()
    
    var body: some View {
        VStack {
            if viewModel.user != nil {
                Text("logged in")
            } else {
                Text("not logged in")
            }
        }
        .onAppear(perform: {
            viewModel.fetchUserDetails()
        })
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
