//
//  TransactionPresentationState.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/01/2026.
//

import SwiftUI
import Foundation

public struct TransactionPresentationState: Sendable {
    let currencyCode: String
    let isNewTransaction: Bool
    let transaction: TransactionPresentation?
}
