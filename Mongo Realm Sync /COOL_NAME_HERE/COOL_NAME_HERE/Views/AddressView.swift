//
//  AddressView.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 3/28/21.
//

import SwiftUI
import RealmSwift

struct AddressView: View {
    
    let address: Address
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: "location.circle")
                VStack(alignment: .leading) {
                    Text(address.street ?? "")
                    Text("\(address.city ?? ""), \(address.state ?? "") \(address.zip ?? "")")
                    Text(address.country ?? "")
                    
                }
            }
            if address.gateCode != "" {
                HStack(alignment: .top) {
                    Image(systemName: "lock")
                    Text(address.gateCode ?? "No Gate Code")
                }
                .padding(.top)
            }
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(address: Address(street: "385 1st ave", city: "New York", zip: "10010", state: "NY", country: "USA", gateCode: "12345"))
    }
}
