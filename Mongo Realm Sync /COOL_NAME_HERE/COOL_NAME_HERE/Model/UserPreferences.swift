//
//  UserPreferences.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 4/12/21.
//

import RealmSwift

@objcMembers class UserPreferences: EmbeddedObject, ObjectKeyIdentifiable {
    dynamic var displayName: String?
    dynamic var avatarImage: Photo?

    var isEmpty: Bool { displayName == nil || displayName == "" }
}
