//
//  ImagePickerView.swift
//  Instafilter
//
//  Created by Hayden Davidson on 3/12/21.
//

import SwiftUI

struct ImagePickerViewTechnique: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            image?
                .resizable().scaledToFit()
            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePickerTechnique(image: self.$inputImage)
        
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
        let imageSaver = ImageSaverTechnique()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}

class ImageSaverTechnique: NSObject {
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerViewTechnique()
    }
}
