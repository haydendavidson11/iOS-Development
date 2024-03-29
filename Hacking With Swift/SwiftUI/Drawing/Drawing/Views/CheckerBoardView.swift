//
//  CheckerBoard.swift
//  Drawing
//
//  Created by Hayden Davidson on 2/23/21.
//

import SwiftUI

struct CheckerBoardView: View {
    @State private var rows = 4
    @State private var columns = 4
    
    
    var body: some View {
        Checkerboard(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)){
                    self.rows = 8
                    self.columns = 16
                }
            }
    }
}

struct CheckerBoard_Previews: PreviewProvider {
    static var previews: some View {
        CheckerBoardView()
    }
}



struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    
    public var animatableDatat: AnimatablePair<Double, Double> {
        get {AnimatablePair(Double(rows), Double(columns))}
        set { self.rows = Int(newValue.first)
              self.columns = Int(newValue.second)
        }
    }
    
    
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / CGFloat(rows)
        let columnSize = rect.width / CGFloat(columns)
        
        for row in 0..<rows {
            for column in 0..<columns{
                if (row + column).isMultiple(of: 2){
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
            
        }
        return path
    }
    
}
