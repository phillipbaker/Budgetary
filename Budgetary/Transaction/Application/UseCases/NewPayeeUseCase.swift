//
//  NewPayeeUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/06/2025.
//

import Factory
import Foundation

final class NewPayeeUseCase: Sendable {
    let source: NewPayeeSource = Container.shared.newPayeeSource()
    let mapper: PayeeMapper = Container.shared.payeeMapper()
    
    func execute(for name: String) async {
        let payee = Payee.regular(name: name)
        await source.create(payee: mapper.map(payee: payee))
    }
}
