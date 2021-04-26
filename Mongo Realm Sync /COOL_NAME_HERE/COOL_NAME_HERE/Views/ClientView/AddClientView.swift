//
//  AddJobView.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 3/30/21.
//

import SwiftUI
import RealmSwift

struct AddClientView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var state: AppState
    @ObservedResults(Client.self) var clients
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var street = ""
    @State private var city = ""
    @State private var zip = ""
    @State private var residentState = ""
    @State private var country = ""
    @State private var gateCode = ""
    
    @State private var showingAddAlert = false
    @State private var addAlertMessage = ""
    @State private var addAlertTitle = ""
    
    
    
    
    var addButtonDisabled: Bool {
        if firstName.isEmpty || lastName.isEmpty || email.isEmpty || phone.isEmpty || street.isEmpty || city.isEmpty || zip.isEmpty || residentState.isEmpty || country.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        
        Form {
            Section(header: Text("Client")) {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                TextField("Phone", text: $phone)
            }
            Section(header: Text("Address")) {
                TextField("Street", text: $street)
                TextField("City", text: $city)
                TextField("State", text: $residentState)
                TextField("Zip", text: $zip)
                TextField("Country", text: $country)
                TextField("GateCode?", text: $gateCode)
            }
            Button("Add") {

                    
                    let address = Address()
                    address.street = street
                    address.city = city
                    address.state = residentState
                    address.zip = zip
                    address.country = country
                    address.gateCode = gateCode
                    
                    let newClient = Client()
                    newClient.firstName = firstName
                    newClient.lastName = lastName
                    newClient.address = address
                    newClient.email = email
                    newClient.phoneNumber = phone
                    
                    $clients.append(newClient)
                    print($clients)

                    addAlertTitle = "Success"
                    addAlertMessage = "New client added!"
                    showingAddAlert = true
                
                
                
                
            }
            .disabled(addButtonDisabled)
            
        }
    .navigationTitle("Add Client")
        .alert(isPresented: $showingAddAlert, content: {
            Alert(title: Text(addAlertTitle), message: Text(addAlertMessage), dismissButton: .default(Text("OK"), action: {
                presentationMode.wrappedValue.dismiss()
            }))
                
            
        })
    }
}

//struct AddClientView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddClientView(clients: Client.example)
//    }
//}

