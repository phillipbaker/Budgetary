//
//  GetPayeesUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/05/2025.
//

import Factory

final class GetPayeesUseCase {
    let source: GetPayeesSource = Container.shared.getPayeesSource()
    let mapper: PayeeMapper = Container.shared.payeeMapper()
    
    func getPayees() async -> [Payee] {
        let data = await source.getPayeeData()
        return mapper.map(payees: data.payees, categoryGroups: data.categoryGroups)
    }
}
