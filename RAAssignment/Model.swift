//
//  Model.swift
//  RAAssignment
//
//  Created by Fitzgerald Afful on 28/06/2023.
//

import Foundation

struct FacilitiesResponse: Codable {
    var facilities: [Facility]
    var exclusions: [[Exclusion]]
}

struct Facility: Codable, Equatable {
    static func == (lhs: Facility, rhs: Facility) -> Bool {
        lhs.facilityId == rhs.facilityId
    }

    var facilityId: String
    var name: String
    var options: [FacilityOption]
}

struct FacilityOption: Codable {
    static func == (lhs: FacilityOption, rhs: FacilityOption) -> Bool {
        lhs.id == rhs.id
    }
    var id: String
    var name: String
    var icon: String
}

struct Exclusion: Codable, Equatable {
    static func == (lhs: Exclusion, rhs: Exclusion) -> Bool {
        lhs.facilityId == rhs.facilityId && lhs.optionsId == rhs.optionsId
    }

    var facilityId: String
    var optionsId: String
}
