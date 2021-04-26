//
//  ContentView.swift
//  Drawing
//
//  Created by Hayden Davidson on 2/19/21.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink("TriangleView", destination: TriangleView())
                    NavigationLink("ArcView", destination: ArcView())
                    NavigationLink("FlowerView", destination: FlowerView())
                    NavigationLink("Colored Circles", destination: ColoredCirclesView())
                    NavigationLink("Blended Circles", destination: BlendedCircles())
                    NavigationLink("Animated Shape", destination: AnimatedShapeView())
                    NavigationLink("CheckerBoard", destination: CheckerBoardView())
                    NavigationLink("Spirograph", destination: SpirographView())
                }
                .navigationTitle("Drawing Examples")
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

