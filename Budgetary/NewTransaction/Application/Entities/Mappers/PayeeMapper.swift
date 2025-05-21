//
//  PayeeMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 15/05/2025.
//

public final class PayeeMapper: Sendable {
    func map(payees: [PayeePlain], categoryGroups: [CategoryGroupPlain]) -> [Payee] {
        payees.map { payee in
            map(payee: payee, categoryGroups: categoryGroups)
        }
    }
    
    func map(payee: PayeePlain, categoryGroups: [CategoryGroupPlain]) -> Payee {
        return Payee(
            id: payee.id,
            name: payee.name,
            aliases: payee.aliases,
            includedInPayeeList: payee.includedInPayeeList,
            automaticallyCategorizeIsOn: payee.automaticallyCategorizeIsOn,
            defaultCategory: TransactionMapper.mapCategory(
                categoryId: payee.defaultCategoryId,
                categoryGroups: categoryGroups
            )
        )
    }
}
