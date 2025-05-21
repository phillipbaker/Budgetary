//
//  ActivityPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/11/2024.
//

import Foundation

public struct ActivityPresentation: Equatable, Identifiable {
    public let id: String
    let total: String
    let transactions: [TransactionPresentation]
}
