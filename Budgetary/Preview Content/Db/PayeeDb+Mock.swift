//
//  PayeeDb+Mock.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/12/2024.
//

// MARK: - All

extension [PayeeDb] {
    static var mock: [PayeeDb] {
        [
            .sixtyFiveMM,
            .aa,
            .abeBooks,
            .aldi,
            .amazon,
            .amelia,
            .argos,
            .asda,
            .aviva,
            .bigCorporation,
            .chipotle,
            .cineworld,
            .cleaningService,
            .countyCouncil,
            .creperie,
            .jdSports,
            .landlord,
            .taxi,
            .mammaMia,
            .marksAndSpencer,
            .mcDonalds,
            .networkRail,
            .ocado,
            .origin,
            .royalAcademyOfDance,
            .scienceMuseum,
            .shell,
            .sportsDirect,
            .tateBritain,
            .tesco,
            .thamesWater,
            .bodyShop,
            .cornishBakery,
            .tkMaxx,
            .waitrose,
            .barclays,
            .capitalOneCard,
            .hsbcChecking,
            .hsbcSavings
        ]
    }
}

// MARK: - Fixtures

extension PayeeDb {
    
    // Transfer Payees
    
    static var barclays: PayeeDb {
        PayeeDb(
            externalID: .mock(.barclaysTransfer),
            name: "Barclays",
            type: .transfer,
            aliases: [],
            includedInPayeeList: false,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: nil, // should never have a category
            accountID: .mock(.barclays)
        )
    }

    static var capitalOneCard: PayeeDb {
        PayeeDb(
            externalID: .mock(.capitalOneCardTransfer),
            name: "Capital One Card",
            type: .transfer,
            aliases: [],
            includedInPayeeList: false,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: nil, // should never have a category
            accountID: .mock(.capitalOneCard)
        )
    }
    
    static var hsbcChecking: PayeeDb {
        PayeeDb(
            externalID: .mock(.hsbcCheckingTransfer),
            name: "HSBC Checking",
            type: .transfer,
            aliases: [],
            includedInPayeeList: false,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: nil, // should never have a category
            accountID: .mock(.hsbcChecking)
        )
    }
    
    static var hsbcSavings: PayeeDb {
        PayeeDb(
            externalID: .mock(.hsbcSavingsTransfer),
            name: "HSBC Savings",
            type: .transfer,
            aliases: [],
            includedInPayeeList: false,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: nil, // should never have a category
            accountID: .mock(.hsbcSavings)
        )
    }

    // Regular Payees
    
    static var sixtyFiveMM: PayeeDb {
        PayeeDb(
            externalID: .mock(.sixtyFiveMM),
            name: "65mm Coffee",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: .mock(.phil),
            accountID: nil
        )
    }
    
    static var aa: PayeeDb {
        PayeeDb(
            externalID: .mock(.aa),
            name: "AA",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryID: .mock(.carServiceRepairs),
            accountID: nil
        )
    }
    
    static var abeBooks: PayeeDb {
        PayeeDb(
            externalID: .mock(.abeBooks),
            name: "AbeBooks",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryID: .mock(.phil),
            accountID: nil
        )
    }
    
    static var aldi: PayeeDb {
        PayeeDb(
            externalID: .mock(.aldi),
            name: "Aldi",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: .mock(.groceries),
            accountID: nil
        )
    }
    
    static var amazon: PayeeDb {
        PayeeDb(
            externalID: .mock(.amazon),
            name: "Amazon",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryID: nil,
            accountID: nil
        )
    }
    
    static var amelia: PayeeDb {
        PayeeDb(
            externalID: .mock(.amelia),
            name: "Amelia Bakery",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: .mock(.takeout),
            accountID: nil
        )
    }
    
    static var argos: PayeeDb {
        PayeeDb(
            externalID: .mock(.argos),
            name: "Argos",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: nil,
            accountID: nil
        )
    }
    
    static var asda: PayeeDb {
        PayeeDb(
            externalID: .mock(.asda),
            name: "Asda",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryID: .mock(.groceries),
            accountID: nil
        )
    }
    
    static var aviva: PayeeDb {
        PayeeDb(
            externalID: .mock(.aviva),
            name: "Aviva",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: .mock(.carInsurance),
            accountID: nil
        )
    }
    
    static var bigCorporation: PayeeDb {
        PayeeDb(
            externalID: .mock(.bigCorporation),
            name: "Big Corporation",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryID: .mock(.inflow),
            accountID: nil
        )
    }
    
    static var chipotle: PayeeDb {
        PayeeDb(
            externalID: .mock(.chipotle),
            name: "Chipotle",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: nil,
            accountID: nil
        )
    }
    
    static var cineworld: PayeeDb {
        PayeeDb(
            externalID: .mock(.cineworld),
            name: "Cineworld",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: .mock(.familyActivities),
            accountID: nil
        )
    }
    
    static var cleaningService: PayeeDb {
        PayeeDb(
            externalID: .mock(.cleaningService),
            name: "Cleaning Service",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryID: nil,
            accountID: nil
        )
    }
    
    static var countyCouncil: PayeeDb {
        PayeeDb(
            externalID: .mock(.countyCouncil),
            name: "County Council",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryID: .mock(.councilTax),
            accountID: nil
        )
    }
    
    static var creperie: PayeeDb {
        PayeeDb(
            externalID: .mock(.creperie),
            name: "French Crêperie",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryID: nil,
            accountID: nil
        )
    }
    
    static var jdSports: PayeeDb {
        PayeeDb(
            externalID: .mock(.jdSports),
            name: "JD Sports",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryID: nil,
            accountID: nil
        )
    }
    
    static var landlord: PayeeDb {
        PayeeDb(
            externalID: .mock(.landlord),
            name: "Landlord",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryID: .mock(.rent),
            accountID: nil
        )
    }
    
    static var taxi: PayeeDb {
        PayeeDb(
            externalID: .mock(.taxi),
            name: "London Taxi",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryID: nil,
            accountID: nil
        )
    }
    
    static var mammaMia: PayeeDb {
        PayeeDb(
            externalID: .mock(.mammaMia),
            name: "Mamma Mia",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryID: nil,
            accountID: nil
        )
    }
    
    static var marksAndSpencer: PayeeDb {
        PayeeDb(
            externalID: .mock(.marksAndSpencer),
            name: "Marks & Spencer",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryID: nil,
            accountID: nil
        )
    }
    
    static var mcDonalds: PayeeDb {
        PayeeDb(
            externalID: .mock(.mcDonalds),
            name: "McDonald’s",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryID: .mock(.takeout),
            accountID: nil
        )
    }
    
    static var networkRail: PayeeDb {
        PayeeDb(
            externalID: .mock(.networkRail),
            name: "Network Rail",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: .mock(.commuting),
            accountID: nil
        )
    }
    
    static var ocado: PayeeDb {
        PayeeDb(
            externalID: .mock(.ocado),
            name: "Ocado",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: .mock(.groceries),
            accountID: nil
        )
    }
    
    static var origin: PayeeDb {
        PayeeDb(
            externalID: .mock(.origin),
            name: "Origin Coffee",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: nil,
            accountID: nil
        )
    }
    
    static var royalAcademyOfDance: PayeeDb {
        PayeeDb(
            externalID: .mock(.royalAcademyOfDance),
            name: "Royal Academy of Dance",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryID: .mock(.familyActivities),
            accountID: nil
        )
    }
    
    static var scienceMuseum: PayeeDb {
        PayeeDb(
            externalID: .mock(.scienceMuseum),
            name: "Science Museum",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: .mock(.familyActivities),
            accountID: nil
        )
    }
    
    static var shell: PayeeDb {
        PayeeDb(
            externalID: .mock(.shell),
            name: "Shell Oil",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: .mock(.petrolTolls),
            accountID: nil
        )
    }
    
    static var sportsDirect: PayeeDb {
        PayeeDb(
            externalID: .mock(.sportsDirect),
            name: "Sports Direct",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryID: .mock(.kidsClothes),
            accountID: nil
        )
    }
    
    static var tateBritain: PayeeDb {
        PayeeDb(
            externalID: .mock(.tateBritain),
            name: "Tate Britain",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: nil,
            accountID: nil
        )
    }
    
    static var tesco: PayeeDb {
        PayeeDb(
            externalID: .mock(.tesco),
            name: "Tesco",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryID: .mock(.groceries),
            accountID: nil
        )
    }
    
    static var thamesWater: PayeeDb {
        PayeeDb(
            externalID: .mock(.thamesWater),
            name: "Thames Water",
            type: .regular,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: .mock(.water),
            accountID: nil
        )
    }
    
        static var bodyShop: PayeeDb {
            PayeeDb(
                externalID: .mock(.bodyShop),
                name: "The Body Shop",
                type: .regular,
                aliases: [],
                includedInPayeeList: true,
                automaticallyCategorizeIsOn: false,
                defaultCategoryID: nil,
                accountID: nil
            )
        }
    
        static var cornishBakery: PayeeDb {
            PayeeDb(
                externalID: .mock(.cornishBakery),
                name: "The Cornish Bakery",
                type: .regular,
                aliases: [],
                includedInPayeeList: true,
                automaticallyCategorizeIsOn: false,
                defaultCategoryID: nil,
                accountID: nil
            )
        }
    
        static var tkMaxx: PayeeDb {
            PayeeDb(
                externalID: .mock(.tkMaxx),
                name: "TK Maxx",
                type: .regular,
                aliases: [],
                includedInPayeeList: true,
                automaticallyCategorizeIsOn: false,
                defaultCategoryID: nil,
                accountID: nil
            )
        }
    
        static var waitrose: PayeeDb {
            PayeeDb(
                externalID: .mock(.waitrose),
                name: "Waitrose",
                type: .regular,
                aliases: [],
                includedInPayeeList: true,
                automaticallyCategorizeIsOn: false,
                defaultCategoryID: nil,
                accountID: nil
            )
        }
}
