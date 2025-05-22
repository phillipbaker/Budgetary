//
//  GetAccountsSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

public protocol GetAccountsSource {
    func accountsData() async -> CombinedAccountsData
}
