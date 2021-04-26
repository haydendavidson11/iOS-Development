//
//  ImageInterpolationTechnique.swift
//  HotProspects
//
//  Created by Hayden Davidson on 3/16/21.
//

import SwiftUI

struct ImageInterpolationTechnique: View {
    var body: some View {
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ImageInterpolationTechnique_Previews: PreviewProvider {
    static var previews: some View {
        ImageInterpolationTechnique()
    }
}
