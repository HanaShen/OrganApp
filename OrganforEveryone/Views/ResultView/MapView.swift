//
//  MapView.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/10/19.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var appModel : AppModel
   // @EnvironmentObject var locationManager : LocationManager
    @State var userTrackingMode : MapUserTrackingMode = .follow
    var body: some View {
        Map(coordinateRegion: $appModel.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: matchedHospital, annotationContent: annotationMarkers)
            .onAppear(){
                appModel.findRegion()
                appModel.provideDirections()
                //appModel.retrieveMatchedHospitals()
            }
    }
    
    var matchedHospital: [MatchedHospital]{
        return  appModel.retrieveMatchedHospitals()
    }
        func annotationMarkers (item:MatchedHospital) -> some MapAnnotationProtocol {
            MapMarker(coordinate:  CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
        }
    
    func annotationsForHospital (item:MatchedHospital) -> some MapAnnotationProtocol {
        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)) {
//            Text(item.name)
//                .foregroundColor(.white)
//                .background(RoundedRectangle(cornerRadius:20).fill(Color.black.opacity(0.6)))
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
