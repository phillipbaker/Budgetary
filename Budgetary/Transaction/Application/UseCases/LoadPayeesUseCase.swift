//
//  LoadPayeesUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/05/2025.
//

import Factory

final class LoadPayeesUseCase: Sendable {
    private let source: GetPayeesSource
    private let mapper: PayeeMapper
    
    init(
        source: GetPayeesSource = Container.shared.getPayeesSource(),
        mapper: PayeeMapper = Container.shared.payeeMapper()
    ) {
        self.source = source
        self.mapper = mapper
    }
    
    func execute() async -> [Payee] {
        let data = await source.getPayeeData()
        return mapper.map(payees: data.payees, categoryGroups: data.categoryGroups)
    }
}
