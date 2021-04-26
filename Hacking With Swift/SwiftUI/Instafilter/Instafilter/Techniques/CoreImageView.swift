//
//  CoreImageView.swift
//  Instafilter
//
//  Created by Hayden Davidson on 3/12/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct CoreImageView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack{
            image?
                .resizable()
                .scaledToFit()
          }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        
        //        Load and create a UIImage from our asset catelog
        guard let inputImage = UIImage(named: "Example") else { return }
        
        //        convert the UIImage to a CIImage
        let beginImage = CIImage(image: inputImage)
        
        //        Create Core Image Context
        let context = CIContext()
        
        //        Create the filter
        let currentFilter = CIFilter.sepiaTone()
        
        
        //        set the current filter's image and intensity
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1
        
        
        //        get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }
        
        //        attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            
            //            convert that image to a UIImage
            let uiImage = UIImage(cgImage: cgimg)
            
            //             and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
    }
}

struct CoreImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoreImageView()
    }
}
