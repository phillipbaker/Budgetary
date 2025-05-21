//
//  PayeePresentationMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import Foundation

public final class PayeePresentationMapper {
    func map(payees: [Payee]) -> [PayeeName] {
        let grouped = Dictionary(grouping: payees, by: { $0.name.prefix(1) })
        let sorted = grouped.sorted { $0.key < $1.key }

        return sorted.map { letter, payees in
            let mapped = payees.map { payee in
                map(payee: payee)
            }
            return PayeeName(
                id: UUID().uuidString,
                letter: String(letter),
                payees: mapped.sorted { $0.name < $1.name } // Sorts payees alphabetically within letter sections
            )
        }
    }
    
    func map(payee: Payee) -> PayeePresentation {
        return PayeePresentation(id: payee.id, name: payee.name)
    }
}
