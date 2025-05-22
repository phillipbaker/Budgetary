//
//  GetAccountsStreamSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

public protocol GetAccountsStreamSource: Sendable {
    func accountsData() async -> AsyncStream<CombinedAccountsData>
}
