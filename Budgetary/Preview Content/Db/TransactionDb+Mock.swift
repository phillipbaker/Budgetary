//
//  TransactionDb+Mock.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/11/2026.
//

extension TransactionDb {
    static var sepInflow: TransactionDb {
        TransactionDb(
            externalID: .mock(.sepInflow),
            date: .sepEighth2024,
            memo: "",
            amount: .inflow(100),
            isCleared: true,
            payeeID: .mock(.bigCorporation),
            categoryID: .mock(.readyToAssign)
        )
    }
    
    static var octInflow: TransactionDb {
        TransactionDb(
            externalID: .mock(.octInflow),
            date: .octEighth2024,
            memo: "",
            amount: .inflow(100),
            isCleared: true,
            payeeID: .mock(.bigCorporation),
            categoryID: .mock(.readyToAssign)
        )
    }
    
    static var octAA: TransactionDb {
        TransactionDb(
            externalID: .mock(.octAA),
            date: .octEighth2024,
            memo: "",
            amount: .outflow(40),
            isCleared: true,
            payeeID: .mock(.aa),
            categoryID: .mock(.carServiceRepairs)
        )
    }
    
    static var novInflow: TransactionDb {
        TransactionDb(
            externalID: .mock(.novInflow),
            date: .novEighth2024,
            memo: "",
            amount: .inflow(1000),
            isCleared: true,
            payeeID: .mock(.bigCorporation),
            categoryID: .mock(.readyToAssign)
        )
    }
    
    static var novRent: TransactionDb {
        TransactionDb(
            externalID: .mock(.novRent),
            date: .novEighth2024,
            memo: "Memo goes here...",
            amount: .outflow(500),
            isCleared: true,
            payeeID: .mock(.landlord),
            categoryID: .mock(.rent)
        )
    }
    
    static var decInflow: TransactionDb {
        TransactionDb(
            externalID: .mock(.decInflow),
            date: .decEighth2024,
            memo: "",
            amount: .inflow(100),
            isCleared: true,
            payeeID: .mock(.bigCorporation),
            categoryID: .mock(.readyToAssign)
        )
    }
}
