//
//  AppModel.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/11/10.
//

import Foundation
import Combine
import CoreLocation
import MapKit

struct MatchedHospital: Identifiable{
    var id = UUID()
    var latitude : Double
    var longitude : Double
    var name : String
}
class AppModel : ObservableObject{
    static let span : CLLocationDegrees = 2.5
    @Published var hospitals = [OrganAppData.Hospital]()
    @Published var organs = [OrganData.Organ]()
    @Published var patients = [PatientData.Patient]()
    @Published var matching =  [MatchingData.Matching]()
    @Published var chosenHospital : OrganAppData.Hospital = OrganAppData.Hospital(name:"",address:"")
    @Published var chosenOrgan : OrganData.Organ = OrganData.Organ(name: "")
    @Published var chosenPatient : PatientData.Patient = PatientData.Patient(name: "", age: "", blood_group: "", sex: "", weight: "")
    @Published var donorHospitalName = ""
    @Published var region : MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.2637095, longitude: -76.6748222), span:MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span))
    @Published var route : MKRoute?
    @Published var eta : TimeInterval?
    //@Published var donorHospitalName : String = ""
    //@Published var recipientHospitalName : String = ""
    
    private var storein = Set<AnyCancellable>()
    
    
      let url1 = URL(string: "http://127.0.0.1:8080/hospitals")!
      let url2 = URL(string: "http://127.0.0.1:8080/organs")!
      let url3 = URL(string: "http://127.0.0.1:8080/patients")!
    enum URLError : Error{
        case unknown
    }
    var allCancellable : Cancellable?
   
    
    init(){
        let publisher1 = URLSession.shared.dataTaskPublisher(for: url1)
            .tryMap{ data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else{
                    throw URLError.unknown
                }
                return data
            }
            .decode(type: OrganAppData.self, decoder: JSONDecoder())
            .map{$0.hospitals}

        let publisher2 = URLSession.shared.dataTaskPublisher(for: url2)
            .tryMap{ data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else{
                    throw URLError.unknown
                }
                return data
            }
            .decode(type: OrganData.self, decoder: JSONDecoder())
            .map{$0.organs}

        let publisher3  = URLSession.shared.dataTaskPublisher(for: url3)
            .tryMap{ data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else{
                    throw URLError.unknown
                }
                return data
            }
            .decode(type: PatientData.self, decoder: JSONDecoder())
            .map{$0.patients}

    allCancellable = Publishers.Zip3(publisher1,publisher2,publisher3)
                                            .eraseToAnyPublisher()
                                            .replaceError(with: ([],[],[]))
                                            .sink(receiveValue: {hospitals, organs, patients in
                                                DispatchQueue.main.async{
                                                    self.hospitals =  hospitals.map{$0}
                                                    self.organs = organs.map{$0}
                                                    self.patients = patients.map{$0}
                                                }

                                            })
    }
    var cancellable : Cancellable?
    
    
    func retreiveMatching(){
        let urlPatient = chosenPatient.name.replacingOccurrences(of: " ", with: "")
        let url4 = URL(string: "http://127.0.0.1:8080/matching/\(urlPatient)/\(chosenOrgan.name)")!
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url4)
            .tryMap{ data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else{
                    throw URLError.unknown
                }
                return data
            }
            .decode(type: MatchingData.self, decoder: JSONDecoder())
            .map{$0.matching}
            .replaceError(with: [])
         
            .sink(receiveValue: {matching in
                DispatchQueue.main.async {
                    self.matching = matching.map{$0}
                }
            })
    }
    
    func retrieveMatchedHospitals() -> [MatchedHospital]{
        
        let donorCoordsArray = matching[0].donorCoords.components(separatedBy: ",")
        let receipientCoordArray = matching[0].recipientCoords.components(separatedBy: ",")
        var donorCoordCL2D : CLLocationCoordinate2D = CLLocationCoordinate2D()
        donorCoordCL2D.latitude = Double(donorCoordsArray[1])!
        donorCoordCL2D.longitude = Double(donorCoordsArray[0])!
        var recipientCoordCL2D : CLLocationCoordinate2D = CLLocationCoordinate2D()
        recipientCoordCL2D.latitude = Double(receipientCoordArray[1])!
        recipientCoordCL2D.longitude = Double(receipientCoordArray[0])!
        let donorCoordCL : CLLocation = CLLocation(latitude: donorCoordCL2D.latitude, longitude: donorCoordCL2D.longitude)
        let recipientCoordCL : CLLocation = CLLocation(latitude: recipientCoordCL2D.latitude, longitude: recipientCoordCL2D.longitude)
        let donorHospitalName = getName(coordCL: donorCoordCL)
        let recipientHospitalName = getName(coordCL: recipientCoordCL)
        var donorHospital = MatchedHospital(latitude: donorCoordCL2D.latitude, longitude: donorCoordCL2D.longitude, name: donorHospitalName)
        var recipientHospital = MatchedHospital(latitude: recipientCoordCL2D.latitude, longitude: recipientCoordCL2D.longitude, name: recipientHospitalName)
        print(donorHospital.name)
        return [donorHospital, recipientHospital]
    }
    
//    func retreiveName(){
//        let donorCoordsArray = self.matching[0].donorCoords.components(separatedBy: ",")
//        var donorCoordCL2D : CLLocationCoordinate2D = CLLocationCoordinate2D()
//        donorCoordCL2D.latitude = Double(donorCoordsArray[1])!
//        donorCoordCL2D.longitude = Double(donorCoordsArray[0])!
//        let donorCoordCL : CLLocation = CLLocation(latitude: donorCoordCL2D.latitude, longitude: donorCoordCL2D.longitude)
//        donorHospitalName = getName(coordCL: donorCoordCL)
//
//        print("donor\(donorHospitalName)")
//        //return donorHospitalName
//    }
//
    func getName(coordCL : CLLocation) -> String{
        let geoCoder = CLGeocoder.init()
        var name = ""
        geoCoder.reverseGeocodeLocation(coordCL,completionHandler: {
            (placemarks, error) in
            if error == nil{
                 name  = (placemarks?[0].name!)!
                 //print(name)
                
                //completionHandler((donorHospiatlName))
            }else{
                print(error?.localizedDescription)
            }
        }
       )
        return name
    }
    
    func findRegion(){
        let twoHospitals = self.retrieveMatchedHospitals()
        //calculate center
        let centerLat = (twoHospitals[0].latitude + twoHospitals[1].latitude)/2
        let centerLong = (twoHospitals[0].longitude + twoHospitals[1].longitude)/2
        //calculate deltas
        let deltaLat = fabs(twoHospitals[0].latitude - twoHospitals[1].latitude)
        let deltaLong = fabs(twoHospitals[0].longitude - twoHospitals[1].longitude)
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: centerLat, longitude: centerLong), span:MKCoordinateSpan(latitudeDelta: deltaLat + 0.1, longitudeDelta: deltaLong + 0.1))
        //return region
    }
    func provideDirections(){
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark.init(coordinate: CLLocationCoordinate2D(latitude: self.retrieveMatchedHospitals()[0].latitude, longitude: self.retrieveMatchedHospitals()[0].longitude)))
        request.destination = MKMapItem(placemark: MKPlacemark.init(coordinate:  CLLocationCoordinate2D(latitude: self.retrieveMatchedHospitals()[1].latitude, longitude: self.retrieveMatchedHospitals()[1].longitude)))
        request.transportType = .automobile
        request.requestsAlternateRoutes = true
        let directions = MKDirections(request: request)
        directions.calculate{(response, error)in
            guard(error == nil) else {print(error!.localizedDescription); return}
            
            if let route = response?.routes.first{
                self.route = route
                self.eta = route.expectedTravelTime
            }
        }
    }
    
}


