//
//  FacilitiesViewModel.swift
//  RAAssignment
//
//  Created by Fitzgerald Afful on 29/06/2023.
//

import Foundation

@MainActor class FacilitiesViewModel: ObservableObject {
    var client = APIClient()
    @Published var facilities: [Facility] = []
    @Published var exclusions: [[Exclusion]] = []
    @Published var selectedOptions: [Exclusion] = []
    @Published var error: Error?
    @Published var isFetching = false

    func retrieveData() {
        if isFetching { return }
        isFetching = true

        Task {
            do {
                let response = try await getFacilities()
                facilities = response.facilities
                exclusions = response.exclusions
            } catch {
                self.error = error
            }
            isFetching = false
        }
    }

    func getFacilities() async throws -> FacilitiesResponse {
        return try await client.request(for: .getFacilities)
    }

    func toggleSelectedOption(option: FacilityOption, facility: Facility) {
        let selectedExclusion = Exclusion(facilityId: facility.facilityId, optionsId: option.id)

        if let existingIndex = selectedOptions.firstIndex(of: selectedExclusion) {
            selectedOptions.remove(at: existingIndex)
            return
        }

        selectedOptions.removeAll { $0.facilityId == selectedExclusion.facilityId }
        selectedOptions.append(selectedExclusion)

        for exclusionSet in exclusions {
            let containsAll = exclusionSet.allSatisfy { exclusion in
                selectedOptions.contains { $0.facilityId == exclusion.facilityId && $0.optionsId == exclusion.optionsId }
            }
            if exclusionSet.contains(selectedExclusion) && containsAll {
                selectedOptions.removeAll(where: { $0 == selectedExclusion })
                // Incompatible options
                error = OptionSelectionError.incompatibleSelection(exclusionSet, facilities)
                return
            }
        }

        error = nil
    }

    func isSelected(option: FacilityOption, facility: Facility) -> Bool {
        return selectedOptions.contains(where: { $0.facilityId == facility.facilityId && $0.optionsId == option.id })
    }

}
