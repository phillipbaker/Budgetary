//
//  BudgetStateMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/11/2024.
//

import Factory

public final class BudgetStateMapper {
    let mapper: BudgetPresentationMapper = Container.shared.budgetPresentationMapper()
    
    func map(budget: Budget) -> BudgetState {
        return .success(mapper.map(budget: budget))
    }
}
