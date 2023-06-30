//
//  ErrorAlertViewModifier.swift
//  RAAssignment
//
//  Created by Fitzgerald Afful on 30/06/2023.
//

import Foundation
import SwiftUI

struct ErrorAlertModifier: ViewModifier {
    @Binding var error: Error?

    func body(content: Content) -> some View {
        content.alert(isPresented: Binding(
            get: { error != nil },
            set: { _ in error = nil }
        )) {
            Alert(
                title: Text("Error"),
                message: Text(error?.localizedDescription ?? ""),
                dismissButton: .default(Text("OK"), action: {
                    error = nil
                })
            )
        }
    }
}
