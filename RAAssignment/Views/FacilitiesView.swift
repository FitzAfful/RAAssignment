//
//  FacilitiesView.swift
//  RAAssignment
//
//  Created by Fitzgerald Afful on 28/06/2023.
//

import SwiftUI

struct FacilitiesView: View {
    @StateObject var viewModel = FacilitiesViewModel()

    var body: some View {
        VStack {
            if viewModel.isFetching {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                List {
                    ForEach(viewModel.facilities.indices, id: \.self) { facilityIndex in
                        FacilityItemView(
                            viewModel: viewModel,
                            facility: $viewModel.facilities[facilityIndex],
                            facilityIndex: facilityIndex
                        )
                    }
                }
            }
        }
        .modifier(ErrorAlertModifier(error: $viewModel.error))
        .onAppear { viewModel.retrieveData() }
    }
}


struct FacilitiesView_Previews: PreviewProvider {
    static var previews: some View {
        FacilitiesView()
    }
}
