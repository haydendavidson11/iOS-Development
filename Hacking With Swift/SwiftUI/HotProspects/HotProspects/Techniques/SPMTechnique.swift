//
//  SPMTechnique.swift
//  HotProspects
//
//  Created by Hayden Davidson on 3/16/21.
//

import SwiftUI
import SamplePackage

struct SPMTechnique: View {
    let possibleAnswers = Array(1...60)
    
    var results: String {
        let selected = possibleAnswers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        Text(results)
    }
}

struct SPMTechnique_Previews: PreviewProvider {
    static var previews: some View {
        SPMTechnique()
    }
}
