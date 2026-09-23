//
//  PayeeName.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/05/2025.
//

public struct PayeePickerDataPresentation: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<PayeePickerDataPresentation>
    let alphabeticalPayees: [PayeeName]
    let transferPayees: [PayeePresentation]
}

public struct PayeeName: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<PayeeName>
    let letter: String
    let payees: [PayeePresentation]
}
