//
//  Container+Transaction.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import Factory

extension Container {
    
    // MARK: View Model
    
    @MainActor
    var transactionViewModel: Factory<TransactionViewModel> {
        self { @MainActor in TransactionViewModel() }
            .singleton
    }
    
    @MainActor
    var amountViewModel: Factory<TransactionAmountViewModel> {
        self { @MainActor in TransactionAmountViewModel() }
            .singleton
    }
    
    @MainActor
    var newCategoryViewModel: ParameterFactory<(String, (TransactionCategoryPresentation) -> Void, () -> Void), NewCategoryViewModel> {
        self { @MainActor params in
            NewCategoryViewModel(
                newCategoryName: params.0,
                onCategoryCreated: params.1,
                onCancel: params.2
            )
        }
        .shared
    }
    
    
    @MainActor
    var newCategoryGroupViewModel: ParameterFactory<((CategoryGroupNamePresentation) -> Void, () -> Void), NewCategoryGroupViewModel> {
        self { @MainActor params in
            NewCategoryGroupViewModel(
                onGroupCreated: params.0,
                onCancel: params.1
            )
        }
    }
    
    // MARK: Mappers
    
    var payeeMapper: Factory<PayeeMapper> {
        self { PayeeMapper() }
            .singleton
    }
    
    var payeePresentationMapper: Factory<PayeePresentationMapper> {
        self { PayeePresentationMapper() }
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
    
    var saveTransactionUseCase: Factory<SaveTransactionUseCase> {
        self { SaveTransactionUseCase() }
            .singleton
    }
    
    var saveTransactionSource: Factory<SaveTransactionSource> {
        self { SaveTransactionDataSource() }
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
    
    var loadPayeesUseCase: Factory<LoadPayeesUseCase> {
        self { LoadPayeesUseCase() }
            .singleton
    }
    
    var loadPayeesSource: Factory<LoadPayeesSource> {
        self { LoadPayeesDataSource() }
            .singleton
    }
    
    var createPayeeUseCase: Factory<CreatePayeeUseCase> {
        self { CreatePayeeUseCase() }
            .singleton
    }
    
    var createPayeeSource: Factory<CreatePayeeSource> {
        self { CreatePayeeDataSource() }
    }
    
    var loadCategoryGroupsUseCase: Factory<LoadCategoryGroupsUseCase> {
        self { LoadCategoryGroupsUseCase() }
            .singleton
    }
    
    var loadCategoryGroupsSource: Factory<LoadCategoryGroupsSource> {
        self { LoadCategoryGroupsDataSource() }
            .singleton
    }
}
