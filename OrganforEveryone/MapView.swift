//
//  MapView.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/10/19.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var organModel : OrganModel
    @EnvironmentObject var locationManager : LocationManager
    @State var userTrackingMode : MapUserTrackingMode = .follow
    var body: some View {
        Map(coordinateRegion: $locationManager.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: matchedHospital, annotationContent: annotationMarkers)
    }
    
    var matchedHospital: [Hospital]{
        print(organModel.allHospitals)
       return organModel.allHospitals
    }
    func annotationMarkers (item:Hospital) -> some MapAnnotationProtocol {
          MapMarker(coordinate:  CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
      }
    func annotationsForHospital (item:Hospital) -> some MapAnnotationProtocol {
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)) {
                Image(systemName: "flag").renderingMode(.template)
                    .foregroundColor( Color.red)
            }
        }
      
}
//coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
