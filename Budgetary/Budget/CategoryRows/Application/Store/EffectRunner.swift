//
//  EffectRunner.swift
//  Budgetary
//
//  Created by Phillip Baker on 17/10/2026.
//

@MainActor
struct EffectRunner {
    // Budget
    let loadBudget: LoadBudgetUseCase
    let assignMoney: AssignMoneyUseCase

    // Accounts
    let createBudgetAccount: CreateBudgetAccountUseCase
    let loadBudgetAccounts: LoadBudgetAccountsUseCase
    
    // Transactions
    let saveTransaction: SaveTransactionUseCase

    // Payees
    let createPayee: CreatePayeeUseCase
    let loadPayees: LoadPayeesUseCase
    
    // Category Groups
    let createCategory: CreateCategoryUseCase
    let createCategoryGroup: CreateCategoryGroupUseCase

    func run(_ effect: AppEffect) async -> AppAction? {
        switch effect {
        case .loadBudget:
            do {
                return .loadBudgetSucceeded(try await loadBudget.execute())
            } catch {
                return .loadBudgetFailed
            }
        case .assignMoney(amount: let amount, categoryID: let categoryID, monthYear: let monthYear):
            do {
                try await assignMoney.execute(amount, for: categoryID, in: monthYear)
                return .assignMoneySucceeded
            } catch {
                return .assignMoneyFailed
            }
        case .createBudgetAccount(name: let name, accountType: let accountType, startingBalance: let startingBalance):
            await createBudgetAccount.execute(name: name, accountType: accountType, startingBalance: startingBalance)
            return .createBudgetAccountSucceeded
        case .loadBudgetAccounts:
            return .loadBudgetAccountsSucceeded(await loadBudgetAccounts.execute())

        case .saveTransaction(let request):
            do {
                try await saveTransaction.execute(for: request)
                return .saveTransactionSucceeded
            } catch {
                return .saveTransactionFailed
            }
        case .loadPayees:
            return .loadPayeesSucceeded(await loadPayees.execute())
        case .createPayee(name: let name):
            await createPayee.execute(for: name)
            return .createPayeeSucceeded
        case .createCategoryGroup(name: let name):
            await createCategoryGroup.execute(for: name)
            return .createCategoryGroupSucceeded
        case .createCategory(name: let name, groupID: let groupID):
            await createCategory.execute(for: name, andGroupID: groupID)
            return .createCategorySucceeded
        }
    }
}
