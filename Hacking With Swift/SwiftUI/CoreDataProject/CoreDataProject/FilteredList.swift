//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Hayden Davidson on 3/11/21.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @State var lastNameFilter = "A"
    @Environment(\.managedObjectContext) var moc
    
    var fetchRequest: FetchRequest<T>
    var sortDescriptors: [NSSortDescriptor]
    
   var singers: FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    
    let content: (T) -> Content
    
    
    
    var body: some View {
        
        VStack {
            List(fetchRequest.wrappedValue, id: \.self) { singer in
                self.content(singer)
            }
            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? self.moc.save()
            }
            Button("Show A") {
               lastNameFilter = "A"
            }
                                
            Button("Show S") {
               lastNameFilter = "S"
                
            }
            
        }
    }
    
    init(filterKey: String, filterValue: String, sortDescriptors: [NSSortDescriptor],  predicate: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicate) %@", filterKey, filterValue))
        self.content = content
        self.sortDescriptors = sortDescriptors
        
        
    }
}

enum Predicates: String {
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS"
    case beginsWithIgnoreCase = "BEGINSWITH[c]"
    case containsIgnoreCase = "CONTAINS[c]"
}


//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList()
//    }
//}
