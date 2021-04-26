//
//  CrewMemeber.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 3/27/21.
//

import Foundation
import RealmSwift


class CrewMember: EmbeddedObject {
    
    
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?
    let experience = RealmOptional<Int>()
    @objc dynamic var role: String?
    @objc dynamic var timeSheet: TimeSheet?
    @objc dynamic var phoneNumber: String?
    @objc dynamic var address: Address?
    
    convenience init(firstName: String, lastName: String, experience: Int?, role: String?, timeSheet: TimeSheet?, phoneNumber: String, address: Address) {
        self.init()
        self.firstName = firstName
        self.lastName = lastName
        self.experience.value = experience
        self.role = role
        self.timeSheet = timeSheet
        self.phoneNumber = phoneNumber
        self.address = address
    }
    
}
