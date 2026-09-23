//
//  CatagoryPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/09/2024.
//

extension CategoryRow {
    // MARK: - Category: Immediate Obligations
    
    static let readyToAssign = CategoryRow(
        id: .init(),
        name: "Ready To Assign",
        notes: "",
        isHidden: false,
        assigned: [.sep2024: Assigned(
            assignedThisMonth: 1_000.00,
            assignedLastMonth: 900.00,
            spentLastMonth: 800.00,
            averageAssigned: 900.00,
            averageSpent: 850.00
        )],
        activity: [.sep2024: Activity(total: 900.00, transactions: [])],
        available: [.sep2024: Available(
            total: 0.00,
            cashFromLastMonth: 0.00,
            assignedThisMonth: 0.00,
            cashSpendingThisMonth: 0.00,
            message: ""
        )]
    )
    
    static let rent = CategoryRow(
        id: .init(),
        name: "Rent",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let councilTax = CategoryRow(
        id: .init(),
        name: "Council Tax",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let utilities = CategoryRow(
        id: .init(),
        name: "Utilities",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let water = CategoryRow(
        id: .init(),
        name: "Water",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let internet = CategoryRow(
        id: .init(),
        name: "Internet",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let tvLicense = CategoryRow(
        id: .init(),
        name: "TV License",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let cellPhones = CategoryRow(
        id: .init(),
        name: "Cell Phones",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    
    // MARK: - Category: True Expenses
    
    static let ynab = CategoryRow(
        id: .init(),
        name: "YNAB",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let birthdays = CategoryRow(
        id: .init(),
        name: "Birthdays",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let christmas = CategoryRow(
        id: .init(),
        name: "Christmas",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let lifeInsurance = CategoryRow(
        id: .init(),
        name: "Life Insurance",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let roadTax = CategoryRow(
        id: .init(),
        name: "Road Tax",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let carInsurance = CategoryRow(
        id: .init(),
        name: "Car Insurance",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let homeInsurance = CategoryRow(
        id: .init(),
        name: "Home Insurance",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let carServiceRepairs = CategoryRow(
        id: .init(),
        name: "Car Service/Repairs",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    
    // MARK: - Category: Monthly Expenses
    
    static let groceries = CategoryRow(
        id: .init(),
        name: "Groceries",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let commuting = CategoryRow(
        id: .init(),
        name: "Commuting",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let classesCamps = CategoryRow(
        id: .init(),
        name: "Classes/Camps",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let petrolTolls = CategoryRow(
        id: .init(),
        name: "Gasoline/Tolls",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let homeSupplies = CategoryRow(
        id: .init(),
        name: "Home Supplies",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let homeImprovement = CategoryRow(
        id: .init(),
        name: "Home Improvement",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let kidsClothes = CategoryRow(
        id: .init(),
        name: "Kids’ Clothes",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let gifts = CategoryRow(
        id: .init(),
        name: "Gifts",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let doctors = CategoryRow(
        id: .init(),
        name: "Doctors",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let amazonPrime = CategoryRow(
        id: .init(),
        name: "Amazon Prime",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let prescriptions = CategoryRow(
        id: .init(),
        name: "Prescriptions",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let atmBankFees = CategoryRow(
        id: .init(),
        name: "ATM/Bank Fees",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let miscellaneous = CategoryRow(
        id: .init(),
        name: "Miscellaneous",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    
    // MARK: - Category: Fun
    
    static let phil = CategoryRow(
        id: .init(),
        name: "Phil",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let kids = CategoryRow(
        id: .init(),
        name: "Kids",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let school = CategoryRow(
        id: .init(),
        name: "School",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let streaming = CategoryRow(
        id: .init(),
        name: "Streaming",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let familyActivities = CategoryRow(
        id: .init(),
        name: "Family Activities",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let takeout = CategoryRow(
        id: .init(),
        name: "Eating Out/Takeout",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
}
