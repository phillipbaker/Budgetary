//
//  ActivityPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/11/2024.
//

import Foundation

public struct ActivityPresentation: Equatable {
    let total: String
    let transactions: [TransactionPresentation]
}
