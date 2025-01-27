//
//  PayeeMapperPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public class PayeesMapperPlain {
    func map(payeesDb: [PayeeDb]) -> [PayeePlain] {
        return payeesDb.map { payeeDb in
            map(payeeDb: payeeDb)
        }
    }
    
    func map(payeeDb: PayeeDb) -> PayeePlain {
        return PayeePlain(
            id: payeeDb.id,
            name: payeeDb.name,
            aliases: payeeDb.aliases,
            includedInPayeeList: payeeDb.includedInPayeeList,
            automaticallyCategorizeIsOn: payeeDb.automaticallyCategorizeIsOn,
            defaultCategoryId: payeeDb.defaultCategoryId
        )
    }
    
    func map(payeePlain: PayeePlain) -> PayeeDb {
        return PayeeDb(
            id: payeePlain.id,
            name: payeePlain.name,
            aliases: payeePlain.aliases,
            includedInPayeeList: payeePlain.includedInPayeeList,
            automaticallyCategorizeIsOn: payeePlain.automaticallyCategorizeIsOn,
            defaultCategoryId: payeePlain.defaultCategoryId
        )
    }
}
