//
//  PayeePickerRootView.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/05/2025.
//

import Factory
import SwiftUI

struct PayeePickerRootView: View {
    let viewModel: PayeePickerViewModel = Container.shared.payeePickerViewModel()
    
    @Binding var payee: PayeePresentation?
    @Binding var destination: TransactionDetailViewModel.Destination?
    
    @FocusState var focused: Bool
    
    var body: some View {
        @Bindable var viewModel = viewModel
        Group {
            switch viewModel.state {
            case .error:
                Text("Error view goes here")
            case .loading:
                ProgressView()
            case .success(let payeeNames):
                PayeePickerView(
                    searchText: $viewModel.searchText,
                    focused: _focused,
                    intent: { intent in viewModel.handle(intent: intent) },
                    payeeNames: payeeNames,
                    selectPayee: { payee in
                        self.payee = payee
                        self.destination = nil
                    }
                )
                .contentMargins(.top, 12)
            }
        }
        .navigationTitle("Payee")
        .task {
            viewModel.handle(intent: .getPayees)
        }
        .onAppear {
            viewModel.searchText = ""
            viewModel.isFocused = true
        }
    }
}

#Preview {
    PayeePickerRootView(payee: .constant(nil), destination: .constant(nil))
}
