//
//  CategoryPresentation+Preview.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/11/2024.
//

import Foundation

extension CategoryPresentation: @unchecked Sendable {
    // MARK: - Immediate Obligations
    
    static let readyToAssign = CategoryPresentation(
        id: UUID().uuidString,
        name: "Ready to Assign",
        notes: "",
        isHidden: false,
        assigned: [.sep2024: AssignedPresentation(
            assignedThisMonth: "£90[:]",
            assignedLastMonth: "",
            spentLastMonth: "",
            averageAssigned: "",
            averageSpent: ""
        )],
        activity: [.sep2024: ActivityPresentation(
            id: "23",
            total: "",
            transactions: [TransactionPresentation(
                id: "",
                date: .now,
                memo: "",
                amount: AmountPresentation(transactionType: .inflow, value: "120.00"),
                isCleared: true,
                payee: PayeePresentation(id: "", name: "Sainsbury’s"),
                category: TransactionCategoryPresentation(id: "", name: "Groceries"),
                account: TransactionAccountPresentation(id: "2", name: "HSBC - Joint")
            )]
        )],
        available: [.sep2024: AvailablePresentation(
            total: "",
            cashFromLastMonth: "",
            assignedThisMonth: "",
            cashSpendingThisMonth: "",
            message: "",
            lightModeForegroundColor: .accentColor,
            lightModeBackgroundColor: .accentColor,
            darkModeForegroundColor: .accentColor,
            darkModeBackgroundColor: .accentColor,
            maxAvailableForReassignment: 100.00
        )]
    )
    
    static let rent = CategoryPresentation(
        id: UUID().uuidString,
        name: "Rent",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let councilTax = CategoryPresentation(
        id: UUID().uuidString,
        name: "Council Tax",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let utilities = CategoryPresentation(
        id: UUID().uuidString,
        name: "Utilities",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let water = CategoryPresentation(
        id: UUID().uuidString,
        name: "Water",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let internet = CategoryPresentation(
        id: UUID().uuidString,
        name: "Internet",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let tvLicense = CategoryPresentation(
        id: UUID().uuidString,
        name: "TV License",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let cellPhones = CategoryPresentation(
        id: UUID().uuidString,
        name: "Cell Phones",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    

    // MARK: - CategoryPresentation: True Expenses
    
    static let ynab = CategoryPresentation(
        id: UUID().uuidString,
        name: "YNAB",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let birthdays = CategoryPresentation(
        id: UUID().uuidString,
        name: "Birthdays",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let christmas = CategoryPresentation(
        id: UUID().uuidString,
        name: "Christmas",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )

    static let lifeInsurance = CategoryPresentation(
        id: UUID().uuidString,
        name: "Life Insurance",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let roadTax = CategoryPresentation(
        id: UUID().uuidString,
        name: "Road Tax",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let carInsurance = CategoryPresentation(
        id: UUID().uuidString,
        name: "Car Insurance",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let homeInsurance = CategoryPresentation(
        id: UUID().uuidString,
        name: "Home Insurance",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let carServiceRepairs = CategoryPresentation(
        id: UUID().uuidString,
        name: "Car Service/Repairs",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    
    // MARK: - CategoryPresentation: Monthly Expenses
    
    static let groceries = CategoryPresentation(
        id: UUID().uuidString,
        name: "Groceries",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let commuting = CategoryPresentation(
        id: UUID().uuidString,
        name: "Commuting",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let classesCamps = CategoryPresentation(
        id: UUID().uuidString,
        name: "Classes/Camps",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let petrolTolls = CategoryPresentation(
        id: UUID().uuidString,
        name: "Gasoline/Tolls",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let homeSupplies = CategoryPresentation(
        id: UUID().uuidString,
        name: "Home Supplies",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let homeImprovement = CategoryPresentation(
        id: UUID().uuidString,
        name: "Home Improvement",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let kidsClothes = CategoryPresentation(
        id: UUID().uuidString,
        name: "Kids’ Clothes",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let gifts = CategoryPresentation(
        id: UUID().uuidString,
        name: "Gifts",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let doctors = CategoryPresentation(
        id: UUID().uuidString,
        name: "Doctors",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let amazonPrime = CategoryPresentation(
        id: UUID().uuidString,
        name: "Amazon Prime",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let prescriptions = CategoryPresentation(
        id: UUID().uuidString,
        name: "Prescriptions",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let atmBankFees = CategoryPresentation(
        id: UUID().uuidString,
        name: "ATM/Bank Fees",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let miscellaneous = CategoryPresentation(
        id: UUID().uuidString,
        name: "Miscellaneous",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    
    // MARK: - CategoryPresentation: Fun
    
    static let phil = CategoryPresentation(
        id: UUID().uuidString,
        name: "Phil",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let kids = CategoryPresentation(
        id: UUID().uuidString,
        name: "Kids",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let school = CategoryPresentation(
        id: UUID().uuidString,
        name: "School",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let streaming = CategoryPresentation(
        id: UUID().uuidString,
        name: "Streaming",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
        
    static let familyActivities = CategoryPresentation(
        id: UUID().uuidString,
        name: "Family Activities",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let takeout = CategoryPresentation(
        id: UUID().uuidString,
        name: "Eating Out/Takeout",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
}
