//
//  PayeeName.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/05/2025.
//

public struct PayeeName: Equatable, Hashable, Identifiable, Sendable {
    public let id: String
    let letter: String
    let payees: [PayeePresentation]
}
