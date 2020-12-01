//
//  MatchingData.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/11/26.
//

import Foundation

struct MatchingData : Decodable{
    let matching : [Matching]
    private enum CodingKeys: String, CodingKey{
        case matching
    }
    struct Matching : Decodable{
        let donorAge : String
        let donorCoords: String
        let donorIndex : Int
        let donorName : String
        let donorOrgan : String
        //let eta : Float
        let recipientAge : String
        let recipientCoords : String
        let recipientIndex : Int
        let recipientName : String
        //let recipientOrgan : String
        
        private enum CodingKeys: String, CodingKey{
            case donorAge = "donor_age"
            case donorCoords = "donor_coords"
            case donorIndex = "donor_index"
            case donorName = "donor_name"
            case donorOrgan = "donor_organ"
            //case eta
            case recipientAge = "recipient_age"
            case recipientCoords = "recipient_coords"
            case recipientIndex = "recipient_index"
            case recipientName = "recipient_name"
            //case recipientOrgan = "recipient_organ"
        }
    }
}
