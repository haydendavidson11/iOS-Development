//
//  ActionSheetView.swift
//  Instafilter
//
//  Created by Hayden Davidson on 3/12/21.
//

import SwiftUI

struct ActionSheetView: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Tap me to change my color")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Change Background"), message: Text("Select a new color"), buttons: [.default(Text("Red")){ self.backgroundColor = .red}, .default(Text("Green")){self.backgroundColor = .green}, .default(Text("Blue")) {self.backgroundColor = .blue}, .cancel()])
            }
    }
}

struct ActionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetView()
    }
}
