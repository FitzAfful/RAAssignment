//
//  FacilitiesViewModelTests.swift
//  RAAssignmentTests
//
//  Created by Fitzgerald Afful on 29/06/2023.
//

import XCTest
@testable import RAAssignment

final class FacilitiesViewModelTests: XCTestCase {
    var viewModel: FacilitiesViewModel!
    var mockAPIClient: MockAPIClient!

    @MainActor override func setUp() {
        super.setUp()
        viewModel = FacilitiesViewModel()
        mockAPIClient = MockAPIClient()
        viewModel.client = mockAPIClient
    }

    func testGetFacilities_Success() async throws {
        // If
        let mockedResponse = FacilitiesResponse(facilities: [], exclusions: [])
        mockAPIClient.mockedResponse = mockedResponse

        // When
        let response = try await viewModel.getFacilities()

        // Then
        XCTAssertEqual(response.facilities, mockedResponse.facilities)
        XCTAssertEqual(response.exclusions, mockedResponse.exclusions)
    }

    @MainActor func testGetFacilities_Failure() async throws {
        // If
        mockAPIClient.shouldSucceed = false

        // When
        do {
            _ = try await viewModel.getFacilities()
        } catch {
            XCTAssertEqual(error as? MockError, MockError.requestFailed)
        }
    }

    @MainActor func testToggleSelect() throws {
        // If
        let response = try FacilitiesResponse.decodeFromJSONResource(
            resourceName: "response",
            targetClass: type(of: self)
        )

        viewModel.facilities = response.facilities
        viewModel.exclusions = response.exclusions

        // When
        viewModel.toggleSelectedOption(option: viewModel.facilities[0].options[3], facility: viewModel.facilities[0])

        // Then
        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.selectedOptions.count, 1)
        XCTAssertEqual(viewModel.selectedOptions.map({ $0.optionsId }), ["4"])
        XCTAssertEqual(viewModel.selectedOptions.map({ $0.facilityId }), ["1"])

        viewModel.toggleSelectedOption(option: viewModel.facilities[1].options[1], facility: viewModel.facilities[1])
        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.selectedOptions.count, 2)
        XCTAssertEqual(viewModel.selectedOptions.map({ $0.facilityId }), ["1", "2"])
        XCTAssertEqual(viewModel.selectedOptions.map({ $0.optionsId }), ["4", "7"])

        viewModel.toggleSelectedOption(option: viewModel.facilities[1].options[0], facility: viewModel.facilities[1])
        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.selectedOptions.count, 1)
        XCTAssertEqual(viewModel.selectedOptions.map({ $0.facilityId }), ["1"])
        XCTAssertEqual(viewModel.selectedOptions.map({ $0.optionsId }), ["4"])
    }

    @MainActor func testIsCompatibleOption2() throws {
        // If
        let response = try FacilitiesResponse.decodeFromJSONResource(
            resourceName: "response",
            targetClass: type(of: self)
        )

        viewModel.facilities = response.facilities
        viewModel.exclusions = response.exclusions

        viewModel.toggleSelectedOption(option: viewModel.facilities[0].options[2], facility: viewModel.facilities[0])
        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.selectedOptions.count, 1)
        XCTAssertEqual(viewModel.selectedOptions.map({ $0.optionsId }), ["3"])
        XCTAssertEqual(viewModel.selectedOptions.map({ $0.facilityId }), ["1"])

        viewModel.toggleSelectedOption(option: viewModel.facilities[1].options[1], facility: viewModel.facilities[1])
        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.selectedOptions.count, 2)
        XCTAssertEqual(viewModel.selectedOptions.map({ $0.facilityId }), ["1", "2"])
        XCTAssertEqual(viewModel.selectedOptions.map({ $0.optionsId }), ["3", "7"])

        viewModel.toggleSelectedOption(option: viewModel.facilities[2].options[2], facility: viewModel.facilities[2])
        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.selectedOptions.count, 2)
        XCTAssertEqual(viewModel.selectedOptions.map({ $0.facilityId }), ["1", "2"])
        XCTAssertEqual(viewModel.selectedOptions.map({ $0.optionsId }), ["3", "7"])
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
}

