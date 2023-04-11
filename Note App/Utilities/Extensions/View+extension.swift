//
//  View+extension.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/10/23.
//

import SwiftUI

extension View {
  func emptyState<EmptyContent>(_ isEmpty: Bool,
                                emptyContent: @escaping () -> EmptyContent) -> some View where EmptyContent: View {
    modifier(EmptyStateViewModifier(isEmpty: isEmpty, emptyContent: emptyContent))
  }
}
extension View {
    func errorAlert(showingAlert: Binding<Bool>,errorReason: String, buttonTitle: String = "OK") -> some View {
        return alert("Error", isPresented: showingAlert) {
            Button(buttonTitle) {
            }
        } message: {
            Text(errorReason)
        }

    }
}
