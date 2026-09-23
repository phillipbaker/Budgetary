//
//  Payee.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/08/2024.
//

public struct Payee: Equatable, Hashable, Sendable {
    let id: ID<Payee>
    let name: String
    let type: PayeeType
    let aliases: [String]
    let includedInPayeeList: Bool
    let automaticallyCategorizeIsOn: Bool
    let defaultCategory: TransactionCategory?
    
    init(
        id: ID<Payee>,
        name: String,
        type: PayeeType,
        aliases: [String] = [],
        includedInPayeeList: Bool = true,
        automaticallyCategorizeIsOn: Bool = true,
        defaultCategory: TransactionCategory? = nil
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.aliases = aliases
        self.includedInPayeeList = includedInPayeeList
        self.automaticallyCategorizeIsOn = automaticallyCategorizeIsOn
        self.defaultCategory = defaultCategory
    }
}

extension Payee {
    static func transfer(name: String, accountID: ID<BudgetAccount>) -> Payee {
        return Payee(
            id: ID<Payee>(),
            name: name,
            type: .transfer(accountID),
            aliases: [],
            includedInPayeeList: false,
            automaticallyCategorizeIsOn: false,
            defaultCategory: nil
        )
    }
    
    static func regular(name: String) -> Payee {
        return Payee(
            id: ID<Payee>(),
            name: name,
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategory: nil
        )
    }
}
