//
//  CategoryRowPresentation+Preview.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/11/2024.
//

import Foundation

typealias CategoryPreview = CategoryRowPresentation<CategoryAssignedPresentation, CategoryActivityPresentation, CategoryAvailablePresentation>

extension CategoryPreview: @unchecked Sendable {
    // MARK: - Immediate Obligations
    
    static let readyToAssign = CategoryPreview(
        id: .init(),
        name: "Ready to Assign",
        notes: "",
        isHidden: false,
        assigned: [.sep2024: CategoryAssignedPresentation(
            assignedThisMonth: "£90[:]",
            assignedLastMonth: "",
            averageAssigned: "",
            spentLastMonth: "",
            averageSpent: ""
        )],
        activity: [.sep2024: CategoryActivityPresentation(
            activityTotal: "",
            transactions: [TransactionPresentation(
                id: .init(),
                date: .now,
                memo: "",
                amount: AmountPresentation(type: .inflow, value: "120.00"),
                isCleared: true,
                payee: PayeePresentation(id: .init(), name: "Sainsbury’s", type: .regular),
                category: TransactionCategoryPresentation(id: .init(), name: "Groceries"),
                account: TransactionAccountPresentation(id: .init(), name: "HSBC - Joint"),
                linkedTransactionID: nil
            )]
        )],
        available: [.sep2024: CategoryAvailablePresentation(
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
    
    static let rent = CategoryPreview(
        id: .init(),
        name: "Rent",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let councilTax = CategoryPreview(
        id: .init(),
        name: "Council Tax",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let utilities = CategoryPreview(
        id: .init(),
        name: "Utilities",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let water = CategoryPreview(
        id: .init(),
        name: "Water",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let internet = CategoryPreview(
        id: .init(),
        name: "Internet",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let tvLicense = CategoryPreview(
        id: .init(),
        name: "TV License",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let cellPhones = CategoryPreview(
        id: .init(),
        name: "Cell Phones",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    

    // MARK: - CategoryPreview: True Expenses
    
    static let ynab = CategoryPreview(
        id: .init(),
        name: "YNAB",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let birthdays = CategoryPreview(
        id: .init(),
        name: "Birthdays",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let christmas = CategoryPreview(
        id: .init(),
        name: "Christmas",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )

    static let lifeInsurance = CategoryPreview(
        id: .init(),
        name: "Life Insurance",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let roadTax = CategoryPreview(
        id: .init(),
        name: "Road Tax",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let carInsurance = CategoryPreview(
        id: .init(),
        name: "Car Insurance",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let homeInsurance = CategoryPreview(
        id: .init(),
        name: "Home Insurance",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let carServiceRepairs = CategoryPreview(
        id: .init(),
        name: "Car Service/Repairs",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    
    // MARK: - CategoryPreview: Monthly Expenses
    
    static let groceries = CategoryPreview(
        id: .init(),
        name: "Groceries",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let commuting = CategoryPreview(
        id: .init(),
        name: "Commuting",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let classesCamps = CategoryPreview(
        id: .init(),
        name: "Classes/Camps",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let petrolTolls = CategoryPreview(
        id: .init(),
        name: "Gasoline/Tolls",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let homeSupplies = CategoryPreview(
        id: .init(),
        name: "Home Supplies",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let homeImprovement = CategoryPreview(
        id: .init(),
        name: "Home Improvement",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let kidsClothes = CategoryPreview(
        id: .init(),
        name: "Kids’ Clothes",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let gifts = CategoryPreview(
        id: .init(),
        name: "Gifts",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let doctors = CategoryPreview(
        id: .init(),
        name: "Doctors",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let amazonPrime = CategoryPreview(
        id: .init(),
        name: "Amazon Prime",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let prescriptions = CategoryPreview(
        id: .init(),
        name: "Prescriptions",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let atmBankFees = CategoryPreview(
        id: .init(),
        name: "ATM/Bank Fees",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let miscellaneous = CategoryPreview(
        id: .init(),
        name: "Miscellaneous",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    
    // MARK: - CategoryPreview: Fun
    
    static let phil = CategoryPreview(
        id: .init(),
        name: "Phil",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let kids = CategoryPreview(
        id: .init(),
        name: "Kids",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let school = CategoryPreview(
        id: .init(),
        name: "School",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let streaming = CategoryPreview(
        id: .init(),
        name: "Streaming",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
        
    static let familyActivities = CategoryPreview(
        id: .init(),
        name: "Family Activities",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let takeout = CategoryPreview(
        id: .init(),
        name: "Eating Out/Takeout",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
}

