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

//struct Post: Codable, Identifiable{
//    let id = UUID()
//    var hospital : String
//}
//typealias allHospitals = [Post]
//class API: ObservableObject{
//   //@Published var hospital: [String]
////    init(){
////        guard let url = URL(string: "http://127.0.0.1:8080/hospitals") else {return}
////        URLSession.shared.dataTask(with: url){(data,_,_)in
////            let posts: [String: [String:String]] = try! JSONDecoder().decode([String:[String:String]].self, from: data!)
////            self.hospital = posts.map({ $0.key })
//
//
//    func getPosts(completion: @escaping ([String]) -> ()){
//        guard let url = URL(string: "http://127.0.0.1:8080/hospitals") else {return}
//        URLSession.shared.dataTask(with: url){(data,_,_)in
//            let posts: [String: [String:String]] = try! JSONDecoder().decode([String:[String:String]].self, from: data!)
//            //self.hospital = posts["Albert Einstein Medical Center"]!
//            let keys: [String] = posts.map({ $0.key })
//            DispatchQueue.main.async {
//                completion(keys)
//            }
//
//        }
//        .resume()
//    //}
//    }
//}
