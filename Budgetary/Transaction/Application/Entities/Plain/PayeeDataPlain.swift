//
//  PayeeDataPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/10/2026.
//

public struct PayeeDataPlain: Equatable, Sendable {
    let payees: [PayeePlain]
    let categoryGroups: [CategoryGroupPlain]
}
