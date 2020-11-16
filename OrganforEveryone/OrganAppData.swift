//
//  OrganAppData.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/11/10.
//

import Foundation

struct OrganAppData : Decodable{
    let hospitals : [Hospital]
//    let organs : [Organ]
//    private enum CodingKeys: String,CodingKey{
//        case organs
//    }
    private enum CodingKeys: String, CodingKey{
        case hospitals
    }
    struct Hospital: Decodable{
        let name : String
        let address: String
        
        private enum CodingKeys: String, CodingKey{
            case name
            case address
        }
    }
}
