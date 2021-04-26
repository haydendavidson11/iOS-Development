////
////  AllowsHitTestingTechnique.swift
////  Flashzilla
////
////  Created by Hayden Davidson on 3/17/21.
////
//
//import SwiftUI
//
//struct AllowsHitTestingTechnique: View {
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .fill(Color.blue)
//                .frame(width: 300, height: 300)
//                .onTapGesture(perform: {
//                    print("Rectangle tapped!")
//                })
//            Circle()
//                .fill(Color.red)
//                .frame(width: 300, height: 300)
//                .contentShape(Rectangle())
//                .onTapGesture(perform: {
//                    print("Circle Tapped!")
//                })
//                .allowsHitTesting(false)
//        }
//        
//    }
//}
//
//struct AllowsHitTestingTechnique_Previews: PreviewProvider {
//    static var previews: some View {
//        AllowsHitTestingTechnique()
//    }
//}
