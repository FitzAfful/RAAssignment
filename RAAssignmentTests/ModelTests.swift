//
//  ModelTests.swift
//  RAAssignmentTests
//
//  Created by Fitzgerald Afful on 29/06/2023.
//

import XCTest
@testable import RAAssignment

final class ModelTests: XCTestCase {

    func testFacilityResponseModel() throws {
        // IF
        let resourceName = "response"

        // When
        let response = try FacilitiesResponse.decodeFromJSONResource(
            resourceName: resourceName,
            targetClass: type(of: self)
        )

        // Then
        XCTAssertEqual(response.facilities.count, 3)
        XCTAssertEqual(response.exclusions.count, 3)
        XCTAssertEqual(response.facilities[0].name, "Property Type")
        XCTAssertEqual(response.facilities[0].options.count, 4)
        XCTAssertEqual(response.exclusions[0].count, 2)
    }
}

extension Decodable {
    static func decodeFromJSONResource(resourceName: String, targetClass: AnyClass) throws -> Self {
        let secrets: URL = Bundle(for: targetClass)
            .url(forResource: resourceName, withExtension: "json")!
        let data = try Data(contentsOf: secrets)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Self.self, from: data)
    }
}
