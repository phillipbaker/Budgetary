//
//  Extension+Container.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/03/2025.
//

import Factory
import SwiftData

extension Container {
    
    // MARK: Budget
    
    var budgetCoordinator: Factory<BudgetCoordinator> {
        self { BudgetCoordinator() }
            .singleton
    }
    
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
    
    var combinedBudgetDataMapper: Factory<CombinedBudgetDataMapper> {
        self { CombinedBudgetDataMapper() }
            .singleton
    }
    
    var getBudgetUseCase: Factory<GetBudget> {
        self { GetBudget() }
            .singleton
    }
    
    var getBudgetSource: Factory<GetBudgetSource> {
        self { GetBudgetSourceCombined() }
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
    
    // MARK: Edit Categories
    
    var editCategoriesMapper: Factory<EditCategoriesMapper> {
        self { EditCategoriesMapper() }
            .singleton
    }
    
    var editCategoriesStateMapper: Factory<EditCategoriesStateMapper> {
        self { EditCategoriesStateMapper() }
            .singleton
    }
    
    var editCategoriesPresentationMapper: Factory<EditCategoriesPresentationMapper> {
        self { EditCategoriesPresentationMapper() }
            .singleton
    }
    
    var loadCategoryGroupsUseCase: Factory<LoadCategoryGroupsUseCase> {
        self { LoadCategoryGroupsUseCase() }
            .singleton
    }
    
    var loadCategoryGroupsSource: Factory<LoadCategoryGroupsSource> {
        self { LoadCategoryGroupsDataSource() }
            .singleton
    }
    
    var renameCategoryUseCase: Factory<RenameCategoryUseCase> {
        self { RenameCategoryUseCase() }
            .singleton
    }
    
    var renameCategorySource: Factory<RenameCategorySource> {
        self { RenameCategoryDataSource() }
            .singleton
    }
    
    // MARK: Data Gateways
    
    var budgetDataSourceLocal: Factory<BudgetDataSourceLocal> {
        self { BudgetLocalDatagateway() }
            .singleton
    }
    
    var payeesDataSourceLocal: Factory<PayeesDataSourceLocal> {
        self { PayeesLocalDataGateway() }
            .singleton
    }
    
    var budgetAccountsDataSourceLocal: Factory<BudgetAccountsDataSourceLocal> {
        self { BudgetAccountsLocalDataGateway() }
            .singleton
    }
    
    var categoryGroupsDataSourceLocal: Factory<CategoryGroupsDataSourceLocal> {
        self { CategoryGroupsLocalDataGateway() }
            .singleton
    }
    
    var budgetAccountsMapperPlain: Factory<BudgetAccountsMapperPlain> {
        self { BudgetAccountsMapperPlain() }
            .singleton
    }
    
    var payeesMapperPlain: Factory<PayeesMapperPlain> {
        self { PayeesMapperPlain() }
            .singleton
    }
    
    // MARK: DAOs
    
    var budgetDao: Factory<BudgetDao> {
        self { BudgetDao(container: try! ModelContainer()) }
            .singleton
    }
    
    var categoryGroupDao: Factory<CategoryGroupDao> {
        self { CategoryGroupDao(container: try! ModelContainer()) }
            .singleton
    }
    
    var payeeDao: Factory<PayeeDao> {
        self { PayeeDao(container: try! ModelContainer()) }
            .singleton
    }
    
    var budgetAccountDao: Factory<BudgetAccountDao> {
        self { BudgetAccountDao(container: try! ModelContainer()) }
            .singleton
    }
}
