//
//  FacilityOptionView.swift
//  RAAssignment
//
//  Created by Fitzgerald Afful on 30/06/2023.
//

import SwiftUI

struct FacilityOptionView: View {
    @StateObject var viewModel: FacilitiesViewModel
    @Binding var option: FacilityOption
    @Binding var facility: Facility

    var body: some View {
        HStack {
            Image(option.icon)

            Text(option.name)

            Spacer()

            Toggle("", isOn: Binding<Bool>(
                get: {
                    viewModel.isSelected(option: option, facility: facility)
                },
                set: { _ in
                    viewModel.toggleSelectedOption(option: option, facility: facility)
                }
            )).labelsHidden()
        }
    }
}

struct FacilityOptionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = FacilitiesViewModel()
        let facilityOption = FacilityOption(id: "1", name: "Land", icon: "land")
        let facility = Facility(facilityId: "", name: "", options: [])
        
        FacilityOptionView(
            viewModel: viewModel,
            option: Binding.constant(facilityOption),
            facility: Binding.constant(facility)
        )
    }
}
