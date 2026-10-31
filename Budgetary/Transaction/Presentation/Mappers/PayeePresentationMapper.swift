//
//  PayeePresentationMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import Foundation

public final class PayeePresentationMapper {
    func map(payees: [Payee]) -> PayeePickerDataPresentation {
        let transferPayees = payees.filter { payee in
            if case .transfer = payee.type { return true }
            return false
        }
        
        return PayeePickerDataPresentation(
            alphabeticalPayees: map(payees: payees),
            transferPayees: transferPayees.map { map(payee: $0) }
        )
    }
    
    func map(payees: [Payee]) -> [PayeeName] {
        payees
            .filter {
                if case .regular = $0.type { return true }
                return false
            }
            .filter { $0.includedInPayeeList }
            .alphabeticalSections(by: \.name)
            .map { section in
                PayeeName(
                    letter: section.letter,
                    payees: section.elements.map { map(payee: $0) }
                )
            }
    }
    
    func map(payee: Payee) -> PayeePresentation {
        return PayeePresentation(
            id: ID<PayeePresentation>(payee.id),
            name: payee.name,
            type: map(payeeType: payee.type)
        )
    }
    
    func map(payeeType: PayeeType) -> PayeeTypePresentation {
        switch payeeType {
        case .regular: .regular
        case .transfer(let accountID): .transfer(ID<BudgetAccountPresentation>(accountID))
        }
    }
}
