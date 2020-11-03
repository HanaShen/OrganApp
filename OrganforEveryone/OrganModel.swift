//
//  OrganModel.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/10/19.
//

import Foundation
import MapKit

struct Hospital: Codable, Identifiable, Equatable, Hashable{
    var id = UUID()
    let name : String
    let address: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    
    enum CodingKeys: String, CodingKey{
        case name
        case address
        case latitude
        case longitude
    }
    
}
typealias AllHospitals = [Hospital]

class OrganModel: ObservableObject{
    @Published var allHospitals : AllHospitals
    
    let destinationURl : URL
    init(){
        let filename = "hospitals"
        let mainBundle = Bundle.main
        let bundleURL = mainBundle.url(forResource: filename, withExtension: "json")!
        
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        destinationURl = documentURL.appendingPathComponent(filename + ".json")
        let fileExists = fileManager.fileExists(atPath: destinationURl.path)
        
        do{
            let url = fileExists ? destinationURl : bundleURL
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            allHospitals = try decoder.decode(AllHospitals.self, from: data)
        }catch{
           print("Error info: \(error)")
           allHospitals = []
        }
    }
    @Published var chosenHospital = 0
}
