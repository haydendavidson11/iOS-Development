////
////  CompareCustomTypes.swift
////  BucketList
////
////  Created by Hayden Davidson on 3/13/21.
////
//
//import SwiftUI
//
//struct CompareCustomTypes: View {
////    Create a sorted list of users
//    
//    let users = [
//            User(firstName: "Arnold", lastName: "Rimmer"),
//            User(firstName: "Kristine", lastName: "Kochanski"),
//            User(firstName: "David", lastName: "Lister"),
//    ].sorted()
//    
//    var body: some View {
//        List(users) { user in
//            Text("\(user.firstName) \(user.lastName)")
//        }
//    }
//}
//
//// User Model for list 
//struct User: Identifiable, Comparable{
//    let id = UUID()
//    let firstName: String
//    let lastName: String
//    
//    
////    Stub to conform to Comparable
//    static func < (lhs: User, rhs: User) -> Bool {
//        lhs.lastName < rhs.lastName
//    }
//    
//    
//}
//
//struct CompareCustomTypes_Previews: PreviewProvider {
//    static var previews: some View {
//        CompareCustomTypes()
//    }
//}
