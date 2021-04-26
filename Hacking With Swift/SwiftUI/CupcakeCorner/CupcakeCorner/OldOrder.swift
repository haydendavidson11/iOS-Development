////
////  Order.swift
////  CupcakeCorner
////
////  Created by Hayden Davidson on 2/23/21.
////
//
//import Foundation
//
//class Order: ObservableObject, Codable {
//    
//    init() {}
//    
//    static let types = ["Vanilla", "Stawberry", "Chocolate", "Rainbow"]
//    
//    @Published var type = 0
//    @Published var quantity = 3
//    
//    @Published var specialRequestEnabled = false {
//        didSet{
//            if specialRequestEnabled == false{
//                extraFrosting = false
//                addSpinkles = false
//            }
//        }
//    }
//    @Published var extraFrosting = false
//    @Published var addSpinkles = false
//
//    
//    @Published var name = ""
//    @Published var streetAddress = ""
//    @Published var city = ""
//    @Published var zip = ""
//    
//    
//    var hasValidAddress: Bool {
//        if name.trimmingCharacters(in: .whitespaces) == "" || streetAddress.trimmingCharacters(in: .whitespaces) == "" || city.trimmingCharacters(in: .whitespaces) == "" || zip.trimmingCharacters(in: .whitespaces) == "" {
//            return false
//        }
//        return true
//    }
//    
//    var cost: Double {
//        var cost = Double(quantity) * 2
//        
//        cost += (Double(type) / 2)
//        
//        
//        if extraFrosting {
//            cost += Double(quantity)
//        }
//        
//        if addSpinkles {
//            cost += Double(quantity) / 2
//        }
//        return cost
//    }
//    
//    //MARK: - Conform to Codable
//    enum CodingKeys: CodingKey {
//        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(type, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(addSpinkles, forKey: .addSprinkles)
//        try container.encode(name, forKey: .name)
//        try container.encode(streetAddress, forKey: .streetAddress)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        type = try container.decode(Int.self, forKey: .type)
//        quantity = try container.decode(Int.self, forKey: .quantity)
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSpinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//        name = try container.decode(String.self, forKey: .name)
//        streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
//    }
//    
//}
