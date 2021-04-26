//
//  MeView.swift
//  HotProspects
//
//  Created by Hayden Davidson on 3/16/21.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @State private var name = "Anonymous"
    @State private var emailAdress = "haydendavidson@me.com"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                    .padding(.horizontal)
                TextField("Email", text: $emailAdress)
                    .textContentType(.emailAddress)
                    .font(.title)
                    .padding([.horizontal, .bottom])
                Image(uiImage: generateQRCode(from: "\(name)\n\(emailAdress)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Spacer()
            }
            .navigationTitle("Your Code")
        }
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
