//
//  PayeesDbPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/12/2024.
//

extension Array where Element == PayeeDb {
    static let mock: [PayeeDb] = [
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
        .cineworld
    ]
}

extension PayeeDb: @unchecked Sendable {
    static let anthonyMartin = PayeeDb(
        id: "1",
        name: "Anthony Martin",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "1"
    )
    
    static let councilTax = PayeeDb(
        id: "2",
        name: "Council Tax",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "2"
    )
    
    static let amazon = PayeeDb(
        id: "3",
        name: "Amazon",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let octus = PayeeDb(
        id: "4",
        name: "Octus",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "4"
    )
    
    static let marksAndSpencer = PayeeDb(
        id: "5",
        name: "Marks & Spencer",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "5"
    )
    
    static let monica = PayeeDb(
        id: "6",
        name: "Monica Taylor",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "6"
    )
    
    static let skinTonic = PayeeDb(
        id: "7",
        name: "Skin & Tonic",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "7"
    )
    
    static let townley = PayeeDb(
        id: "8",
        name: "Townley Grammar School",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "8"
    )
    
    static let taxi = PayeeDb(
        id: "9",
        name: "London Taxi",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let jdSports = PayeeDb(
        id: "10",
        name: "JD Sports",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let maidToClean = PayeeDb(
        id: "11",
        name: "Maid To Clean",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let royalAcademyOfDance = PayeeDb(
        id: "12",
        name: "Royal Academy of Dance",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: ""
    )
    
    static let sportsDirect = PayeeDb(
        id: "13",
        name: "Sports Direct",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let tesco = PayeeDb(
        id: "14",
        name: "Tesco",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let asda = PayeeDb(
        id: "15",
        name: "Asda",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let hextable = PayeeDb(
        id: "16",
        name: "Hextable Primary School",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let simplyFood = PayeeDb(
        id: "17",
        name: "M&S Simply Food",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let macInASac = PayeeDb(
        id: "18",
        name: "Mac in a Sac",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let madeleines = PayeeDb(
        id: "19",
        name: "Madeleine’s Creperie",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let magicMemories = PayeeDb(
        id: "20",
        name: "Magic Memories",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let mahan = PayeeDb(
        id: "21",
        name: "Mahan",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let mammaMia = PayeeDb(
        id: "22",
        name: "Mamma Mia",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let manorPark = PayeeDb(
        id: "23",
        name: "Manor Park Country Park",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let brownies = PayeeDb(
        id: "24",
        name: "1st Baldwyn’s Park Brownies",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let aa = PayeeDb(
        id: "25",
        name: "AA",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let abeBooks = PayeeDb(
        id: "26",
        name: "Abe Books",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let masterFryer = PayeeDb(
        id: "27",
        name: "Master Fryer",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let mcDonalds = PayeeDb(
        id: "28",
        name: "McDonald’s",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let meluccis = PayeeDb(
        id: "29",
        name: "Melucci’s",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let salman = PayeeDb(
        id: "30",
        name: "Salman Kahn",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let schoolGateway = PayeeDb(
        id: "31",
        name: "School Gateway",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let scienceMuseum = PayeeDb(
        id: "32",
        name: "Science Museum",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let shell = PayeeDb(
        id: "33",
        name: "Shell Oil",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let shirtPocket = PayeeDb(
        id: "34",
        name: "Shirt Pocket",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let tkMaxx = PayeeDb(
        id: "35",
        name: "TK Maxx",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let tateBritain = PayeeDb(
        id: "36",
        name: "Tate Britain",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let armouryStore = PayeeDb(
        id: "37",
        name: "The Armoury Store",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let athletic = PayeeDb(
        id: "38",
        name: "The Athletic",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let thamesWater = PayeeDb(
        id: "39",
        name: "Thames Water",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let bodyShop = PayeeDb(
        id: "40",
        name: "The Body Shop",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let cornishBakery = PayeeDb(
        id: "41",
        name: "The Cornish Bakery",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let apple = PayeeDb(
        id: "42",
        name: "Apple",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let backblaze = PayeeDb(
        id: "43",
        name: "Backblaze",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let linear = PayeeDb(
        id: "44",
        name: "Linear",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let namecheap = PayeeDb(
        id: "45",
        name: "Namecheap",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let argos = PayeeDb(
        id: "46",
        name: "Argos",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let origin = PayeeDb(
        id: "47",
        name: "Origin Coffee",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let aviva = PayeeDb(
        id: "48",
        name: "Aviva",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let sixtyFiveMM = PayeeDb(
        id: "49",
        name: "65mm Coffee",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let barrels = PayeeDb(
        id: "50",
        name: "Barrels",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let bespokeAutocentre = PayeeDb(
        id: "51",
        name: "Bespoke Autocentre",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let southeastern = PayeeDb(
        id: "52",
        name: "Southeastern",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let waitrose = PayeeDb(
        id: "53",
        name: "Waitrose",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let ocado = PayeeDb(
        id: "54",
        name: "Ocado",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let aldi = PayeeDb(
        id: "55",
        name: "Aldi",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let jade = PayeeDb(
        id: "56",
        name: "Jade",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let amelia = PayeeDb(
        id: "57",
        name: "Amelia Bakery",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let bakersOfBexley = PayeeDb(
        id: "58",
        name: "Bakers of Bexley",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let chipotle = PayeeDb(
        id: "59",
        name: "Chipotle",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
    
    static let cineworld = PayeeDb(
        id: "60",
        name: "Cineworld",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategoryId: "3"
    )
}
