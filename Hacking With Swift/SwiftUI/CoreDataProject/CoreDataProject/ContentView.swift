//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Hayden Davidson on 3/9/21.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State var lastNameFilter = ""
    
    
    
    
    var body: some View {
        NavigationView{
            List{
                NavigationLink("Candy View", destination: CandyView())
                NavigationLink("FilterList", destination: FilteredList(filterKey: "lastName", filterValue: lastNameFilter, sortDescriptors: [], predicate: "BEGINSWITH") { (singer: Singer) in
                    VStack {
                        Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                        
                    }
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
