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
            id: ID<Payee>(payee.id),
            name: payee.name,
            type: map(payeeTypePlain: payee.type),
            aliases: payee.aliases,
            includedInPayeeList: payee.includedInPayeeList,
            automaticallyCategorizeIsOn: payee.automaticallyCategorizeIsOn,
            defaultCategory: TransactionMapper.mapCategory(
                categoryID: payee.defaultCategoryID,
                categoryGroups: categoryGroups
            )
        )
    }
    
    func map(payee: Payee) -> PayeePlain {
        return PayeePlain(
            id: ID<PayeePlain>(payee.id),
            name: payee.name,
            type: map(payeeType: payee.type),
            aliases: payee.aliases,
            includedInPayeeList: payee.includedInPayeeList,
            automaticallyCategorizeIsOn: payee.automaticallyCategorizeIsOn,
            defaultCategoryID: ID<CategoryPlain>(payee.defaultCategory?.id)
        )
    }
    
    func map(payeeTypePlain: PayeeTypePlain) -> PayeeType {
        switch payeeTypePlain {
        case .regular: .regular
        case .transfer(let accountID): .transfer(ID<BudgetAccount>(accountID))
        }
    }
    
    func map(payeeType: PayeeType) -> PayeeTypePlain {
        switch payeeType {
        case .regular: .regular
        case .transfer(let accountID): .transfer(ID<BudgetAccountPlain>(accountID))
        }
    }
}
