//
//  Container+NewTransaction.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import Factory

extension Container {
    
    // MARK: View Model
    
    var newTransactionViewModel: Factory<NewTransactionViewModel> {
        self { NewTransactionViewModel() }
    }
    
    var payeePickerViewModel: Factory<PayeePickerViewModel> {
        self { PayeePickerViewModel() }
            .singleton
    }
    
    var categoryPickerViewModel: Factory<CategoryPickerViewModel> {
        self { CategoryPickerViewModel() }
            .singleton
    }
    
    var accountPickerViewModel: Factory<AccountPickerViewModel> {
        self { AccountPickerViewModel() }
            .singleton
    }
    
    // MARK: Mappers
    
    var payeesStateMapper: Factory<PayeesStateMapper> {
        self { PayeesStateMapper() }
            .singleton
    }
    
    var payeeMapper: Factory<PayeeMapper> {
        self { PayeeMapper() }
            .singleton
    }
    
    var payeePresentationMapper: Factory<PayeePresentationMapper> {
        self { PayeePresentationMapper() }
            .singleton
    }
    
    var categoriesStateMapper: Factory<CategoriesStateMapper> {
        self { CategoriesStateMapper() }
            .singleton
    }
    
    var categoriesPresentationMapper: Factory<CategoriesPresentationMapper> {
        self { CategoriesPresentationMapper() }
            .singleton
    }
    
    // MARK: Use Cases & Data Sources
    
    var addTransactionUseCase: Factory<AddTransactionUseCase> {
        self { AddTransactionUseCase() }
            .singleton
    }
    
    var addTransactionSource: Factory<AddTransactionSource> {
        self { AddTransactionDataSource() }
            .singleton
    }
    
    var getPayeesUseCase: Factory<GetPayeesUseCase> {
        self { GetPayeesUseCase() }
            .singleton
    }
    
    var getPayeesSource: Factory<GetPayeesSource> {
        self { GetPayeesDataSource() }
            .singleton
    }
    
    var getCategoryGroupsUseCase: Factory<GetCategoryGroupsUseCase> {
        self { GetCategoryGroupsUseCase() }
            .singleton
    }
    
    var getCategoryGroupsSource: Factory<GetCategoryGroupsSource> {
        self { GetCategoryGroupsDataSource() }
            .singleton
    }
    
    var getAccountsUseCase: Factory<GetAccountsUseCase> {
        self { GetAccountsUseCase() }
            .singleton
    }
    
    var getAccountsSource: Factory<GetAccountsSource> {
        self { GetAccountsDataSource() }
            .singleton
    }
}
