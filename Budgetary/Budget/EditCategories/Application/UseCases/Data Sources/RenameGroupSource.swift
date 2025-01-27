//
//  RenameGroupSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Foundation

public protocol RenameGroupSource {
    func findGroup(by id: String) -> CategoryGroup
    func rename(_ group: CategoryGroup, to name: String)
}

class RenameGroupSourceImpl: RenameGroupSource {
    func findGroup(by id: String) -> CategoryGroup {
        .fun
    }
    
    func rename(_ group: CategoryGroup, to name: String) {
        
    }
}
