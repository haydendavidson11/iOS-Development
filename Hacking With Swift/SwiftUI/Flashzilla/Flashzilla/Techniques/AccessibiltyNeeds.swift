////
////  AccessibiltyNeeds.swift
////  Flashzilla
////
////  Created by Hayden Davidson on 3/18/21.
////
//
//import SwiftUI
//
//struct AccessibiltyNeeds: View {
//    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
//    
//    var body: some View {
//        HStack {
//            if differentiateWithoutColor {
//                Image(systemName: "checkmark.circle")
//            }
//            
//            Text("Success")
//        }
//        .padding()
//        .background(differentiateWithoutColor ? Color.black : Color.green)
//        .foregroundColor(.white)
//        .clipShape(Capsule())
//    }
//}
//
////MARK: - Reduce movement
//struct ReduceMovment: View {
//    @Environment(\.accessibilityReduceMotion) var reduceMotion
//    @State private var scale: CGFloat = 1
//    
//    var body: some View {
//        Text("Hello, World!")
//            .scaleEffect(scale)
//            .onTapGesture {
//                withOptionalAnimation {
//                    self.scale *= 1.5
//                    
//                }
//            }
//    }
//    
//    
//    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
//        if UIAccessibility.isReduceMotionEnabled {
//            return try body()
//        } else {
//            return try withAnimation(animation, body)
//        }
//    }
//}
//
////MARK: -  Reduce transparency
//
//struct ReduceTransparency: View {
//    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
//    var body: some View {
//        Text("Hello, World!")
//            .padding()
//            .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
//            .foregroundColor(Color.white)
//            .clipShape(Capsule())
//    }
//}
//
//struct AccessibiltyNeeds_Previews: PreviewProvider {
//    static var previews: some View {
//        AccessibiltyNeeds()
//    }
//}
