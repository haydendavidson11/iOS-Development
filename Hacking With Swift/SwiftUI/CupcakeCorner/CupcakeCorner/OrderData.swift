//
//  OrderData.swift
//  CupcakeCorner
//
//  Created by Hayden Davidson on 3/2/21.
//

import Foundation


struct OrderData: Codable {
    
    
    static let types = ["Vanilla", "Stawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces) == "" || streetAddress.trimmingCharacters(in: .whitespaces) == "" || city.trimmingCharacters(in: .whitespaces) == "" || zip.trimmingCharacters(in: .whitespaces) == "" {
            return false
        }
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        
        cost += (Double(type) / 2)
        
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }
    
}
