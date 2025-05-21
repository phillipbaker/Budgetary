//
//  PayeePickerView.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/05/2025.
//

import Factory
import SwiftUI

struct PayeePickerView: View {
    let viewModel: PayeePickerViewModel = Container.shared.payeePickerViewModel()
    
    @Binding var payee: PayeePresentation?
    @Binding var destination: NewTransactionViewModel.Destination?
    
    var body: some View {
        @Bindable var viewModel = viewModel
        Group {
            switch viewModel.state {
            case .error:
                Text("Error view goes here")
            case .loading:
                ProgressView()
            case .success(let payees):
                Group {
                    List {
                        if !viewModel.searchText.isEmpty {
                            Button {
                                // somehow make self.payee the new payee....
                                // viewModel.handle(intent: .newPayee(name: ...
                                self.payee = PayeePresentation(id: UUID().uuidString, name: viewModel.searchText)
                                self.destination = nil
                            } label: {
                                EmptyView()
                                    .overlay {
                                        HStack {
                                            Image(systemName: "plus.circle.fill")
                                            Text("Create “\(viewModel.searchText)” payee")
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                            }
                            
                            ForEach(filteredPayees) { payee in
                                Button {
                                    self.payee = payee
                                    self.destination = nil
                                } label: {
                                    Text(payee.name)
                                }
                                .tint(.primary)
                            }
                        } else {
                            ForEach(payees) { firstLetter in
                                Section {
                                    ForEach(firstLetter.payees) { payee in
                                        Button {
                                            self.payee = payee
                                            self.destination = nil
                                        } label: {
                                            Text(payee.name)
                                        }
                                        .tint(.primary)
                                    }
                                } header: {
                                    Text(firstLetter.letter)
                                }
                            }
                        }
                    }
                    .contentMargins(.top, 12)
//                    .listStyle(.insetGrouped)
                }
                
                var filteredPayees: [PayeePresentation] {
                    guard !viewModel.searchText.isEmpty else { return [] }
                    
                    return payees // [PayeeName]
                        .flatMap { $0.payees } // [PayeePresentation]
                        .filter { $0.name.lowercased().contains(viewModel.searchText.lowercased()) } // [PayeePresentation]
                        .sorted { rank(text: $0.name.lowercased(), against: viewModel.searchText.lowercased()) < rank(text: $1.name.lowercased(), against: viewModel.searchText.lowercased()) }
                }
            }
        }
        .navigationTitle("Payee")
        .searchable(
            text: $viewModel.searchText,
            isPresented: $viewModel.isFocused,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Find or add a payee"
        )
        .task {
            viewModel.handle(intent: .getPayees)
        }
        .onAppear {
            viewModel.searchText = ""
            viewModel.isFocused = true
        }
    }
    
    func rank(text: String, against query: String) -> Int {
        let lowerText = text.lowercased()
        let lowerQuery = query.lowercased()
        
        if lowerText == lowerQuery {
            return 0  // Best match
        } else if lowerText.hasPrefix(lowerQuery) {
            return 1  // Starts with query
        } else if lowerText.contains(lowerQuery) {
            return 2  // Contains query
        } else {
            return 3  // No match
        }
    }
}
