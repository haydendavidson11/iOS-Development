//
//  File.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 3/28/21.
//

import Foundation
import RealmSwift

class Material: EmbeddedObject {
    
    @objc dynamic var type: String?
    @objc dynamic var color: String?
    let quantity = RealmOptional<Double>()
    
    convenience init(type: String, color: String, quantity: Double){
        self.init()
        self.type = type
        self.color = color
        self.quantity.value = quantity
    }
    
}
