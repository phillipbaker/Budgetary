//
//  AccountPickerRowPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/11/2026.
//

public struct AccountPickerRowPresentation: Identifiable, Equatable, Hashable, Sendable {
    let account: TransactionAccountPresentation
    let balance: String
    let balanceStyle: BalanceStyle
    public var id: ID<TransactionAccountPresentation> { account.id }
}
