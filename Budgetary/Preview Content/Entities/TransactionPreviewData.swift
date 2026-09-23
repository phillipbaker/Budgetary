//
//  TransactionPreviews.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/09/2024.
//

import Foundation

extension Array where Element == BudgetTransaction {
    static let preview: [BudgetTransaction] = [
        .augSalary,
        .augRent,
        .augCouncilTax,
        .augUtilities,
        .augWater,
        .augGroceries1,
        .augGroceries2,
        .augGroceries3,
        .augGroceries4,
        .augGroceries5,
        .sepSalary,
        .sepRent,
        .sepCouncilTax,
        .sepUtilities,
        .sepWater,
        .sepGroceries1,
        .sepGroceries2,
        .sepGroceries3,
        .sepGroceries4,
        .sepGroceries5,
        .octSalary,
        .octRent,
        .octCouncilTax,
        .octUtilities,
        .octWater,
        .octGroceries1,
        .octGroceries2,
        .octGroceries3,
        .octGroceries4,
        .octGroceries5,
    ].sorted { $0.date < $1.date }
}

extension TransactionAccount {
    static let hsbc = TransactionAccount(id: .init(), name: "HSBC")
}

extension BudgetTransaction {
    // August 2024
    
    static let augSalary = BudgetTransaction(
        id: .init(),
        date: .augEigth2024,
        memo: "",
        amount: .inflow(1000),
        isCleared: true,
        payee: .reorg,
        category: .readyToAssign,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let augRent = BudgetTransaction(
        id: .init(),
        date: .augEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .anthonyMartin,
        category: .rent,
        account: .hsbc,
        linkedTransactionID: nil

    )
    
    static let augCouncilTax = BudgetTransaction(
        id: .init(),
        date: .augNinth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .bexley,
        category: .councilTax,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let augUtilities = BudgetTransaction(
        id: .init(),
        date: .augNinth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .eonNext,
        category: .utilities,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let augWater = BudgetTransaction(
        id: .init(),
        date: .augTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .thamesWater,
        category: .water,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let augInternet = BudgetTransaction(
        id: .init(),
        date: .augFourteenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .plusnet,
        category: .internet,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let augTvLicense = BudgetTransaction(
        id: .init(),
        date: .augTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .tvLicence,
        category: .tvLicense,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let augCellPhones = BudgetTransaction(
        id: .init(),
        date: .augTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .giffGaff,
        category: .cellPhones,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let augGroceries1 = BudgetTransaction(
        id: .init(),
        date: .augEigth2024,
        memo: "",
        amount: .outflow(300),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let augGroceries2 = BudgetTransaction(
        id: .init(),
        date: .augEigth2024,
        memo: "",
        amount: .outflow(200),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let augGroceries3 = BudgetTransaction(
        id: .init(),
        date: .augTenth2024,
        memo: "",
        amount: .outflow(200),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let augGroceries4 = BudgetTransaction(
        id: .init(),
        date: .augFourteenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let augGroceries5 = BudgetTransaction(
        id: .init(),
        date: .augEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    // September 2024
    
    static let sepSalary = BudgetTransaction(
        id: .init(),
        date: .sepEigth2024,
        memo: "",
        amount: .inflow(1000),
        isCleared: true,
        payee: .reorg,
        category: .readyToAssign,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let sepRent = BudgetTransaction(
        id: .init(),
        date: .sepEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .anthonyMartin,
        category: .rent,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let sepCouncilTax = BudgetTransaction(
        id: .init(),
        date: .sepNinth2024,
        memo: "",
        amount: .outflow(0),
        isCleared: true,
        payee: .bexley,
        category: .councilTax,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let sepUtilities = BudgetTransaction(
        id: .init(),
        date: .sepNinth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .eonNext,
        category: .utilities,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let sepWater = BudgetTransaction(
        id: .init(),
        date: .sepTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .thamesWater,
        category: .water,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let sepInternet = BudgetTransaction(
        id: .init(),
        date: .sepFourteenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .plusnet,
        category: .internet,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let sepTvLicense = BudgetTransaction(
        id: .init(),
        date: .sepTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .tvLicence,
        category: .tvLicense,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let sepCellPhones = BudgetTransaction(
        id: .init(),
        date: .sepTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .giffGaff,
        category: .cellPhones,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let sepGroceries1 = BudgetTransaction(
        id: .init(),
        date: .sepEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let sepGroceries2 = BudgetTransaction(
        id: .init(),
        date: .sepEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let sepGroceries3 = BudgetTransaction(
        id: .init(),
        date: .sepTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let sepGroceries4 = BudgetTransaction(
        id: .init(),
        date: .sepFourteenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let sepGroceries5 = BudgetTransaction(
        id: .init(),
        date: .sepEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    // October 2024
    
    static let octSalary = BudgetTransaction(
        id: .init(),
        date: .octEigth2024,
        memo: "",
        amount: .inflow(1000),
        isCleared: true,
        payee: .reorg,
        category: .readyToAssign,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let octRent = BudgetTransaction(
        id: .init(),
        date: .octEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .anthonyMartin,
        category: .rent,
        account: .hsbc,
        linkedTransactionID: nil
    )
        
    
    static let octCouncilTax = BudgetTransaction(
        id: .init(),
        date: .octNinth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .bexley,
        category: .councilTax,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let octUtilities = BudgetTransaction(
        id: .init(),
        date: .octNinth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .eonNext,
        category: .utilities,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let octWater = BudgetTransaction(
        id: .init(),
        date: .octTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .thamesWater,
        category: .water,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let octInternet = BudgetTransaction(
        id: .init(),
        date: .octFourteenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .plusnet,
        category: .internet,
        account: .hsbc, linkedTransactionID: nil
    )
    
    static let octTvLicense = BudgetTransaction(
        id: .init(),
        date: .octTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .tvLicence,
        category: .tvLicense,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let octCellPhones = BudgetTransaction(
        id: .init(),
        date: .octTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .giffGaff,
        category: .cellPhones,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let octGroceries1 = BudgetTransaction(
        id: .init(),
        date: .octEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let octGroceries2 = BudgetTransaction(
        id: .init(),
        date: .octEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let octGroceries3 = BudgetTransaction(
        id: .init(),
        date: .octTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let octGroceries4 = BudgetTransaction(
        id: .init(),
        date: .octFourteenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: .hsbc,
        linkedTransactionID: nil
    )
    
    static let octGroceries5 = BudgetTransaction(
        id: .init(),
        date: .octEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: .hsbc,
        linkedTransactionID: nil
    )
}

extension TransactionCategory {
    // August 2024
    
    static let readyToAssign = TransactionCategory(
        id: .init(),
        name: "Ready to Assign"
    )
    
    static let rent = TransactionCategory(
        id: .init(),
        name: "Rent"
    )
    
    static let councilTax = TransactionCategory(
        id: .init(),
        name: "Council Tax"
    )
    
    static let utilities = TransactionCategory(
        id: .init(),
        name: "Utilities"
    )
    
    static let water = TransactionCategory(
        id: .init(),
        name: "Water"
    )
    
    static let internet = TransactionCategory(
        id: .init(),
        name: "Internet"
    )

    static let tvLicense = TransactionCategory(
        id: .init(),
        name: "TV License"
    )
    
    static let cellPhones = TransactionCategory(
        id: .init(),
        name: "Cell Phones"
    )
    
    static let groceries = TransactionCategory(
        id: .init(),
        name: "Groceries"
    )
}
