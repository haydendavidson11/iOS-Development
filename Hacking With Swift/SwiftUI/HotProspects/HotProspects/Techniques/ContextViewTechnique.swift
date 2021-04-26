//
//  ContextViewTechnique.swift
//  HotProspects
//
//  Created by Hayden Davidson on 3/16/21.
//

import SwiftUI

struct ContextViewTechnique: View {
    
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack{
        Text("Hello, World!")
            .padding()
            .background(backgroundColor)
        Text("Change Color")
            .padding()
            .contextMenu(ContextMenu(menuItems: {
                Button(action: {self.backgroundColor = .red}) {
                    Text("Red")
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.red)
                    
                }
                Button(action: {self.backgroundColor = .green}) {
                    Text("Green")
                }
                Button(action: {self.backgroundColor = .blue}) {
                    Text("Blue")
                }
            }))
        }
    }
}

struct ContextViewTechnique_Previews: PreviewProvider {
    static var previews: some View {
        ContextViewTechnique()
    }
}
