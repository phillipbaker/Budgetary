//
//  Container+NewTransaction.swift
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

//    var payeePickerViewModel: Factory<PayeePickerViewModel> {
//        self { PayeePickerViewModel() }
//            .singleton
//    }
    
//    var categoryPickerViewModel: Factory<CategoryPickerViewModel> {
//        self { CategoryPickerViewModel() }
//            .singleton
//    }
    
//    var accountPickerViewModel: Factory<AccountPickerViewModel> {
//        self { AccountPickerViewModel() }
//            .singleton
//    }
    
    // MARK: Mappers
    
//    var payeesStateMapper: Factory<PayeesStateMapper> {
//        self { PayeesStateMapper() }
//            .singleton
//    }
    
    var payeeMapper: Factory<PayeeMapper> {
        self { PayeeMapper() }
            .singleton
    }
    
    var payeePresentationMapper: Factory<PayeePresentationMapper> {
        self { PayeePresentationMapper() }
            .singleton
    }
    
//    var categoriesStateMapper: Factory<CategoriesStateMapper> {
//        self { CategoriesStateMapper() }
//            .singleton
//    }
    
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
        self { AddTransactionDataSource() }
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
    
    var loadCategoryGroupsUseCase: Factory<LoadCategoryGroupsUseCase> {
        self { LoadCategoryGroupsUseCase() }
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
}
