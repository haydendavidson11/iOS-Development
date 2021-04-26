//
//  Address.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 3/28/21.
//

import Foundation
import RealmSwift


class Address: EmbeddedObject {
    
    @objc dynamic var street: String?
    @objc dynamic var city: String?
    @objc dynamic var zip: String?
    @objc dynamic var state: String?
    @objc dynamic var country: String?
    @objc dynamic var gateCode: String?
    
   
    
    convenience init(street: String, city: String, zip: String, state: String, country: String, gateCode: String) {
        self.init()
        self.street = street
        self.city = city
        self.zip = zip
        self.state = state
        self.country = country
        self.gateCode = gateCode
    }
    
    
}


