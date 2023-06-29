//
//  APIClient.swift
//  RAAssignment
//
//  Created by Fitzgerald Afful on 28/06/2023.
//

import Foundation
enum Endpoint {
    case getFacilities

    var url: URL {
        switch self {
        case .getFacilities:
            return URL(string: "https://my-json-server.typicode.com/iranjith4/ad-assignment/db")!
        }
    }

    var httpMethod: String {
        switch self {
        case .getFacilities:
            return "GET"
        }
    }
}
