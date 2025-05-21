//
//  GetAccountsSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

public protocol GetAccountsSource: Sendable {
    func getAccountsData() async -> CombinedAccountsData
}
