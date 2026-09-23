//
//  PayeePlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public struct PayeePlain: Equatable, Sendable {
    let id: ID<PayeePlain>
    let name: String
    let type: PayeeTypePlain
    let aliases: [String]
    let includedInPayeeList: Bool
    let automaticallyCategorizeIsOn: Bool
    let defaultCategoryID: ID<CategoryPlain>?
}

enum PayeeTypePlain: Equatable {
    case regular
    case transfer(ID<BudgetAccountPlain>)
}

extension PayeeTypePlain {
    var accountID: ID<BudgetAccountPlain>? {
        switch self {
        case .regular: nil
        case .transfer(let id): id
        }
    }
}
