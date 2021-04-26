//
//  TabViewTechnique.swift
//  HotProspects
//
//  Created by Hayden Davidson on 3/16/21.
//

import SwiftUI

struct TabViewTechnique: View {
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    self.selectedTab = 1
                }
                .tabItem { Image(systemName: "star")
                    Text("One")
                }
                .tag(0)
            Text("Tab 2")
                .onTapGesture {
                    self.selectedTab = 2
                }
                .tabItem { Image(systemName: "star.fill")
                    Text("Two")
                }
                .tag(1)
        }
    }
}

struct TabViewTechnique_Previews: PreviewProvider {
    static var previews: some View {
        TabViewTechnique()
    }
}
