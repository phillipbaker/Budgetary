//
//  CategoryDbPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/11/2024.
//

import Foundation

extension CategoryDb {
    @MainActor static let inflow = CategoryDb(
        externalID: .init(),
        name: "Inflow: Ready to Assign",
        notes: "",
        isHidden: false,
        assigned: [:]
    )
    
    // MARK: - Immediate Obligations
    
    @MainActor static let rent = CategoryDb(
        externalID: .init(),
        name: "Rent",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let countilTax = CategoryDb(
        externalID: .init(),
        name: "Council Tax",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let utilities = CategoryDb(
        externalID: .init(),
        name: "Utilities",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 50.00,
        ]
    )
    
    @MainActor static let water = CategoryDb(
        externalID: .init(),
        name: "Water",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 60.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let internet = CategoryDb(
        externalID: .init(),
        name: "Internet",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 50.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let tvLicense = CategoryDb(
        externalID: .init(),
        name: "TV License",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let cellPhones = CategoryDb(
        externalID: .init(),
        name: "Cell Phones",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    

    // MARK: - True Expenses
    
    @MainActor static let ynab = CategoryDb(
        externalID: .init(),
        name: "YNAB",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let birthdays = CategoryDb(
        externalID: .init(),
        name: "Birthdays",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let christmas = CategoryDb(
        externalID: .init(),
        name: "Christmas",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )

    @MainActor static let lifeInsurance = CategoryDb(
        externalID: .init(),
        name: "Life Insurance",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let roadTax = CategoryDb(
        externalID: .init(),
        name: "Road Tax",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let carInsurance = CategoryDb(
        externalID: .init(),
        name: "Car Insurance",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let homeInsurance = CategoryDb(
        externalID: .init(),
        name: "Home Insurance",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let carServiceRepairs = CategoryDb(
        externalID: .init(),
        name: "Car Service/Repairs",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    
    // MARK: - Monthly Expenses
    
    @MainActor static let groceries = CategoryDb(
        externalID: .init(),
        name: "Groceries",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let commuting = CategoryDb(
        externalID: .init(),
        name: "Commuting",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let classesCamps = CategoryDb(
        externalID: .init(),
        name: "Classes/Camps",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let petrolTolls = CategoryDb(
        externalID: .init(),
        name: "Gasoline/Tolls",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let homeSupplies = CategoryDb(
        externalID: .init(),
        name: "Home Supplies",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let homeImprovement = CategoryDb(
        externalID: .init(),
        name: "Home Improvement",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let kidsClothes = CategoryDb(
        externalID: .init(),
        name: "Kids’ Clothes",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let gifts = CategoryDb(
        externalID: .init(),
        name: "Gifts",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let doctors = CategoryDb(
        externalID: .init(),
        name: "Doctors",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let amazonPrime = CategoryDb(
        externalID: .init(),
        name: "Amazon Prime",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let prescriptions = CategoryDb(
        externalID: .init(),
        name: "Prescriptions",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let atmBankFees = CategoryDb(
        externalID: .init(),
        name: "ATM/Bank Fees",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let miscellaneous = CategoryDb(
        externalID: .init(),
        name: "Miscellaneous",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    
    // MARK: - Fun
    
    @MainActor static let phil = CategoryDb(
        externalID: .init(),
        name: "Phil",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let kids = CategoryDb(
        externalID: .init(),
        name: "Kids",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let school = CategoryDb(
        externalID: .init(),
        name: "School",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let streaming = CategoryDb(
        externalID: .init(),
        name: "Streaming",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
        
    @MainActor static let familyActivities = CategoryDb(
        externalID: .init(),
        name: "Family Activities",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    @MainActor static let takeout = CategoryDb(
        externalID: .init(),
        name: "Eating Out/Takeout",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
}
