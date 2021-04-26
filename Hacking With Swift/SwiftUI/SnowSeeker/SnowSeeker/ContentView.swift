//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Hayden Davidson on 3/19/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView{
            Text("Hello, world!")
                .navigationTitle("Primary")
            Text("Secondary")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



