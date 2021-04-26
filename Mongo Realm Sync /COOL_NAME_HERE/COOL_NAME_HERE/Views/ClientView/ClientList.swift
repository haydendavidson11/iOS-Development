//
//  ClientList.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 4/8/21.
//

import SwiftUI
import RealmSwift

struct ClientList: View {
    @EnvironmentObject var state: AppState
    @ObservedResults(Client.self) var clients
    
    
    var body: some View {
        List{
            ForEach(clients, id: \.id) { client in
                NavigationLink("\(Text(client.firstName)) \(Text(client.lastName))", destination: CardView(client: client))
            }.onDelete(perform: $clients.remove)
            
            
        }
        .navigationTitle("Clients")
        .navigationBarItems(leading: EditButton(), trailing: NavigationLink("Add Client", destination: AddClientView(clients: $clients)
                                                                                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "public=public"))))
        .listStyle(SidebarListStyle())

    }
}

//struct ClientList_Previews: PreviewProvider {
//    static let address = Address(street: "385 1st ave", city: "New York", zip: "10010", state: "NY", country: "USA", gateCode: "12345")
//    static let client = Client(firstName: "hayden", lastName: "davidson", address: address, email: "haydendavidson@me.com", phoneNumber: "8137163618")
//    
//    static var previews: some View {
//        ClientList(clients: client)
//    }
//}
