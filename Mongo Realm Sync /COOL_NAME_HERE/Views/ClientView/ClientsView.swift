//
//  ClientsView.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 4/7/21.
//

import SwiftUI
import RealmSwift

struct ClientsView: View {
    
    @EnvironmentObject var state: AppState
    @ObservedResults(Client.self) var clients
    
    
    
    
    
    var body: some View {
        
        
        NavigationView{
            ClientList(clients: $clients)
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(clients, id: \.self) { client in
                        CardView(client: client)
                            .padding()
                            
                    }
                }
            }
            .padding()
            
        }
    }
    
//    func getallClients() {
//        let realm = try! Realm()
//        let allClients = realm.objects(Client.self)
//        clients.allClients.append(contentsOf: allClients)
//    }
}

//struct ClientsView_Previews: PreviewProvider {
//    static let address = Address(street: "385 1st ave", city: "New York", zip: "10010", state: "NY", country: "USA", gateCode: "12345")
//    static let client = Client(firstName: "hayden", lastName: "davidson", address: address, email: "haydendavidson@me.com", phoneNumber: "8137163618")
//    
//    static var previews: some View {
//        ClientsView(clients: client)
//    }
//}
