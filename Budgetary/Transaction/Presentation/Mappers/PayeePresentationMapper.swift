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
        let regularPayees = payees.filter { payee in
            if case .regular = payee.type { return true }
            return false
        }
        let includedRegularPayees = regularPayees.filter { payee in
            payee.includedInPayeeList == true
        }
        
        let grouped = Dictionary(grouping: includedRegularPayees, by: { $0.name.sectionLetter })
        
        let sections = grouped.sorted { lhs, rhs in
            switch (lhs.key, rhs.key) {
            case ("#", _): true
            case (_, "#"): false
            default: lhs.key < rhs.key
            }
        }

        return sections.map { letter, payees in
            let mapped = payees.map { payee in
                map(payee: payee)
            }
            return PayeeName(
                letter: letter,
                payees: mapped.sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
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
