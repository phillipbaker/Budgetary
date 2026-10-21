//
//  CreatePayeeDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/06/2025.
//

import Factory

final class CreatePayeeDataSource: CreatePayeeSource {
    let payeesDataSourceLocal: any PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
    
    func create(payee: PayeePlain) async {
        await payeesDataSourceLocal.create(payee: payee)
    }
}
