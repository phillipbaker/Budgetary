//
//  CreditCardPaymentGroupDao.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/11/2025.
//

import Factory
import Foundation
import SwiftData

class CreditCardPaymentGroupDao {
    private let container: ModelContainer
    let mapper: CreditCardPaymentGroupMapperPlain = Container.shared.creditCardPaymentGroupMapperPlain()
    
    private let (stream, continuation) = AsyncStream.makeStream(of: CreditCardPaymentGroupPlain.self)
    
    init(container: ModelContainer) {
        self.container = container
        startStreaming()
    }
    
    func startStreaming() {
        continuation.yield(mapper.mapDbToPlain(creditCardPaymentGroupDb: mock))
    }
    
    func loadCreditCardPaymentGroup() -> CreditCardPaymentGroupDb {
        return mock
    }
    
    func streamCreditCardPaymentGroup() -> AsyncStream<CreditCardPaymentGroupPlain> {
        return stream
    }
    
    func update(creditCardPaymentGroup: CreditCardPaymentGroupDb) {
        mock = creditCardPaymentGroup
        continuation.yield(mapper.mapDbToPlain(creditCardPaymentGroupDb: mock))
    }
    
    private var mock: CreditCardPaymentGroupDb = CreditCardPaymentGroupDb(
        externalID: .init(),
        payments: [
            CreditCardPaymentDb(
                externalID: .init(),
                name: "Capital One Card",
                isHidden: false,
                assigned: [.currentMonthYear: 0.00],
                accountID: UUID(uuidString: "00000000-0000-0000-0000-000000000999")!
            )
        ]
    )
}
