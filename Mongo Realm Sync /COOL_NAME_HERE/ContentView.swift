//
//  ContentView.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 3/27/21.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @EnvironmentObject var state: AppState
    
    
    @State private var userName = ""
    @State private var password = ""
    
    var body: some View {
       
        ZStack {
            VStack {
                if state.loggedIn {
                    if (state.user != nil) {
                        MainView()
                            .environment(\.realmConfiguration,
                                         app.currentUser!.configuration(partitionValue: "user=\(state.user?._id ?? "")"))
                    }
                } else {
                    LoginView()
                }
                Spacer()
                if let error = state.error {
                    Text("Error: \(error)")
                        .foregroundColor(Color.red)
                }
            }
            if state.shouldIndicateActivity {
                        ProgressView("Working With Realm")
                    }
        }
        
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
