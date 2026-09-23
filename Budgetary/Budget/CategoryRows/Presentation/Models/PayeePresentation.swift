//
//  PayeePresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/11/2024.
//

public struct PayeePresentation: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<PayeePresentation>
    let name: String
    let type: PayeeTypePresentation
}
