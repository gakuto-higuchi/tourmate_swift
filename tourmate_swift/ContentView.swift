//
//  ContentView.swift
//  tourmate_swift
//
//  Created by gakutohiguchi on 2023/05/14.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(Color.pink)
                .multilineTextAlignment(.leading)
                .padding(0.0)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
