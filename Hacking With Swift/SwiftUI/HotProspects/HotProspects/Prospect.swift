//
//  Prospect.swift
//  HotProspects
//
//  Created by Hayden Davidson on 3/16/21.
//

import Foundation

class Prospect: Identifiable, Codable {
    
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var dateAdded = Date()
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
//    static let saveKey = "SavedData"
    
    init() {
        
       var path: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
        }
        
        let fileName = path.appendingPathComponent("SavedProspects")
        
        if let data = try? Data(contentsOf: fileName) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
        self.people = []
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    private func save() {
        do {
            let fileName = getDocumentsDirectory().appendingPathComponent("SavedProspects")
            let data = try JSONEncoder().encode(people)
            try data.write(to: fileName, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

}
