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
    
    var budgetDataMapper: Factory<BudgetDataMapper> {
        self { BudgetDataMapper() }
            .singleton
    }
    
    var getBudgetUseCase: Factory<GetBudget> {
        self { GetBudget() }
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
    
    var newGroupUseCase: Factory<NewGroupUseCase> {
        self { NewGroupUseCase()}
            .singleton
    }
    
    var newGroupSource: Factory<NewGroupSource> {
        self { NewGroupDataSource() }
            .singleton
    }
    
    var newCategoryUseCase: Factory<NewCategoryUseCase> {
        self { NewCategoryUseCase() }
            .singleton
    }
    
    public var newCategorySource: Factory<NewCategorySource> {
        self { NewCategoryDataSource() }
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
    
    var renameGroupUseCase: Factory<RenameGroupUseCase> {
        self { RenameGroupUseCase() }
            .singleton
    }
    
    var renameGroupSource: Factory<RenameGroupSource> {
        self { RenameGroupDataSource() }
            .singleton
    }
    
    var removeCategoryUseCase: Factory<RemoveCategoryUseCase> {
        self { RemoveCategoryUseCase() }
            .singleton
    }
    
    var removeCategorySource: Factory<RemoveCategorySource> {
        self { RemoveCategoryDataSource() }
            .singleton
    }
    
    var removeGroupUseCase: Factory<RemoveGroupUseCase> {
        self { RemoveGroupUseCase() }
            .singleton
    }
    
    var removeGroupSource: Factory<RemoveGroupSource> {
        self { RemoveGroupDataSource() }
            .singleton
    }
    
    var hideCategoryUseCase: Factory<HideCategoryUseCase> {
        self { HideCategoryUseCase() }
            .singleton
    }
    
    var hideCategorySource: Factory<HideCategorySource> {
        self { HideCategoryDataSource() }
            .singleton
    }
    
    var hideCategoryGroupSource: Factory<HideCategoryGroupSource> {
        self { HideCategoryGroupDataSource() }
            .singleton
    }
    
    var moveCategoryGroupUseCase: Factory<MoveCategoryGroupUseCase> {
        self { MoveCategoryGroupUseCase() }
            .singleton
    }
    
    var moveCategoryGroupSource: Factory<MoveCategoryGroupSource> {
        self { MoveCategoryGroupDataSource() }
            .singleton
    }
    
    var moveCategoryUseCase: Factory<MoveCategoryUseCase> {
        self { MoveCategoryUseCase() }
            .singleton
    }
    
    var moveCategorySource: Factory<MoveCategorySource> {
        self { MoveCategoryDataSource() }
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
    
    var categoryGroupsDataSourceLocal: Factory<any CategoryGroupsDataSourceLocal> {
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
    
    // MARK: Stream Broadcaster
    
    var streamBroadcaster: Factory<StreamBroadcaster<Sendable>> {
        self { StreamBroadcaster(id: "Test") }
            .singleton
    }
    
    // MARK: View Models
    
    var budgetViewModel: Factory<BudgetViewModel> {
        self { BudgetViewModel() }
            .singleton
    }
    
    var editCategoriesViewModel: Factory<EditCategoriesViewModel> {
        self { EditCategoriesViewModel() }
            .singleton
    }
}
