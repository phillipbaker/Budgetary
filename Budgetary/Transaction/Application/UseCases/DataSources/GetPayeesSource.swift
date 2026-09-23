//
//  GetPayeesSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/05/2025.
//

public protocol GetPayeesSource: Sendable {
    func getPayeeData() async -> CombinedPayeeData
}
