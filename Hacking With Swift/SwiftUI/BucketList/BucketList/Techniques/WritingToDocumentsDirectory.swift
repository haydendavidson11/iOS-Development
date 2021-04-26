////
////  WritingToDocumentsDirectory.swift
////  BucketList
////
////  Created by Hayden Davidson on 3/13/21.
////
//
//import SwiftUI
//
//struct WritingToDocumentsDirectory: View {
//    var body: some View {
//        VStack {
//            Text("Hello, World!")
//                .onTapGesture {
//                    let str = "Test Message"
//                    let url = self.getDocumantsDirectory().appendingPathComponent("message.txt")
//                    do {
//                        try str.write(to: url, atomically: true, encoding: .utf8)
//                        let input = try String(contentsOf: url)
//                        print(input)
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//            }
//            Button("Test"){
//                print("Test")
//            }
//        }
//        
//    }
//    
////    Method to get the current directory
//    func getDocumantsDirectory() -> URL {
////        find all possible directories for this user
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
////        send back the first one which should be the only one
//        return paths[0]
//    }
//}
//
//struct WritingToDocumentsDirectory_Previews: PreviewProvider {
//    static var previews: some View {
//        WritingToDocumentsDirectory()
//    }
//}
