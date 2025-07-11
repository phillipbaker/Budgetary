//
//  NewPayeeUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/06/2025.
//

import Factory
import Foundation

final class NewPayeeUseCase {
    let source: NewPayeeSource = Container.shared.newPayeeSource()
    let mapper: PayeeMapper = Container.shared.payeeMapper()
    
    func createPayee(from name: String) async {
        let payee = Payee(
            id: UUID().uuidString,
            name: name,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategory: nil
        )

        await source.create(payee: mapper.map(payee: payee))
    }
}
