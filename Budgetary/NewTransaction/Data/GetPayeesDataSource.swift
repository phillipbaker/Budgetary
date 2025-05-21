//
//  GetPayeesDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/05/2025.
//

import Factory

final class GetPayeesDataSource: GetPayeesSource {
    let payeesDataSourceLocal: PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    
    func getPayeeData() async -> CombinedPayeeData {
        return CombinedPayeeData(
            payees: await payeesDataSourceLocal.allPayees(),
            categoryGroups: await categoryGroupsDataSourceLocal.allCategoryGroups()
        )
        
    }
}

public struct CombinedPayeeData: Equatable, Sendable {
    let payees: [PayeePlain]
    let categoryGroups: [CategoryGroupPlain]
}
