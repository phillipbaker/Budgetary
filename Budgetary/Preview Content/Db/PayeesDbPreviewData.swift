//
//  PayeesDbPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/12/2024.
//

extension Array where Element == PayeeDb {
    nonisolated(unsafe) static let mock: [PayeeDb] = [
        .anthonyMartin,
        .amazon,
        .councilTax,
        .octus,
        .marksAndSpencer,
        .monica,
        .skinTonic,
        .townley,
        .taxi,
        .jdSports,
        .maidToClean,
        .royalAcademyOfDance,
        .sportsDirect,
        .tesco,
        .asda,
        .hextable,
        .simplyFood,
        .macInASac,
        .madeleines,
        .magicMemories,
        .mahan,
        .mammaMia,
        .manorPark,
        .brownies,
        .aa,
        .masterFryer,
        .mcDonalds,
        .abeBooks,
        .meluccis,
        .salman,
        .schoolGateway,
        .scienceMuseum,
        .shell,
        .shirtPocket,
        .tkMaxx,
        .tateBritain,
        .armouryStore,
        .athletic,
        .thamesWater,
        .bodyShop,
        .cornishBakery,
        .apple,
        .backblaze,
        .linear,
        .namecheap,
        .origin,
        .argos,
        .aviva,
        .sixtyFiveMM,
        .barrels,
        .bespokeAutocentre,
        .southeastern,
        .waitrose,
        .ocado,
        .aldi,
        .jade,
        .amelia,
        .bakersOfBexley,
        .chipotle,
        .cineworld,
        .hsbcChecking,
        .hsbcSavings,
        .barclays,
        .capitalOneCard
    ]
}

extension PayeeDb {
    
    // Transfer Payees
    
    nonisolated(unsafe) static let hsbcChecking = PayeeDb(
        externalID: .init(),
        name: "HSBC Checking",
        type: .transfer,
        aliases: [],
        includedInPayeeList: false,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: nil, // should never have a category?
        accountID: .hsbcChecking
    )
    
    nonisolated(unsafe) static let hsbcSavings = PayeeDb(
        externalID: .init(),
        name: "HSBC Savings",
        type: .transfer,
        aliases: [],
        includedInPayeeList: false,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: nil, // should never have a category?
        accountID: .hsbcSavings
    )
    
    nonisolated(unsafe) static let barclays = PayeeDb(
        externalID: .init(),
        name: "Barclays",
        type: .transfer,
        aliases: [],
        includedInPayeeList: false,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: nil, // should never have a category?
        accountID: .barclays
    )

    nonisolated(unsafe) static let capitalOneCard = PayeeDb(
        externalID: .init(),
        name: "Capital One Card",
        type: .transfer,
        aliases: [],
        includedInPayeeList: false,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: nil, // should never have a category?
        accountID: .capitalOneCard
    )

    // Regular Payees
    
    nonisolated(unsafe) static let anthonyMartin = PayeeDb(
        externalID: .init(),
        name: "Anthony Martin",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let councilTax = PayeeDb(
        externalID: .init(),
        name: "Council Tax",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let amazon = PayeeDb(
        externalID: .init(),
        name: "Amazon",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let octus = PayeeDb(
        externalID: .init(),
        name: "Octus",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let marksAndSpencer = PayeeDb(
        externalID: .init(),
        name: "Marks & Spencer",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let monica = PayeeDb(
        externalID: .init(),
        name: "Monica Taylor",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let skinTonic = PayeeDb(
        externalID: .init(),
        name: "Skin & Tonic",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let townley = PayeeDb(
        externalID: .init(),
        name: "Townley Grammar School",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let taxi = PayeeDb(
        externalID: .init(),
        name: "London Taxi",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let jdSports = PayeeDb(
        externalID: .init(),
        name: "JD Sports",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let maidToClean = PayeeDb(
        externalID: .init(),
        name: "Maid To Clean",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let royalAcademyOfDance = PayeeDb(
        externalID: .init(),
        name: "Royal Academy of Dance",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let sportsDirect = PayeeDb(
        externalID: .init(),
        name: "Sports Direct",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let tesco = PayeeDb(
        externalID: .init(),
        name: "Tesco",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let asda = PayeeDb(
        externalID: .init(),
        name: "Asda",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let hextable = PayeeDb(
        externalID: .init(),
        name: "Hextable Primary School",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let simplyFood = PayeeDb(
        externalID: .init(),
        name: "M&S Simply Food",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let macInASac = PayeeDb(
        externalID: .init(),
        name: "Mac in a Sac",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let madeleines = PayeeDb(
        externalID: .init(),
        name: "Madeleine’s Creperie",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let magicMemories = PayeeDb(
        externalID: .init(),
        name: "Magic Memories",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let mahan = PayeeDb(
        externalID: .init(),
        name: "Mahan",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let mammaMia = PayeeDb(
        externalID: .init(),
        name: "Mamma Mia",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let manorPark = PayeeDb(
        externalID: .init(),
        name: "Manor Park Country Park",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let brownies = PayeeDb(
        externalID: .init(),
        name: "1st Baldwyn’s Park Brownies",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let aa = PayeeDb(
        externalID: .init(),
        name: "AA",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let abeBooks = PayeeDb(
        externalID: .init(),
        name: "Abe Books",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let masterFryer = PayeeDb(
        externalID: .init(),
        name: "Master Fryer",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let mcDonalds = PayeeDb(
        externalID: .init(),
        name: "McDonald’s",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let meluccis = PayeeDb(
        externalID: .init(),
        name: "Melucci’s",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let salman = PayeeDb(
        externalID: .init(),
        name: "Salman Kahn",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let schoolGateway = PayeeDb(
        externalID: .init(),
        name: "School Gateway",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let scienceMuseum = PayeeDb(
        externalID: .init(),
        name: "Science Museum",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let shell = PayeeDb(
        externalID: .init(),
        name: "Shell Oil",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let shirtPocket = PayeeDb(
        externalID: .init(),
        name: "Shirt Pocket",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let tkMaxx = PayeeDb(
        externalID: .init(),
        name: "TK Maxx",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let tateBritain = PayeeDb(
        externalID: .init(),
        name: "Tate Britain",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let armouryStore = PayeeDb(
        externalID: .init(),
        name: "The Armoury Store",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let athletic = PayeeDb(
        externalID: .init(),
        name: "The Athletic",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let thamesWater = PayeeDb(
        externalID: .init(),
        name: "Thames Water",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let bodyShop = PayeeDb(
        externalID: .init(),
        name: "The Body Shop",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let cornishBakery = PayeeDb(
        externalID: .init(),
        name: "The Cornish Bakery",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let apple = PayeeDb(
        externalID: .init(),
        name: "Apple",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let backblaze = PayeeDb(
        externalID: .init(),
        name: "Backblaze",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let linear = PayeeDb(
        externalID: .init(),
        name: "Linear",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let namecheap = PayeeDb(
        externalID: .init(),
        name: "Namecheap",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let argos = PayeeDb(
        externalID: .init(),
        name: "Argos",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let origin = PayeeDb(
        externalID: .init(),
        name: "Origin Coffee",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let aviva = PayeeDb(
        externalID: .init(),
        name: "Aviva",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let sixtyFiveMM = PayeeDb(
        externalID: .init(),
        name: "65mm Coffee",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let barrels = PayeeDb(
        externalID: .init(),
        name: "Barrels",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let bespokeAutocentre = PayeeDb(
        externalID: .init(),
        name: "Bespoke Autocentre",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let southeastern = PayeeDb(
        externalID: .init(),
        name: "Southeastern",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let waitrose = PayeeDb(
        externalID: .init(),
        name: "Waitrose",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let ocado = PayeeDb(
        externalID: .init(),
        name: "Ocado",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let aldi = PayeeDb(
        externalID: .init(),
        name: "Aldi",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let jade = PayeeDb(
        externalID: .init(),
        name: "Jade",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let amelia = PayeeDb(
        externalID: .init(),
        name: "Amelia Bakery",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let bakersOfBexley = PayeeDb(
        externalID: .init(),
        name: "Bakers of Bexley",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let chipotle = PayeeDb(
        externalID: .init(),
        name: "Chipotle",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
    
    nonisolated(unsafe) static let cineworld = PayeeDb(
        externalID: .init(),
        name: "Cineworld",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryID: .init(),
        accountID: nil
    )
}
