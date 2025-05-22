//
//  Extension+Container.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/03/2025.
//

import Factory

extension Container {
    
    // MARK: Coordinator
    
    var budgetCoordinator: Factory<BudgetCoordinator> {
        self { BudgetCoordinator() }
            .singleton
    }
    
    // MARK: View Model
    
    var budgetViewModel: Factory<BudgetViewModel> {
        self { BudgetViewModel() }
            .singleton
    }
    
    // MARK: Mappers
    
    var budgetMapper: Factory<BudgetMapper> {
        self { BudgetMapper() }
            .singleton
    }
    
    var budgetStateMapper: Factory<BudgetStateMapper> {
        self { BudgetStateMapper() }
            .singleton
    }
    
    var budgetPresentationMapper: Factory<BudgetPresentationMapper> {
        self { BudgetPresentationMapper() }
            .singleton
    }
    
    var budgetMapperPlain: Factory<BudgetMapperPlain> {
        self { BudgetMapperPlain() }
            .singleton
    }
    
    var categoryGroupsMapperPlain: Factory<CategoryGroupsMapperPlain> {
        self { CategoryGroupsMapperPlain() }
            .singleton
    }
    
    var budgetDataMapper: Factory<BudgetDataMapper> {
        self { BudgetDataMapper() }
            .singleton
    }
    
    // MARK: Use Cases & Date Sources
    
    var getBudgetUseCase: Factory<GetBudgetUseCase> {
        self { GetBudgetUseCase() }
            .singleton
    }
    
    var getBudgetSource: Factory<GetBudgetSource> {
        self { GetBudgetDataSource() }
            .singleton
    }
    
    var assignMoneyUseCase: Factory<AssignMoney> {
        self { AssignMoney() }
            .singleton
    }
    
    var assignMoneySource: Factory<AssignMoneySource> {
        self { AssignMoneyDataSource() }
            .singleton
    }
}
