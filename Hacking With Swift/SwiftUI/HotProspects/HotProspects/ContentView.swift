//
//  ContentView.swift
//  HotProspects
//
//  Created by Hayden Davidson on 3/16/21.
//

import SwiftUI

struct ContentView: View {
    var prospects = Prospects()
    
    var body: some View {
        TabView {
            ProspectsView(filter: .none, order: .recent)
                .tabItem { Image(systemName: "person.3")
                    Text("Everyone")
                }
            ProspectsView(filter: .contacted, order: .recent)
                .tabItem { Image(systemName: "checkmark.circle")
                    Text("Contacted")
                }
            ProspectsView(filter: .uncontacted, order: .recent)
                .tabItem { Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
                }
            MeView()
                .tabItem { Image(systemName: "person.crop.square")
                    Text("Me")
                }
        }.environmentObject(prospects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
