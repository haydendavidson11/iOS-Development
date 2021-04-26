//
//  MapView.swift
//  BucketList
//
//  Created by Hayden Davidson on 3/13/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    
    var annotations: [MKPointAnnotation]
    
    
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        if annotations.count != view.annotations.count {
            view.removeAnnotations(view.annotations)
            view.addAnnotations(annotations)
            
        }
    }
    
    
   
    //MARK: - Corrdinator class
    func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
                self.parent = parent
            }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            this is our unique identifier for view reuse
            let identifier = "Placemark"
//            attempt to find a cell we can recycle
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
//                 we didnt find one; make a new one
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
//                 allow this to show pop up information
                annotationView?.canShowCallout = true
                
//                 attatch an information button to the view
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
//                we have a view to reuse, so give it the new annotation
                
                annotationView?.annotation = annotation
            }
//            wheather it's a new view or a recycled one, send it bcak
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let placeMark = view.annotation as? MKPointAnnotation else { return }
            parent.selectedPlace = placeMark
            parent.showingPlaceDetails = true
            print(parent.showingPlaceDetails)
        }
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate), selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails: .constant(false), annotations: [MKPointAnnotation.example])
    }
}

// Example data for MKPointAnnotation in the preview
extension MKPointAnnotation {
    static var example: MKPointAnnotation {
    let annotation = MKPointAnnotation()
    
    annotation.title = "London"
    annotation.subtitle = "Capitol of England"
    annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
    return annotation
    }
    
}
