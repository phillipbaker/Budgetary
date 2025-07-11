//
//  AccountPickerView.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import Factory
import SwiftUI

struct AccountPickerView: View {
    let viewModel: AccountPickerViewModel = Container.shared.accountPickerViewModel()
    
    @Binding var account: TransactionAccountPresentation?
    @Binding var destination: TransactionDetailViewModel.Destination?
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .error:
                Text("Put error view here")
            case .loading:
                ProgressView()
            case .success(let transactionAccounts):
                List {
                    ForEach(transactionAccounts) { account in
                        Button {
                            self.account = account
                            self.destination = nil
                        } label: {
                            HStack {
                                Image(systemName: self.account == account ? "checkmark" : "")
                                Text(account.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .tint(.primary)
//                                Text(account.name)
                                // tint and/or foregroundColor...
                                // gray for zero balance
                                // black with minus sign for negative balance
                                // green for positive balance...
                            }
                        }
                    }
                }
            }
        }
        .task {
            viewModel.handle(intent: .getTransactionAccounts)
        }
    }
}

#Preview {
    AccountPickerView(account: .constant(nil), destination: .constant(nil))
}
