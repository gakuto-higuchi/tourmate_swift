//
//  HomeView.swift
//  tourmate_swift
//
//  Created by gakutohiguchi on 2023/05/28.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection){
            MapView()
                .tabItem {
                    Image(systemName: "house.fill")
                }.tag(0)
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }.tag(1)
            NewPostView()
                .tabItem {
                    Image(systemName: "plus.square")
                }.tag(2)
            FavoriteView()
                .tabItem {
                    Image(systemName: "heart.fill")
                }.tag(3)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                }.tag(4)
        }
        .accentColor(Color.pinkCustom)
    }
}


struct SearchView: View {
    var body: some View {
        Text("Search")
    }
}

struct NewPostView: View {
    var body: some View {
        Text("New Post")
    }
}

struct FavoriteView: View {
    var body: some View {
        Text("Favorites")
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppEnvironment())
    }
}

