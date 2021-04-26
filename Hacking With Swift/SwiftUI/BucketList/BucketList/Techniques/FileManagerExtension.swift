////
////  FileManagerExtension.swift
////  BucketList
////
////  Created by Hayden Davidson on 3/13/21.
////
//
//import Foundation
//
//extension FileManager {
//    
//    func decode<T: Codable>(_ file: String) -> T {
//        
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let url = paths[0]
//        guard let data = try? Data(contentsOf: url) else {
//            fatalError("failed to load \(file) from Directory")
//        }
//        let decoder = JSONDecoder()
//        
//        guard let loaded = try? decoder.decode(T.self, from: data) else{
//            fatalError("failed to decode \(file) from Directory")
//        }
//        return loaded
//    }
//}
//
