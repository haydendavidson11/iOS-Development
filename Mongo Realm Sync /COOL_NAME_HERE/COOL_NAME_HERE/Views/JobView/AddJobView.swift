//
//  AddJobView.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 3/30/21.
//

import SwiftUI
import RealmSwift

struct AddJobView: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var publicRealm
    @Environment(\.presentationMode) var presentationMode
    
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
    
    
    @State private var addNewClient = false
    @State private var selectedClient = 0
    
    
    
    var addButtonDisabled: Bool {
        if firstName.isEmpty || lastName.isEmpty || email.isEmpty || phone.isEmpty || street.isEmpty || city.isEmpty || zip.isEmpty || residentState.isEmpty || country.isEmpty || gateCode.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    var selectedClientName: String {
        var clientName: String
        if clients.count > 0 {
            clientName = "\(clients[selectedClient].firstName) \(clients[selectedClient].lastName)"
        }else{
            clientName = "please add client"
            print("No clients")
        }
        return clientName
    }
    
    var body: some View {
        
        VStack {
            Toggle("Add new client", isOn: $addNewClient)
        Form {
            if addNewClient || clients.isEmpty {
                Group {
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
                }
            } else {
                Section(header: Text("Client")) {
                    Picker(selectedClientName, selection: $selectedClient) {
                        List {
                            ForEach(0..<clients.count) {
                                Text("\(clients[$0].firstName) \(clients[$0].lastName)")
                            }
                        }
                    }
                }
                
            }
            
            Button("Add") {
                
                
                if addNewClient {
                    addNewClientWithJob()
                }else {
                   
                    addJobToSelctedClient(selectedClient: selectedClient)
                    
                }
            }
        }
            .navigationTitle("Add Job")
            .alert(isPresented: $showingAddAlert, content: {
                Alert(title: Text(addAlertTitle), message: Text(addAlertMessage), dismissButton: .default(Text("OK"), action: {
                    presentationMode.wrappedValue.dismiss()
                }))
                
                
            })
        }
    }
    
    func addNewClientWithJob() {
        let newAddress = Address()
        newAddress.street = street
        newAddress.city = city
        newAddress.zip = zip
        newAddress.state = residentState
        newAddress.country = country
        newAddress.gateCode = gateCode
        
        
        let newClient = Client(firstName: firstName, lastName: lastName, address: newAddress, email: email, phoneNumber: phone)
        newClient.jobs.append(Job())
        
        state.shouldIndicateActivity = true
        do {
            try publicRealm.write {
                $clients.append(newClient)
                addAlertTitle = "Success"
                addAlertMessage = "New job for \(newClient.firstName) \(newClient.lastName)"
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
            state.shouldIndicateActivity = false
            addAlertTitle = "Sorry"
            addAlertMessage = "Failed to add job for \(clients[selectedClient].firstName) \(clients[selectedClient].lastName)"
            return
        }
        state.shouldIndicateActivity = false
        showingAddAlert = true
        
    }
    
    func addJobToSelctedClient(selectedClient: Int) {
        state.shouldIndicateActivity = true
        let newJob = Job()
        if let client = clients.first(where: {$0._id == clients[selectedClient]._id}) {
                print(client.firstName)
            client.jobs.append(newJob)
        
//                do {
//                    try publicRealm.write {
//                        client.jobs.append(newJob)
                        addAlertTitle = "Success"
                        addAlertMessage = "New job for \(clients[selectedClient].firstName) \(clients[selectedClient].lastName)"
//                    }
//                } catch {
//                    state.error = "Unable to open Realm write transaction"
//                    state.shouldIndicateActivity = false
//                    addAlertTitle = "Sorry"
//                    addAlertMessage = "Failed to add job for \(clients[selectedClient].firstName) \(clients[selectedClient].lastName)"
//                    return
//                }
                state.shouldIndicateActivity = false
                showingAddAlert = true
            }
     }
}

//struct AddJobView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddJobView()
//    }
//}
