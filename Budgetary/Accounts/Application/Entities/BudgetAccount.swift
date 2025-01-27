//
//  BudgetAccount.swift
//  Budgetary
//
//  Created by Phillip Baker on 23/08/2024.
//

import Foundation

public struct BudgetAccount: Equatable, Sendable {
    let id: String
    let nickname: String
    let accountType: AccountType
    
    /// The current balance when adding an account. Non-optional, defaults to zero.
    let startingBalance: Decimal
    
    /// Optional notes associated with the account.
    let notes: String?
    
    /// Boolean value for whether or not an account has been “closed” and no longer appears in the budget calculation
    // Need to know what calculations to perform when closing an account...
    let isClosed: Bool
    
    /// All transactions that belong to the account. Non-optional, defaults to empty.
    let transactions: [TransactionEntity]
    
    var transactionTotal: Decimal {
        /// Sum of all inflow and outflow transactions
        /// Maps transactions to add or subtract amount
        let amounts: [Decimal] = transactions.map { transaction in
            switch transaction.amount {
            case .inflow(let amount):
                return amount
            case .outflow(let amount):
                return -amount
            }
        }
        
        return amounts.reduce(0.00, +)
    }
    
    var balance: Decimal {
        var balance = startingBalance
        for transaction in transactions {
            balance += transaction.amount.value
        }
        return balance
    }
    
    /// Sum of uncleared transactions
    var uncleared: Decimal {
        let amounts: [Decimal] = transactions
            .filter { !$0.isCleared }
            .map {
                switch $0.amount {
                case .inflow(let amount):
                    return amount
                case .outflow(let amount):
                    return -amount
                }
            }
        return amounts.reduce(0.00, +)
    }
    
    var cleared: Decimal {
        return transactionTotal - uncleared
    }
    
    /// Working balance provides the actual value for available funds.
    var workingBalance: Decimal {
        get {
            cleared - uncleared
        }
        // Is settable - if set a new transaction is created to cover the diference and keep budget balanced...
        // Write logic for that...
        set {
//            if larger than current workingBalance
//                let adjustment = Transaction(
//                    day: .now,
//                    payee: Payee(),
//                    category: Category(
//                        id: .init(),
//                        name: "Inflow: Ready to Assign"
//                    ),
//                    type: workingBalance > newValue ? .inflow(workingBalance - newValue) : .outflow(workingBalance - newValue),
//                    isCleared: true
//                )
//                transactions.append(
            // create/append a new cleared transaction for the difference between current working balance and new total
        }
    }
}

struct LoanMortgageAccount {}
struct TrackingAccount {} // one type or separate for assets and liabilities? Prob separate...?

enum AccountType: Codable, Sendable {
    // Do these need to be further split into Budget, Loan/Mortage, Tracking? Or three separate enums that again conform to a protocol somehow to link them?
    //  - Budget accounts
    //    - Checking
    //    - Savings
    //    - Cash
    //    - Line of credit
    //    - Credit card
    //  - Mortgages and Loans
    //    - Mortgage
    //    - Auto loan
    //    - Student loan
    //    - Personal loan
    //    - Medical debt
    //    - Other debt
    //  - Tracking accounts
    //    - Asset/investmrnt
    //    - Liability
    case budget
    case tracking
}

