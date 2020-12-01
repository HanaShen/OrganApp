//
//  OrganData.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/11/12.
//

import Foundation
struct OrganData : Decodable{
    let organs : [Organ]
    private enum CodingKeys: String,CodingKey{
        case organs
    }
   
   struct Organ: Decodable{
    let name: String

    private enum CodingKeys: String, CodingKey{
        case name
    }
}

}
