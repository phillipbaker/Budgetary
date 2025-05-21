//
//  BudgetState.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

public enum BudgetState {
    case error
    case loading
    case success(BudgetPresentation)
}
