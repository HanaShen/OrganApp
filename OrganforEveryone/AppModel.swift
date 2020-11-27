//
//  AppModel.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/11/10.
//

import Foundation
import Combine

class AppModel : ObservableObject{
    @Published var hospitals = [OrganAppData.Hospital]()
    @Published var organs = [OrganData.Organ]()
    @Published var patients = [PatientData.Patient]()
    @Published var matching =  [MatchingData.Matching]()
    @Published var chosenHospital : OrganAppData.Hospital = OrganAppData.Hospital(name:"",address:"")
    @Published var chosenOrgan : OrganData.Organ = OrganData.Organ(name: "")
    @Published var chosenPatient : PatientData.Patient = PatientData.Patient(name: "", age: "", blood_group: "", sex: "", weight: "")
    
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
        
//        let urlPatient = chosenPatient.name.replacingOccurrences(of: " ", with: "")
//        print("patient \(urlPatient)")
//        let url4 = URL(string: "http://127.0.0.1:8080/matching/\(urlPatient)/\(chosenOrgan.name)")!
        //let decoder = JSONDecoder()
        //decoder.keyDecodingStrategy = .convertFromSnakeCase
//        let publisher4 = URLSession.shared.dataTaskPublisher(for: url4)
//            .tryMap{ data, response -> Data in
//                guard let httpResponse = response as? HTTPURLResponse,
//                      200..<300 ~= httpResponse.statusCode else{
//                    throw URLError.unknown
//                }
//                return data
//            }
//            .decode(type: MatchingData.self, decoder: JSONDecoder())
//            .map{$0.matching}
        
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
           // .receive(on: RunLoop.main)
            
            .sink(receiveValue: {matching in
                DispatchQueue.main.async {
                    self.matching = matching.map{$0}
                    print(matching[0])
                }
            })
        //.store(in: &storein)
    }

    

//
//
//            var allCancellable : Cancellable?
//            func retreiveHospitalDataWithCombine(){
//
//               // let url = url1
//                let urlSession = URLSession.shared
//
//                allCancellable = urlSession.dataTaskPublisher(for: url1)
//                    .tryMap{ data, response -> Data in
//                        guard let httpResponse = response as? HTTPURLResponse,
//                              200..<300 ~= httpResponse.statusCode else{
//                            throw URLError.unknown
//                        }
//                        return data
//                    }
//                    .decode(type: OrganAppData.self, decoder: JSONDecoder())
//                    .map{$0.hospitals}
//                    .replaceError(with:[])
//
//                    .sink{(entries) in
//                        DispatchQueue.main.async{
//                            self.hospitals =  entries.map{$0}
//                    }
//                    }
        //    }
    //    func retreiveOrganDataWithCombine(){
    //
    //        let url = URL(string: organUrlString)!
    //        let urlSession = URLSession.shared
    //
    //        allCancellable = urlSession.dataTaskPublisher(for: url)
    //            .tryMap{ data, response -> Data in
    //                guard let httpResponse = response as? HTTPURLResponse,
    //                      200..<300 ~= httpResponse.statusCode else{
    //                    throw URLError.unknown
    //                }
    //                return data
    //            }
    //            .decode(type: OrganData.self, decoder: JSONDecoder())
    //            .map{$0.organs}
    //            .replaceError(with:[])
    //
    //            .sink{(entries) in
    //                DispatchQueue.main.async{
    //                    self.organs =  entries.map{$0.name}
    //            }
    //            }
    //
    //    }
}

//    let subscribers = Just(endpoints)
//        .setFailureType(to: Error.self)
//        .flatMap{(values)  -> Publishers.MergeMany<AnyPublisher<String, Error>> in
//            let tasks = values.map{(userId) -> AnyPublisher<String, Error> in
//                let requestURL = URL(string: "http://127.0.0.1:8080/\(userId)")!
//
//                return URLSession.shared.dataTaskPublisher(for: requestURL)
//                            .map { $0.data }
//                            .decode(type: OrganAppData..self, decoder: JSONDecoder())
//                            .eraseToAnyPublisher()
//            }
//            return Publishers.MergeMany(tasks)
//init(){
//retreiveDataWithCombine()
// }

//    func getAllData(for type: String) -> AnyPublisher<[String], Error> {
//        getIDs(for: type).flatMap { ids in
//            Publishers.Sequence(sequence: ids.map { self.getData(with: $0) })
//                .flatMap { $0 }
//                .collect()
//        }.eraseToAnyPublisher()
//    }

//    var allCancellable : Cancellable?
//    func retreiveDataWithCombine(){
//        //let urlSession = URLSession.shared
//        let group = DispatchGroup()
//        let subsicriber = Just(["hospitals", "organs"])
//            .setFailureType(to: Error.self)
//            .flatMap{(values) -> Publishers.MergeMany<AnyPublisher<String,Error>> in
//                let tasks = values.map{(endpoint) -> AnyPublisher<String,Error> in
//                    let requestURL = URL(string:"http://127.0.0.1:8080/\(endpoint)")!
//                    return URLSession.shared.dataTaskPublisher(for: requestURL)
//                        .map{$0.data}
//                        .decode(type: String.self, decoder: JSONDecoder())
//                        .eraseToAnyPublisher()
//                }
//                return Publishers.MergeMany(tasks)
//            }
//        let urls = [
//            URL(string: hospitallUrlString),
//            URL(string: organUrlString),
//        ]
//
//
//        for url in urls{
//            group.enter()
//            allCancellable = urlSession.dataTaskPublisher(for: url!)
//                .tryMap{ data, response -> Data in
//                    guard let httpResponse = response as? HTTPURLResponse,
//                          200..<300 ~= httpResponse.statusCode else{
//                        throw URLError.unknown
//                    }
//                    return data
//                }
//                .decode(type: OrganAppData.self, decoder: JSONDecoder())
//                .map{$0.hospitals}
//                .replaceError(with:[])
//
//                .sink{(entries) in
//                    DispatchQueue.main.async{
//                        self.hospitals =  entries.map{$0.name}
//                }
//
//            }
//        }

//        allCancellable = urlSession.dataTaskPublisher(for: url)
//            .tryMap{ data, response -> Data in
//                guard let httpResponse = response as? HTTPURLResponse,
//                      200..<300 ~= httpResponse.statusCode else{
//                    throw URLError.unknown
//                }
//                return data
//            }
//            .decode(type: OrganAppData.self, decoder: JSONDecoder())
//            .map{$0.hospitals}
//            .replaceError(with:[])
//
//            .sink{(entries) in
//                DispatchQueue.main.async{
//                    self.hospitals =  entries.map{$0.name}
//            }
// }



//}
