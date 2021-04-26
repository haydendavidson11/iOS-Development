//
//  TriangleView.swift
//  Drawing
//
//  Created by Hayden Davidson on 2/22/21.
//

import SwiftUI

struct TriangleView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
        }
        .stroke(Color.blue, lineWidth: 10)
        .navigationTitle("TriangleView")
    }
}

struct TriangleView_Previews: PreviewProvider {
    static var previews: some View {
        TriangleView()
    }
}
