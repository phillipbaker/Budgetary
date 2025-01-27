//
//  CategoryDbPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/11/2024.
//

import Foundation

extension CategoryDb: @unchecked Sendable {
    
    static let inflow = CategoryDb(
        id: "99",
        name: "Inflow: Ready to Assign",
        notes: "",
        isHidden: false,
        assigned: [:]
    )
    
    // MARK: - Immediate Obligations
    
    static let rent = CategoryDb(
        id: "1",
        name: "Rent",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let countilTax = CategoryDb(
        id: "2",
        name: "Council Tax",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let utilities = CategoryDb(
        id: "3",
        name: "Utilities",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 50.00,
        ]
    )
    
    static let water = CategoryDb(
        id: "4",
        name: "Water",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 60.00,
            .oct2024: 0.00,
        ]
    )
    
    static let internet = CategoryDb(
        id: "5",
        name: "Internet",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 50.00,
            .oct2024: 0.00,
        ]
    )
    
    static let tvLicense = CategoryDb(
        id: "6",
        name: "TV License",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let cellPhones = CategoryDb(
        id: "7",
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
    
    static let ynab = CategoryDb(
        id: "8",
        name: "YNAB",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let birthdays = CategoryDb(
        id: "9",
        name: "Birthdays",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let christmas = CategoryDb(
        id: "10",
        name: "Christmas",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )

    static let lifeInsurance = CategoryDb(
        id: "11",
        name: "Life Insurance",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let roadTax = CategoryDb(
        id: "12",
        name: "Road Tax",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let carInsurance = CategoryDb(
        id: "13",
        name: "Car Insurance",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let homeInsurance = CategoryDb(
        id: "14",
        name: "Home Insurance",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let carServiceRepairs = CategoryDb(
        id: "15",
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
    
    static let groceries = CategoryDb(
        id: "16",
        name: "Groceries",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let commuting = CategoryDb(
        id: "17",
        name: "Commuting",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let classesCamps = CategoryDb(
        id: "18",
        name: "Classes/Camps",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let petrolTolls = CategoryDb(
        id: "19",
        name: "Gasoline/Tolls",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let homeSupplies = CategoryDb(
        id: "20",
        name: "Home Supplies",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let homeImprovement = CategoryDb(
        id: "21",
        name: "Home Improvement",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let kidsClothes = CategoryDb(
        id: "22",
        name: "Kids’ Clothes",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let gifts = CategoryDb(
        id: "23",
        name: "Gifts",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let doctors = CategoryDb(
        id: "24",
        name: "Doctors",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let amazonPrime = CategoryDb(
        id: "25",
        name: "Amazon Prime",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let prescriptions = CategoryDb(
        id: "26",
        name: "Prescriptions",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let atmBankFees = CategoryDb(
        id: "27",
        name: "ATM/Bank Fees",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let miscellaneous = CategoryDb(
        id: "28",
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
    
    static let phil = CategoryDb(
        id: "29",
        name: "Phil",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let kids = CategoryDb(
        id: "30",
        name: "Kids",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let school = CategoryDb(
        id: "31",
        name: "School",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let streaming = CategoryDb(
        id: "32",
        name: "Streaming",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
        
    static let familyActivities = CategoryDb(
        id: "33",
        name: "Family Activities",
        notes: "",
        isHidden: false,
        assigned: [
            .aug2024: 0.00,
            .sep2024: 0.00,
            .oct2024: 0.00,
        ]
    )
    
    static let takeout = CategoryDb(
        id: "34",
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
