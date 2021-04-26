//
//  Crew.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 3/27/21.
//

import Foundation
import RealmSwift


class Crew: EmbeddedObject {
    
    var members = List<CrewMember>()
    
    convenience init(members: [CrewMember]) {
        self.init()
        self.members.append(objectsIn: members)
    }
    
   
}
