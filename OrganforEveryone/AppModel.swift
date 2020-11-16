//
//  AppModel.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/11/10.
//

import Foundation
import Combine

class AppModel : ObservableObject{
    @Published var hospitals = [String]()
    @Published var organs = [String]()
    let hospitallUrlString = "http://127.0.0.1:8080/hospitals"
    let organUrlString = "http://127.0.0.1:8080/organs"
    @Published var chosenHospital = 0
    @Published var chosenOrgan = 0
    
    
    let url1 = URL(string: "http://127.0.0.1:8080/hospitals")!
    let url2 = URL(string: "http://127.0.0.1:8080/organs")!
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
   
    allCancellable = Publishers.Zip(publisher1,publisher2)
        .eraseToAnyPublisher()
        .replaceError(with: ([],[]))
//        .catch{ _ in
//            Just(([], []))
//        }
        .sink(receiveValue: {hospitals, organs in
            DispatchQueue.main.async{
                self.hospitals =  hospitals.map{$0.name}
                self.organs = organs.map{$0.name}
                           }
            
        })
    }
    
    
//    init(){
//        retreiveHospitalDataWithCombine()
//        retreiveOrganDataWithCombine()
//    }

//
//        var allCancellable : Cancellable?
//        func retreiveHospitalDataWithCombine(){
//
//            let url = URL(string: hospitallUrlString)!
//            let urlSession = URLSession.shared
//
//            allCancellable = urlSession.dataTaskPublisher(for: url)
//                .tryMap{ data, response -> Data in
//                    guard let httpResponse = response as? HTTPURLResponse,
//                          200..<300 ~= httpResponse.statusCode else{
//                        throw URLError.unknown
//                    }
//                    return data
//                }
//                .decode(type: OrganAppData.self, decoder: JSONDecoder())
//                .map{$0.hospitals}
//                .replaceError(with:[OrganAppData])
//
//                .sink{(entries) in
//                    DispatchQueue.main.async{
//                        self.hospitals =  entries.map{$0.name}
//                }
//                }
//        }
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
