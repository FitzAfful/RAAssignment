    @Published var selectedOptions: [Exclusion] = []
    @Published var error: Error?
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
