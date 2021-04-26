//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Hayden Davidson on 3/12/21.
//

import UIKit

class ImageSaver: NSObject {
    
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didfinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//        SaveComplete
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}


