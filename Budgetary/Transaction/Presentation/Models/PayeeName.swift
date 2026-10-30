//
//  PayeeName.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/05/2025.
//

public struct PayeePickerDataPresentation: Equatable, Hashable, Sendable {
    let alphabeticalPayees: [PayeeName]
    let transferPayees: [PayeePresentation]
}

public struct PayeeName: Equatable, Hashable, Identifiable, Sendable {
    public var id: String { letter }
    let letter: String
    let payees: [PayeePresentation]
}
