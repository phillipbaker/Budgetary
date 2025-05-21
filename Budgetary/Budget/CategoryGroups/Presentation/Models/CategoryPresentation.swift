//
//  CategoryPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/10/2024.
//

import Foundation

public struct CategoryPresentation: Equatable, Identifiable {
    public let id: String
    let name: String
    let notes: String
    let isHidden: Bool
    let assigned: [MonthYear: AssignedPresentation]
    let activity: [MonthYear: ActivityPresentation]
    let available: [MonthYear: AvailablePresentation]
    
    init(id: String, name: String, notes: String, isHidden: Bool, assigned: [MonthYear : AssignedPresentation], activity: [MonthYear : ActivityPresentation], available: [MonthYear : AvailablePresentation]) {
        self.id = id
        self.name = name
        self.notes = notes
        self.isHidden = isHidden
        self.assigned = assigned
        self.activity = activity
        self.available = available
    }
}
