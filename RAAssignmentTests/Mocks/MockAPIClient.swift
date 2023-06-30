//
//  MockAPIClient.swift
//  RAAssignmentTests
//
//  Created by Fitzgerald Afful on 29/06/2023.
//

import Foundation

class MockAPIClient: APIClient {
    var shouldSucceed = true
    var mockedResponse: FacilitiesResponse?

    override func request<D>(for endpoint: Endpoint) async throws -> D where D : Decodable {
        if shouldSucceed {
            guard let mockedResponse = mockedResponse as? D else {
                throw MockError.invalidMockedResponse
            }
            return mockedResponse
        } else {
            throw MockError.requestFailed
        }
    }
}
