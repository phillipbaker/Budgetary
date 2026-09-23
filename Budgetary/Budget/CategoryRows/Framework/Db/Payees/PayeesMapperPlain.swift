//
//  PayeeMapperPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public class PayeesMapperPlain {
    func map(payeesDb: [PayeeDb]) -> [PayeePlain] {
        return payeesDb.compactMap { payeeDb in
            map(payeeDb: payeeDb)
        }
    }
    
    func map(payeeDb: PayeeDb) -> PayeePlain? {
        guard let type = mapPayeeType(from: payeeDb) else { return nil }
        return PayeePlain(
            id: ID<PayeePlain>(payeeDb.externalID),
            name: payeeDb.name,
            type: type,
            aliases: payeeDb.aliases,
            includedInPayeeList: payeeDb.includedInPayeeList,
            automaticallyCategorizeIsOn: payeeDb.automaticallyCategorizeIsOn,
            defaultCategoryID: ID<CategoryPlain>(payeeDb.defaultCategoryID)
        )
    }
    
    func map(payeePlain: PayeePlain) -> PayeeDb {
        return PayeeDb(
            externalID: payeePlain.id.rawValue,
            name: payeePlain.name,
            type: mapPayeeType(from: payeePlain),
            aliases: payeePlain.aliases,
            includedInPayeeList: payeePlain.includedInPayeeList,
            automaticallyCategorizeIsOn: payeePlain.automaticallyCategorizeIsOn,
            defaultCategoryID: payeePlain.defaultCategoryID?.rawValue,
            accountID: payeePlain.type.accountID?.rawValue
        )
    }
    
    func mapPayeeType(from payeeDb: PayeeDb) -> PayeeTypePlain? {
        switch payeeDb.type {
        case .regular:
            return .regular
        case .transfer:
            guard let accountID = payeeDb.accountID else {
                assertionFailure("Transfer payee \(payeeDb.externalID) has no accountID")
                return nil
            }
            return .transfer(ID<BudgetAccountPlain>(accountID))
        }
    }
    
    func mapPayeeType(from payeePlain: PayeePlain) -> PayeeTypeDb {
        switch payeePlain.type {
        case .regular: .regular
        case .transfer: .transfer
        }
    }
}
