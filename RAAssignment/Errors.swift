//
//  Errors.swift
//  RAAssignment
//
//  Created by Fitzgerald Afful on 30/06/2023.
//

import Foundation

enum HTTPError: LocalizedError {
    case unauthorized

    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Unauthorized"
        }
    }
}

/// Thrown when a user selects an option that is not allowed
enum OptionSelectionError: LocalizedError {
    case incompatibleSelection([Exclusion], [Facility])

    var errorDescription: String? {
        switch self {
        case .incompatibleSelection(let exclusionSet, let facilities):
            let allOptions = facilities.flatMap({ $0.options })
            let exclusionOptions: [String] = exclusionSet.compactMap { exclusion in
                guard let optionName = allOptions.first(where: { $0.id == exclusion.optionsId })?.name,
                      let facilityName = facilities.first(where: { $0.facilityId == exclusion.facilityId })?.name
                else { return nil }
                return "\(optionName) (\(facilityName))"
            }

            let joinedOptions = exclusionOptions.joined(separator: " and ")
            return "You cannot select \(joinedOptions) together"
        }
    }
}

/// Thrown when mocking for tests
enum MockError: Error {
    case invalidMockedResponse
    case requestFailed
}
