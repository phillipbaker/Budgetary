//
//  BudgetRowPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/12/2025.
//

public enum BudgetRowTag {}
public typealias BudgetRowID = ID<BudgetRowTag>

public protocol BudgetRowPresentation: Equatable, Identifiable where ID == BudgetRowID {
    associatedtype As: AssignedPresentation
    associatedtype Ac: ActivityPresentation
    associatedtype Av: AvailablePresentation

    var id: BudgetRowID { get }
    var name: String { get }
    var isHidden: Bool { get }
    var assigned: [MonthYear: As] { get }
    var activity: [MonthYear: Ac] { get }
    var available: [MonthYear: Av] { get }
}

public protocol BudgetMonthRowPresentation: Equatable, Identifiable where ID == BudgetRowID {
    associatedtype As: AssignedPresentation
    associatedtype Ac: ActivityPresentation
    associatedtype Av: AvailablePresentation

    var id: BudgetRowID { get }
    var name: String { get }
    var isHidden: Bool { get }
    var assigned: As { get }
    var activity: Ac { get }
    var available: Av { get }
}
