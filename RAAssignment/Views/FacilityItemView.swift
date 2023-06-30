//
//  FacilityItemView.swift
//  RAAssignment
//
//  Created by Fitzgerald Afful on 28/06/2023.
//

import SwiftUI

struct FacilityItemView: View {
    @StateObject var viewModel: FacilitiesViewModel
    @Binding var facility: Facility
    @State var facilityIndex: Int

    var body: some View {
        Section(header: Text(facility.name)) {
            ForEach(facility.options.indices, id: \.self) { optionIndex in
                FacilityOptionView(
                    viewModel: viewModel,
                    option: $viewModel.facilities[facilityIndex].options[optionIndex],
                    facility: $viewModel.facilities[facilityIndex]
                )
            }
        }
    }
}

struct FacilityItemView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = FacilitiesViewModel()
        viewModel.facilities.append(Facility(facilityId: "1", name: "Property Type", options: [FacilityOption(id: "1", name: "Land", icon: "land")]))

        return Group {
            FacilityItemView(viewModel: viewModel, facility: Binding.constant(viewModel.facilities[0]), facilityIndex: 0)
        }
    }
}
