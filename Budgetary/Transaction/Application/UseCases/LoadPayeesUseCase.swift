//
//  LoadPayeesUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/05/2025.
//

import Factory

final class LoadPayeesUseCase: Sendable {
    private let source: LoadPayeesSource
    private let mapper: PayeeMapper
    
    init(
        source: LoadPayeesSource = Container.shared.loadPayeesSource(),
        mapper: PayeeMapper = Container.shared.payeeMapper()
    ) {
        self.source = source
        self.mapper = mapper
    }
    
    func execute() async -> [Payee] {
        let data = await source.loadPayeeData()
        return mapper.map(payees: data.payees, categoryGroups: data.categoryGroups)
    }
}
