//
//  ContentView.swift
//  Instafilter
//
//  Created by Hayden Davidson on 3/12/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State private var showingFilterSheet = false
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var processedImage: UIImage?
    @State private var showingErrorSheet = false
    @State private var filterName = "Sepia Tone"
    let context = CIContext()
    
    var body: some View {
        
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        //        Challenge 3: Custome Binding for radius slider
        let radius = Binding<Double>(
            get: {
                self.filterRadius
            },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
            }
        )
        let scale = Binding<Double>(
            get: {
                self.filterScale
            },
            set: {
                self.filterScale = $0
                self.applyProcessing()
            }
        )
        
        
        return NavigationView{
            VStack{
                // Gray box to place photo over
                ZStack{
                    Rectangle()
                        .fill(Color.secondary)
                    // Display the image
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    //   present ImagePicker Sheet
                    self.showImagePicker = true
                }
                HStack {
                    //   Challenge 3: Conditional Sliders based on what filter is selected for input key
                    if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                        Text("Intensity")
                        Slider(value: intensity)
                    }else if currentFilter.inputKeys.contains(kCIInputScaleKey){
                        Text("Scale")
                        Slider(value: scale)
                    
                    } else {
                        Text("Radius")
                        Slider(value: radius)
                    }
                    
                    
                }.padding(.vertical)
                HStack {
                    //     Challenge 2: Change filter button title to filter name
                    Button(filterName) {
                        //                    Change Filter
                        self.showingFilterSheet = true
                    }
                    Spacer()
                    
                    Button("Save") {
                        //                        Save the picture         Challenge 1: Show error when no image selected
                        guard let processedImage = self.processedImage else { return  showingErrorSheet = true}
                        
                        let imageSaver = ImageSaver()
                        
                        imageSaver.successHandler = {
                            print("Success!")
                        }
                        
                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                            
                            
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
        }.padding([.horizontal, .bottom])
        .navigationBarTitle("Instafilter")
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
        .actionSheet(isPresented: $showingFilterSheet) {
            ActionSheet(title: Text("Select a filter"), buttons:
                            [ .default(Text("Crystallize")){
                                self.setFilter(CIFilter.crystallize())
                                self.filterName = "Crystallize"
                            }, .default(Text("Edges")) {
                                self.setFilter(CIFilter.edges())
                                self.filterName = "Edges"
                            }, .default(Text("Gaussian Blur")) {
                                self.setFilter(CIFilter.gaussianBlur())
                                self.filterName = "Gaussian Blur"
                            }, .default(Text("Pixalate")) {
                                self.setFilter(CIFilter.pixellate())
                                self.filterName = "Pixalate"
                            }, .default(Text("Sepia Tone")) {
                                self.setFilter(CIFilter.sepiaTone())
                                self.filterName = "Sepia Tone"
                            }, .default(Text("Unsharp Mask")) {
                                self.setFilter(CIFilter.unsharpMask())
                                self.filterName = "Unsharp Mask"
                            }, .default(Text("Vignette")) {
                                self.setFilter(CIFilter.vignette())
                                self.filterName = "Vignette"
                            }, .cancel()
                            ])
            
        }
        //        Challenge 1: Show error when no photo is selected
        .alert(isPresented: $showingErrorSheet) {
            Alert(title: Text("No Photo"), message: Text("Please select a photo"), dismissButton: .default(Text("OK")))
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        
        
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey){
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
            
        }
        if inputKeys.contains(kCIInputRadiusKey){
            currentFilter.setValue(filterRadius * 20, forKey: kCIInputRadiusKey)
            
        }
        if inputKeys.contains(kCIInputScaleKey){
            currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)
            
        }
        
        
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
        
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
