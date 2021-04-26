//
//  Cool_Name_Here-App.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 4/12/21.
//

import SwiftUI
import RealmSwift

let app = RealmSwift.App(id: "cool_name_here-cncln")

@main
struct Cool_Name_Here_app: SwiftUI.App {
    @StateObject var state = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(state)
        }
    }
}
