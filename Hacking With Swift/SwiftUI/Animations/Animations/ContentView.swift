//
//  ContentView.swift
//  Animations
//
//  Created by Hayden Davidson on 2/11/21.
//

import SwiftUI

struct ContentView: View {
    let letters = Array("Hello SwiftUI")
    
    @State private var isShowingRed = false
//    @State private var dragAmount = CGSize.zero

    var body: some View {
        VStack{
            Button("Tap Me"){
                withAnimation {
                    self.isShowingRed.toggle()
                }
                
            }
            
            if isShowingRed{
            Rectangle()
                .fill(Color.red)
                .frame(width: 100, height: 100)
                .transition(.pivot)
            }
        }
    }
}

struct CornerRotationModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition{
    static var pivot: AnyTransition{
        .modifier(active: CornerRotationModifier(amount: -90, anchor: .topLeading), identity: CornerRotationModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
