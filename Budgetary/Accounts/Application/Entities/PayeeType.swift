//
//  PayeeType.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/12/2025.
//

enum PayeeType: Equatable, Hashable {
    case regular
    case transfer(ID<BudgetAccount>)
}
