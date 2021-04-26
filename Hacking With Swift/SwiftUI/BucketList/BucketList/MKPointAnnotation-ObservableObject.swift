//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Hayden Davidson on 3/14/21.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get{
            self.title ?? ""
        } set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get{
            self.subtitle ?? ""
        } set {
            subtitle = newValue
        }
    }
    
}
