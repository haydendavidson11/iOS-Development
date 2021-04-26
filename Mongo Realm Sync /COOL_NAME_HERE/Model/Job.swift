//
//  Job.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 3/27/21.
//

import Foundation
import RealmSwift


class Job: EmbeddedObject, ObjectKeyIdentifiable {
    
    @objc dynamic var _id = UUID().uuidString
    @objc dynamic var startTime: Date?
    let estimatedTimeToComplete = RealmOptional<Int>()
    var materials = List<Material>()
    @objc dynamic var assignedCrew: Crew?
    let comments = List<Comment>()
    
    
    convenience init(startTime: Date, estimatedTimeToComplete: Int?, materials: [Material], assignedCrew: Crew, comments: [Comment]) {
        self.init()
        self.startTime = startTime
        self.estimatedTimeToComplete.value = estimatedTimeToComplete
        self.assignedCrew = assignedCrew
        self.comments.append(objectsIn: comments)
        self.materials.append(objectsIn: materials)
    }
    
    
    
}
