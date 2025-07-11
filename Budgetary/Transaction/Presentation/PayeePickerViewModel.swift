//
//  PayeePickerViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//


import Factory
import SwiftUI

@Observable
final class PayeePickerViewModel {
    @ObservationIgnored private let getPayeesUseCase: GetPayeesUseCase = Container.shared.getPayeesUseCase()
    @ObservationIgnored private let newPayeeUseCase: NewPayeeUseCase = Container.shared.newPayeeUseCase()
    @ObservationIgnored private let stateMapper: PayeesStateMapper = Container.shared.payeesStateMapper()
    
    var state: PayeePickerState
    var searchText: String = ""
    var isFocused: Bool = true
    
    init(state: PayeePickerState = .loading) {
        self.state = state
    }
    
    @MainActor
    func handle(intent: PayeePickerIntent) {
        Task {
            switch intent {
            case .getPayees:
                self.state = stateMapper.map(payees: await getPayeesUseCase.getPayees())
            case let .newPayee(name):
                await newPayeeUseCase.createPayee(from: name)
            }
        }
    }
}
