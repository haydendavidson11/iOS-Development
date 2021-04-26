//
//  NotificationsTechnique.swift
//  HotProspects
//
//  Created by Hayden Davidson on 3/16/21.
//

import SwiftUI
import UserNotifications

struct NotificationsTechnique: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
//                First
                
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert , .badge, .sound]) { (success, error) in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            Button("Schedule Notification") {
//                second
                let content = UNMutableNotificationContent()
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default
                    
                    
                   let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

struct NotificationsTechnique_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsTechnique()
    }
}
