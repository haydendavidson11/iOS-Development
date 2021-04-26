//
//  FlowerView.swift
//  Drawing
//
//  Created by Hayden Davidson on 2/22/21.
//

import SwiftUI

struct FlowerView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    var body: some View {
        VStack{
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(Color.red, style: FillStyle(eoFill: true))
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
            
        }
        .navigationTitle("FlowerView")
    }
}


struct FlowerView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerView()
    }
}


//MARK: - flowerPetal

struct Flower: Shape {
    
    //    how much to move the flower pedal
    var petalOffset: Double = -20
    //    petalwidth
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        //            the path that will hold all the petals
        
        var path = Path()
        
        //         count from 0 up to pie * 2 ,
        //        moving up pie/8  for each step
        
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            
            //     rotate the petal by the current value of our loop
            
            let rotation = CGAffineTransform(rotationAngle: number)
            
            //            Move the petal to be at the center of our view
            let positon = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            //            creat a path for this petal with our properties plus a fixed y and height
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
            //            applly the rotation/position transformation to the petal
            let rotatedPetal = originalPetal.applying(positon)
            
            //            apply the new petal to our path
            path.addPath(rotatedPetal)
        }
        return path
    }
    
}
