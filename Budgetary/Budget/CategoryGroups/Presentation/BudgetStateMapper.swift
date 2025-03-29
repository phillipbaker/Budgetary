//
//  BudgetStateMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/11/2024.
//

public class BudgetStateMapper {
    var mapper: BudgetPresentationMapper
    
    public init(mapper: BudgetPresentationMapper) {
        self.mapper = mapper
    }
    
    func map(budget: Budget) -> BudgetState {
        return .success(mapper.map(budget: budget))
    }
}
