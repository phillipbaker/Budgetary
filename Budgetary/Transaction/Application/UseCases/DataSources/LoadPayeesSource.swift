//
//  LoadPayeesSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/05/2025.
//

public protocol LoadPayeesSource: Sendable {
    func loadPayeeData() async -> PayeeDataPlain
}
