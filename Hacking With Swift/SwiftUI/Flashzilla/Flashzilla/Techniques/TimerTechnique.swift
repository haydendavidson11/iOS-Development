////
////  TimerTechnique.swift
////  Flashzilla
////
////  Created by Hayden Davidson on 3/17/21.
////
//
//import SwiftUI
//
//struct TimerTechnique: View {
//    @State private var counter = 0
//    
//    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
//    
//    var body: some View {
//        Text("Hello, World!")
//            .onReceive(timer) { time in
//                
//                if self.counter == 5 {
//                    self.timer.upstream.connect().cancel()
//                }else {
//                    print("The time is now \(time)")
//                }
//                self.counter += 1
//            }
//    }
//}
//
//struct TimerTechnique_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerTechnique()
//    }
//}
