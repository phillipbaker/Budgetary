//
//  CatagoryPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/09/2024.
//

extension Category {
    // MARK: - Category: Immediate Obligations
    
    static let readyToAssign = Category(
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
    
    static let rent = Category(
        id: .init(),
        name: "Rent",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let councilTax = Category(
        id: .init(),
        name: "Council Tax",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let utilities = Category(
        id: .init(),
        name: "Utilities",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let water = Category(
        id: .init(),
        name: "Water",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let internet = Category(
        id: .init(),
        name: "Internet",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let tvLicense = Category(
        id: .init(),
        name: "TV License",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let cellPhones = Category(
        id: .init(),
        name: "Cell Phones",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    
    // MARK: - Category: True Expenses
    
    static let ynab = Category(
        id: .init(),
        name: "YNAB",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let birthdays = Category(
        id: .init(),
        name: "Birthdays",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let christmas = Category(
        id: .init(),
        name: "Christmas",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let lifeInsurance = Category(
        id: .init(),
        name: "Life Insurance",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let roadTax = Category(
        id: .init(),
        name: "Road Tax",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let carInsurance = Category(
        id: .init(),
        name: "Car Insurance",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let homeInsurance = Category(
        id: .init(),
        name: "Home Insurance",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let carServiceRepairs = Category(
        id: .init(),
        name: "Car Service/Repairs",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    
    // MARK: - Category: Monthly Expenses
    
    static let groceries = Category(
        id: .init(),
        name: "Groceries",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let commuting = Category(
        id: .init(),
        name: "Commuting",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let classesCamps = Category(
        id: .init(),
        name: "Classes/Camps",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let petrolTolls = Category(
        id: .init(),
        name: "Gasoline/Tolls",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let homeSupplies = Category(
        id: .init(),
        name: "Home Supplies",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let homeImprovement = Category(
        id: .init(),
        name: "Home Improvement",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let kidsClothes = Category(
        id: .init(),
        name: "Kids’ Clothes",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let gifts = Category(
        id: .init(),
        name: "Gifts",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let doctors = Category(
        id: .init(),
        name: "Doctors",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let amazonPrime = Category(
        id: .init(),
        name: "Amazon Prime",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let prescriptions = Category(
        id: .init(),
        name: "Prescriptions",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let atmBankFees = Category(
        id: .init(),
        name: "ATM/Bank Fees",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let miscellaneous = Category(
        id: .init(),
        name: "Miscellaneous",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    
    // MARK: - Category: Fun
    
    static let phil = Category(
        id: .init(),
        name: "Phil",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let kids = Category(
        id: .init(),
        name: "Kids",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let school = Category(
        id: .init(),
        name: "School",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let streaming = Category(
        id: .init(),
        name: "Streaming",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let familyActivities = Category(
        id: .init(),
        name: "Family Activities",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
    
    static let takeout = Category(
        id: .init(),
        name: "Eating Out/Takeout",
        notes: "",
        isHidden: false,
        assigned: [:],
        activity: [:],
        available: [:]
    )
}
