//
//  Comment.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 3/28/21.
//

import Foundation
import RealmSwift


class Comment: EmbeddedObject {
    

    let id = UUID().uuidString
   @objc dynamic var message: String?
   @objc dynamic var user: String?
   @objc dynamic var postDate: String?
    
    convenience init(message: String, user: String, postDate: String) {
        self.init()
        self.message = message
        self.user = user
        self.postDate = postDate
    }
    
    
    
    
    
}
