//
//  JobsView.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 3/30/21.
//

import SwiftUI
import RealmSwift

struct JobsView: View {
    
    @EnvironmentObject var state: AppState
    
    @State private var showAddJobSheet = false
    

    
    @ObservedResults(Client.self) var clients
//    @ObservedResults(Job.self) var jobs
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(clients , id: \.self) { client in
                        NavigationLink("\(Text(client.firstName)) \(Text(client.lastName))", destination: CardView(client: client))
                            
                    }
//                    .onDelete(perform: clients.jobs.remove())
                }
            }
            .padding()
            .navigationBarItems(leading: EditButton(), trailing: NavigationLink("Add Job", destination: AddJobView()
                                                                                    .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "public=public"))))
           
        }
    }
}

//struct JobsView_Previews: PreviewProvider {
//
//    static let address = Address(street: "385 1st ave", city: "New York", zip: "10010", state: "NY", country: "USA", gateCode: "12345")
//    static let client = Client(firstName: "hayden", lastName: "davidson", address: address, email: "haydendavidson@me.com", phoneNumber: "8137163618")
//
//    static var previews: some View {
//        JobsView(clients: client)
//    }
//}
