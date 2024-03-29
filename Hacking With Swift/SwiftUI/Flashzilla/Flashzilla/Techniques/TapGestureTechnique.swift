////
////  TapGestureTechnique.swift
////  Flashzilla
////
////  Created by Hayden Davidson on 3/17/21.
////
//
//import SwiftUI
//
//struct TapGestureTechnique: View {
//    var body: some View {
//        Text("Hello, World!")
//            .onTapGesture(count: 2) {
//                print("Double taped")
//            }
//        Text("Hello, World!")
//            .onLongPressGesture(minimumDuration: 2) {
//                print("Tripple taped")
//            }
//        Text("Hello, Mars!")
//            .onLongPressGesture(minimumDuration: 2,  pressing: { inProgress in
//                print("in progress \(inProgress)")
//            }) {
//                print("long pressed!")
//            }
//    }
//}
//
////MARK: - Magnification View
//
//struct MagnificationView: View {
//    
//    @State private var currentAmount: CGFloat = 0
//    @State private var finalAmount: CGFloat = 1
//    
//    var body: some View {
//        Text("Hello, Magnification")
//            .scaleEffect(currentAmount + finalAmount)
//            .gesture(MagnificationGesture()
//                        .onChanged { (amount) in
//                            self.currentAmount = amount - 1
//                        }
//                        .onEnded{ (amount) in
//                            self.finalAmount += self.currentAmount
//                            self.currentAmount = 0
//                        }
//            )
//    }
//}
//
//
//struct RotationView: View {
//    @State private var currentAmount: Angle = .degrees(0)
//    @State private var finalAmount: Angle = .degrees(0)
//    
//    var body: some View {
//        Text("Hello, World!")
//            .rotationEffect(currentAmount + finalAmount)
//            .gesture(
//                RotationGesture()
//                    .onChanged { angle in
//                        self.currentAmount = angle
//                    }
//                    .onEnded { angle in
//                        self.finalAmount += self.currentAmount
//                        self.currentAmount = .degrees(0)
//                    }
//            )
//    }
//}
//
//struct ParentGestureView: View {
//    var body: some View {
//        VStack {
//            Text("Hello, World!")
//                .onTapGesture {
//                    print("Text tapped")
//                }
//        }
//        .onTapGesture {
//            print("VStack tapped")
//        }
//    }
//}
//
//// highPriorityGesture for the parent view alternative
////var body: some View {
////        VStack {
////            Text("Hello, World!")
////                .onTapGesture {
////                    print("Text tapped")
////                }
////        }
////        .highPriorityGesture(
////            TapGesture()
////                .onEnded { _ in
////                    print("VStack tapped")
////                }
////        )
////    }
//
//// simultaneousGesture alternative
////var body: some View {
////        VStack {
////            Text("Hello, World!")
////                .onTapGesture {
////                    print("Text tapped")
////
////                }
////        }
////        .simultaneousGesture(
////            TapGesture()
////                .onEnded { _ in
////                    print("VStack tapped")
////                }
////        )
////    }
//
//
//// Gesture Sequences
//
////struct GestureSequenceView: View {
////    // how far the circle has been dragged
////    @State private var offset = CGSize.zero
////
////    // where it is currently being dragged or not
////    @State private var isDragging = false
////
////    var body: some View {
////        // a drag gesture that updates offset and isDragging as it moves around
////        let dragGesture = DragGesture()
////            .onChanged { value in self.offset = value.translation }
////            .onEnded { _ in
////                withAnimation {
////                    self.offset = .zero
////                    self.isDragging = false
////                }
////            }
////
////        // a long press gesture that enables isDragging
////        let tapGesture = LongPressGesture()
////            .onEnded { value in
////                withAnimation {
////                    self.isDragging = true
////                }
////            }
////
////        // a combined gesture that forces the user to long press then drag
////        let combined = tapGesture.sequenced(before: dragGesture)
////
////        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
////        return Circle()
////            .fill(Color.red)
////            .frame(width: 64, height: 64)
////            .scaleEffect(isDragging ? 1.5 : 1)
////            .offset(offset)
////            .gesture(combined)
////    }
////}
//
//struct TapGestureTechnique_Previews: PreviewProvider {
//    static var previews: some View {
//        MagnificationView()
//    }
//}
