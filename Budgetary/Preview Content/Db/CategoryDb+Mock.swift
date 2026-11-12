//
//  CategoryDb+Mock.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/11/2024.
//

import Foundation

extension CategoryDb {
    
    // MARK: - Inflow

    static var readyToAssign: CategoryDb {
        CategoryDb(
            externalID: .mock(.readyToAssign),
            name: "Ready to Assign",
            notes: "",
            isHidden: false,
            assigned: [:]
        )
    }
    
    // MARK: - Immediate Obligations
    
    static var rent: CategoryDb {
        CategoryDb(
            externalID: .mock(.rent),
            name: "Rent",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var councilTax: CategoryDb {
        CategoryDb(
            externalID: .mock(.councilTax),
            name: "Council Tax",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var utilities: CategoryDb {
        CategoryDb(
            externalID: .mock(.utilities),
            name: "Utilities",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 50.00,
            ]
        )
    }
    
    static var water: CategoryDb {
        CategoryDb(
            externalID: .mock(.water),
            name: "Water",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 60.00,
                .oct2024: 0.00,
            ]
        )
    }

    static var internet: CategoryDb {
        CategoryDb(
            externalID: .mock(.internet),
            name: "Internet",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 50.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var tvLicense: CategoryDb {
        CategoryDb(
            externalID: .mock(.tvLicense),
            name: "TV License",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var cellPhones: CategoryDb {
        CategoryDb(
            externalID: .mock(.cellPhones),
            name: "Cell Phones",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }

    // MARK: - True Expenses
    
    static var birthdays: CategoryDb {
        CategoryDb(
            externalID: .mock(.birthdays),
            name: "Birthdays",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var christmas: CategoryDb {
        CategoryDb(
            externalID: .mock(.christmas),
            name: "Christmas",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var lifeInsurance: CategoryDb {
        CategoryDb(
            externalID: .mock(.lifeInsurance),
            name: "Life Insurance",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var roadTax: CategoryDb {
        CategoryDb(
            externalID: .mock(.roadTax),
            name: "Road Tax",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var carInsurance: CategoryDb {
        CategoryDb(
            externalID: .mock(.carInsurance),
            name: "Car Insurance",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var homeInsurance: CategoryDb {
        CategoryDb(
            externalID: .mock(.homeInsurance),
            name: "Home Insurance",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var carServiceRepairs: CategoryDb {
        CategoryDb(
            externalID: .mock(.carServiceRepairs),
            name: "Car Service/Repairs",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    // MARK: - Monthly Expenses
    
    static var groceries: CategoryDb {
        CategoryDb(
            externalID: .mock(.groceries),
            name: "Groceries",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var commuting: CategoryDb {
        CategoryDb(
            externalID: .mock(.commuting),
            name: "Commuting",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var classesCamps: CategoryDb {
        CategoryDb(
            externalID: .mock(.classesCamps),
            name: "Classes/Camps",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var petrolTolls: CategoryDb {
        CategoryDb(
            externalID: .mock(.petrolTolls),
            name: "Gasoline/Tolls",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var homeSupplies: CategoryDb {
        CategoryDb(
            externalID: .mock(.homeSupplies),
            name: "Home Supplies",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var homeImprovement: CategoryDb {
        CategoryDb(
            externalID: .mock(.homeImprovement),
            name: "Home Improvement",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var kidsClothes: CategoryDb {
        CategoryDb(
            externalID: .mock(.kidsClothes),
            name: "Kids’ Clothes",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var gifts: CategoryDb {
        CategoryDb(
            externalID: .mock(.gifts),
            name: "Gifts",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var doctors: CategoryDb {
        CategoryDb(
            externalID: .mock(.doctors),
            name: "Doctors",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var amazonPrime: CategoryDb {
        CategoryDb(
            externalID: .mock(.amazonPrime),
            name: "Amazon Prime",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var prescriptions: CategoryDb {
        CategoryDb(
            externalID: .mock(.prescriptions),
            name: "Prescriptions",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var atmBankFees: CategoryDb {
        CategoryDb(
            externalID: .mock(.atmBankFees),
            name: "ATM/Bank Fees",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var school: CategoryDb {
        CategoryDb(
            externalID: .mock(.school),
            name: "School",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var miscellaneous: CategoryDb {
        CategoryDb(
            externalID: .mock(.miscellaneous),
            name: "Miscellaneous",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    // MARK: - Fun
    
    static var phil: CategoryDb {
        CategoryDb(
            externalID: .mock(.phil),
            name: "Phil",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var kids: CategoryDb {
        CategoryDb(
            externalID: .mock(.kids),
            name: "Kids",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var streaming: CategoryDb {
        CategoryDb(
            externalID: .mock(.streaming),
            name: "Streaming",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
        
    static var familyActivities: CategoryDb {
        CategoryDb(
            externalID: .mock(.familyActivities),
            name: "Family Activities",
            notes: "",
            isHidden: false,
            assigned: [
                .aug2024: 0.00,
                .sep2024: 0.00,
                .oct2024: 0.00,
            ]
        )
    }
    
    static var takeout: CategoryDb {
        CategoryDb(
            externalID: .mock(.takeout),
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
}
