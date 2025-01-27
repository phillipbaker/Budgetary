//
//  BudgetState.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

public enum BudgetState {
    case loading
    case error
    case success(BudgetPresentation)
}
