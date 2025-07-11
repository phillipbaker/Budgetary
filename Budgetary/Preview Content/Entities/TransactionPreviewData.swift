//
//  TransactionPreviews.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/09/2024.
//

import Foundation

extension Array where Element == TransactionEntity {
    static let preview: [TransactionEntity] = [
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

extension TransactionEntity {
    // August 2024
    
    static let augSalary = TransactionEntity(
        id: "",
        date: .augEigth2024,
        memo: "",
        amount: .inflow(1000),
        isCleared: true,
        payee: .reorg,
        category: .readyToAssign,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let augRent = TransactionEntity(
        id: "",
        date: .augEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .anthonyMartin,
        category: .rent,
        account: TransactionAccount(id: "4", name: "HSBC")

    )
    
    static let augCouncilTax = TransactionEntity(
        id: "",
        date: .augNinth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .bexley,
        category: .councilTax,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let augUtilities = TransactionEntity(
        id: "",
        date: .augNinth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .eonNext,
        category: .utilities,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let augWater = TransactionEntity(
        id: "",
        date: .augTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .thamesWater,
        category: .water,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let augInternet = TransactionEntity(
        id: "",
        date: .augFourteenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .plusnet,
        category: .internet,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let augTvLicense = TransactionEntity(
        id: "",
        date: .augTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .tvLicence,
        category: .tvLicense,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let augCellPhones = TransactionEntity(
        id: "",
        date: .augTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .giffGaff,
        category: .cellPhones,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let augGroceries1 = TransactionEntity(
        id: "",
        date: .augEigth2024,
        memo: "",
        amount: .outflow(300),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let augGroceries2 = TransactionEntity(
        id: "",
        date: .augEigth2024,
        memo: "",
        amount: .outflow(200),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let augGroceries3 = TransactionEntity(
        id: "",
        date: .augTenth2024,
        memo: "",
        amount: .outflow(200),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let augGroceries4 = TransactionEntity(
        id: "",
        date: .augFourteenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let augGroceries5 = TransactionEntity(
        id: "",
        date: .augEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    // September 2024
    
    static let sepSalary = TransactionEntity(
        id: "",
        date: .sepEigth2024,
        memo: "",
        amount: .inflow(1000),
        isCleared: true,
        payee: .reorg,
        category: .readyToAssign,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let sepRent = TransactionEntity(
        id: "",
        date: .sepEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .anthonyMartin,
        category: .rent,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let sepCouncilTax = TransactionEntity(
        id: "",
        date: .sepNinth2024,
        memo: "",
        amount: .outflow(0),
        isCleared: true,
        payee: .bexley,
        category: .councilTax,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let sepUtilities = TransactionEntity(
        id: "",
        date: .sepNinth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .eonNext,
        category: .utilities,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let sepWater = TransactionEntity(
        id: "",
        date: .sepTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .thamesWater,
        category: .water,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let sepInternet = TransactionEntity(
        id: "",
        date: .sepFourteenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .plusnet,
        category: .internet,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let sepTvLicense = TransactionEntity(
        id: "",
        date: .sepTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .tvLicence,
        category: .tvLicense,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let sepCellPhones = TransactionEntity(
        id: "",
        date: .sepTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .giffGaff,
        category: .cellPhones,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let sepGroceries1 = TransactionEntity(
        id: "",
        date: .sepEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let sepGroceries2 = TransactionEntity(
        id: "",
        date: .sepEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let sepGroceries3 = TransactionEntity(
        id: "",
        date: .sepTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let sepGroceries4 = TransactionEntity(
        id: "",
        date: .sepFourteenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let sepGroceries5 = TransactionEntity(
        id: "",
        date: .sepEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    // October 2024
    
    static let octSalary = TransactionEntity(
        id: "",
        date: .octEigth2024,
        memo: "",
        amount: .inflow(1000),
        isCleared: true,
        payee: .reorg,
        category: .readyToAssign,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let octRent = TransactionEntity(
        id: "",
        date: .octEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .anthonyMartin,
        category: .rent,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let octCouncilTax = TransactionEntity(
        id: "",
        date: .octNinth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .bexley,
        category: .councilTax,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let octUtilities = TransactionEntity(
        id: "",
        date: .octNinth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .eonNext,
        category: .utilities,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let octWater = TransactionEntity(
        id: "",
        date: .octTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .thamesWater,
        category: .water,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let octInternet = TransactionEntity(
        id: "",
        date: .octFourteenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .plusnet,
        category: .internet,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let octTvLicense = TransactionEntity(
        id: "",
        date: .octTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .tvLicence,
        category: .tvLicense,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let octCellPhones = TransactionEntity(
        id: "",
        date: .octTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .giffGaff,
        category: .cellPhones,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let octGroceries1 = TransactionEntity(
        id: "",
        date: .octEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let octGroceries2 = TransactionEntity(
        id: "",
        date: .octEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let octGroceries3 = TransactionEntity(
        id: "",
        date: .octTenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let octGroceries4 = TransactionEntity(
        id: "",
        date: .octFourteenth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
    
    static let octGroceries5 = TransactionEntity(
        id: "",
        date: .octEigth2024,
        memo: "",
        amount: .outflow(100),
        isCleared: true,
        payee: .sainsburys,
        category: .groceries,
        account: TransactionAccount(id: "4", name: "HSBC")
    )
}

extension TransactionCategory {
    // August 2024
    
    static let readyToAssign = TransactionCategory(
        id: UUID().uuidString,
        name: "Ready to Assign"
    )
    
    static let rent = TransactionCategory(
        id: UUID().uuidString,
        name: "Rent"
    )
    
    static let councilTax = TransactionCategory(
        id: UUID().uuidString,
        name: "Council Tax"
    )
    
    static let utilities = TransactionCategory(
        id: UUID().uuidString,
        name: "Utilities"
    )
    
    static let water = TransactionCategory(
        id: UUID().uuidString,
        name: "Water"
    )
    
    static let internet = TransactionCategory(
        id: UUID().uuidString,
        name: "Internet"
    )

    static let tvLicense = TransactionCategory(
        id: UUID().uuidString,
        name: "TV License"
    )
    
    static let cellPhones = TransactionCategory(
        id: UUID().uuidString,
        name: "Cell Phones"
    )
    
    static let groceries = TransactionCategory(
        id: UUID().uuidString,
        name: "Groceries"
    )
}
