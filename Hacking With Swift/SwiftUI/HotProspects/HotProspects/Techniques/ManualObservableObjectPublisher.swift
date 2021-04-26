//
//  ManualObservableObjectPublisher.swift
//  HotProspects
//
//  Created by Hayden Davidson on 3/16/21.
//

import SwiftUI

class delayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
    
}

struct ManualObservableObjectPublisher: View {
    @ObservedObject var updater = delayedUpdater()
    
    var body: some View {
        Text("Value is \(updater.value)")
    }
}

struct ManualObservableObjectPublisher_Previews: PreviewProvider {
    static var previews: some View {
        ManualObservableObjectPublisher()
    }
}
