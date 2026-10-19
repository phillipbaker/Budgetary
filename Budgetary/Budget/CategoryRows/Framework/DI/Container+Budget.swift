//
//  Extension+Container.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/03/2025.
//

import Factory

extension Container {
    
    // MARK: View Model
    
    @MainActor
    var homeViewModel: Factory<HomeViewModel> {
        self { @MainActor in HomeViewModel() }
            .singleton
    }
    
    @MainActor
    var budgetViewModel: Factory<BudgetViewModel> {
        self { @MainActor in BudgetViewModel() }
            .singleton
    }
    
    // MARK: Mappers

    var budgetMapper: Factory<BudgetMapper> {
        self { BudgetMapper() }
            .singleton
    }

    var budgetRowMapper: Factory<BudgetRowMapper> {
        self { BudgetRowMapper() }
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
    
    var creditCardGroupMapperPlain: Factory<CreditCardPaymentGroupMapperPlain> {
        self { CreditCardPaymentGroupMapperPlain() }
            .singleton
    }
    
    // MARK: Use Cases & Date Sources
    
    var loadBudgetUseCase: Factory<LoadBudgetUseCase> {
        self { LoadBudgetUseCase() }
            .singleton
    }
    
    var loadBudgetSource: Factory<LoadBudgetSource> {
        self { LoadBudgetDataSource() }
            .singleton
    }
    
    var assignMoneyUseCase: Factory<AssignMoneyUseCase> {
        self { AssignMoneyUseCase() }
            .singleton
    }
    
    var assignMoneySource: Factory<AssignMoneySource> {
        self { AssignMoneyDataSource() }
            .singleton
    }
    
    @MainActor
    var appStore: Factory<AppStore> {
        self { @MainActor in AppStore(reducer: appReducer, effectRunner: self.effectRunner()) }
            .singleton
    }
    
    @MainActor
    var effectRunner: Factory<EffectRunner> {
        self { @MainActor in
            EffectRunner(
                loadBudget: self.loadBudgetUseCase(),
                assignMoney: self.assignMoneyUseCase(),
                createBudgetAccount: self.createBudgetAccountUseCase(),
                loadBudgetAccounts: self.loadBudgetAccountsUseCase(),
                saveTransaction: self.saveTransactionUseCase(),
                createPayee: self.createPayeeUseCase(),
                loadPayees: self.loadPayeesUseCase(),
                createCategory: self.createCategoryUseCase(),
                createCategoryGroup: self.createCategoryGroupUseCase()
            )
        }
        .singleton
    }
}
