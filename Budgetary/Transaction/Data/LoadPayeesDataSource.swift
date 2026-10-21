//
//  LoadPayeesDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/05/2025.
//

import Factory

final class LoadPayeesDataSource: LoadPayeesSource {
    let payeesDataSourceLocal: any PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    
    func loadPayeeData() async -> PayeeDataPlain {
        return PayeeDataPlain(
            payees: await payeesDataSourceLocal.loadPayees(),
            categoryGroups: await categoryGroupsDataSourceLocal.loadCategoryGroups()
        )
    }
}
