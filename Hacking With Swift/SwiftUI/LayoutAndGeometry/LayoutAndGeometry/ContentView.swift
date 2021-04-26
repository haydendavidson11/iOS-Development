//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Hayden Davidson on 3/19/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .background(Color.red)
            Text("Live long and prosper")
                .frame(width: 300, height: 300, alignment: .topLeadingS)
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

