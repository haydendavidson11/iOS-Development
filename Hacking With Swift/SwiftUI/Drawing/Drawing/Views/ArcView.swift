//
//  ArcView.swift
//  Drawing
//
//  Created by Hayden Davidson on 2/22/21.
//

import SwiftUI

struct ArcView: View {
    @State private var start: Double = 0
    @State private var end: Double = 360
    @State private var clockwise: Bool = false
    
    var body: some View {
        VStack {
            Arc(startAngle: .degrees(start), endAngle: .degrees(end), clockwise: clockwise)
                .strokeBorder(Color.blue, lineWidth: 5)
                .frame(width: 300, height: 300)
                .navigationTitle("ArcView")
            Text("Start Angle")
            Slider(value: $start, in: 0...360)
            Text("End Angle")
            Slider(value: $end, in: 0...360)
            Button(clockwise ? "CounterClockwise" : "Clockwise") {
                clockwise.toggle()
            }
        }
    }
}

struct ArcView_Previews: PreviewProvider {
    static var previews: some View {
        ArcView()
    }
}

//MARK: - Arc
struct Arc: InsettableShape{
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
        
    }
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        return path
    }
}
