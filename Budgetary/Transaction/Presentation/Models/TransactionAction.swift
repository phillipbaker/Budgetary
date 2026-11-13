//
//  TransactionAction.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

public enum TransactionAction {
    case setDraftAmount(AmountDraft)
    case setDraftTransactionType(TransactionTypePresentation)
    
    // Add Transaction
    case cancelButtonTapped
    case saveTransactionButtonTapped

    // Delete Transaction
    case confirmDeleteButtonTapped(ID<TransactionDraft>)
    
    // Payee Picker
    case payeePickerButtonTapped
    
    // Category Picker
    case categoryPickerButtonTapped
    
    // Account Picker
    case accountPickerButtonTapped
}
