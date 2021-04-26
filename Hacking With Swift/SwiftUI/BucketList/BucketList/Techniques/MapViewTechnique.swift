////
////  MapViewTechnique.swift
////  BucketList
////
////  Created by Hayden Davidson on 3/13/21.
////
//
//import SwiftUI
//import MapKit
//
//struct MapViewTechnique: UIViewRepresentable {
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: MapViewTechnique
//        
//        init(_ parent: MapViewTechnique) {
//            self.parent = parent
//        }
//        
//        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//            print(mapView.centerCoordinate)
//        }
//        
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
//            view.canShowCallout = true
//            return view
//        }
//    }
//    
//    func makeUIView(context: Context) -> MKMapView {
//        
//        let mapview = MKMapView()
//        mapview.delegate = context.coordinator
//        
//        let annotation = MKPointAnnotation()
//        annotation.title = "London"
//        annotation.subtitle = "Capitol of England"
//        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13)
//        mapview.addAnnotation(annotation)
//        
//        return mapview
//    }
//    
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        
//    }
//    
//    
//}
//
//struct MapViewTechnique_Previews: PreviewProvider {
//    static var previews: some View {
//        MapViewTechnique()
//    }
//}
