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

struct APIClient {
    func request<D: Decodable>(for endpoint: Endpoint) async throws -> D {
        let urlRequest = URLRequest(url: endpoint.url)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        let httpResponse = response as? HTTPURLResponse

        guard let statusCode = httpResponse?.statusCode else {
            throw URLError(.badServerResponse)
        }

        switch statusCode {
        case 200..<300:
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(D.self, from: data)
        case 400:
            throw URLError(.badURL)
        case 401:
            throw HTTPError.unauthorized
        case 404:
            throw URLError(.resourceUnavailable)
        default:
            throw URLError(.badServerResponse)
        }
    }
}

enum HTTPError: LocalizedError {
    case unauthorized

    var errorDescription: String? {
        switch self {
        case .unauthorized:  return "Unauthorized"
        }
    }
}
