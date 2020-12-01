//
//  PatientData.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/11/20.
//

import Foundation
struct PatientData : Decodable{
    let patients : [Patient]
    private enum CodingKeys: String,CodingKey{
        case patients
    }
   
   struct Patient: Decodable{
    let name: String
    let age : String
    let blood_group : String
    let sex : String
    let weight : String

    private enum CodingKeys: String, CodingKey{
        case name
        case age
        case blood_group
        case sex
        case weight
    }
}

}
