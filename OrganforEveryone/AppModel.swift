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
    let hospitallUrlString = "http://127.0.0.1:8080/hospitals"
    let organUrlString = "http://127.0.0.1:8080/organs"
    @Published var chosenHospital = 0
    
    init(){
        retreiveDataWithCombine()
    }
    enum URLError : Error{
        case unknown
    }
    
    var allCancellable : Cancellable?
    func retreiveDataWithCombine(){
        let group = DispatchGroup()
    
        let url = URL(string: hospitallUrlString)!
        let urlSession = URLSession.shared
        
        allCancellable = urlSession.dataTaskPublisher(for: url)
            .tryMap{ data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else{
                    throw URLError.unknown
                }
                return data
            }
            .decode(type: OrganAppData.self, decoder: JSONDecoder())
            .map{$0.hospitals}
            .replaceError(with:[])
            
            .sink{(entries) in
                DispatchQueue.main.async{
                    self.hospitals =  entries.map{$0.name}
            }
            }
    
}
}
