//
//  ContentView.swift
//  BucketList
//
//  Created by Hayden Davidson on 3/13/21.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var showingErrorScreen = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    
    
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        //                        Error
                        errorTitle = "Sorry"
                        errorMessage = "You are not the owner of this information"
                        showingErrorScreen = true
                    }
                }
            }
        } else {
            //            no biometrics
            errorTitle = "Sorry"
            errorMessage = "Biometric Authentication Needed to access this Data"
            showingErrorScreen = true
        }
    }
    
    var body: some View {
        
        
        ZStack {
            if isUnlocked{
                //               Challenge 2 Create a new view for content requiring authenication
                UnlockedView()
                
            } else {
                //                Authenticate Button
                Button("Unlock") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                
            }
        }
        
//        Havent been able to get this to work yet!
        
//        .alert(isPresented: $showingErrorScreen) {
//            Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
//        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
