//
//  Container+NewTransaction.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import Factory

extension Container {
    
    // MARK: View Model
    
    var transactionDetailViewModel: ParameterFactory<(TransactionPresentation?, Bool), TransactionDetailViewModel> {
        self { TransactionDetailViewModel(transaction: $0, isNewTransaction: $1) }
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
    
    var transactionAccountsStateMapper: Factory<TransactionAccountsStateMapper> {
        self { TransactionAccountsStateMapper() }
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
    
    var updateTransactionUseCase: Factory<UpdateTransactionUseCase> {
        self { UpdateTransactionUseCase() }
            .singleton
    }
    
    var updateTransactionSource: Factory<UpdateTransactionSource> {
        self { UpdateTransactionDataSource() }
            .singleton
    }
    
    var deleteTransactionUseCase: Factory<DeleteTransactionUseCase> {
        self { DeleteTransactionUseCase() }
            .singleton
    }
    
    var deleteTransactionSource: Factory<DeleteTransactionSource> {
        self { DeleteTransactionDataSource() }
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
    
    var newPayeeUseCase: Factory<NewPayeeUseCase> {
        self { NewPayeeUseCase() }
            .singleton
    }
    
    var newPayeeSource: Factory<NewPayeeSource> {
        self { NewPayeeDataSource() }
    }
    
    var getCategoryGroupsUseCase: Factory<GetCategoryGroupsUseCase> {
        self { GetCategoryGroupsUseCase() }
            .singleton
    }
    
    var getCategoryGroupsSource: Factory<GetCategoryGroupsSource> {
        self { GetCategoryGroupsDataSource() }
            .singleton
    }
    
    var getTransactionAccountsUseCase: Factory<GetTransactionAccountsUseCase> {
        self { GetTransactionAccountsUseCase() }
            .singleton
    }
    
    var getAccountsSource: Factory<GetAccountsSource> {
        self { GetAccountsDataSource() }
            .singleton
    }
}
