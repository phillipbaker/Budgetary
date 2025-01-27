//
//  CategoryGroupsDao.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/11/2024.
//

import Dependencies
import Foundation
import SwiftData

class CategoryGroupDao {
    private var container: ModelContainer
    let mapper = CategoryGroupsMapperPlain()
    
    init(container: ModelContainer) {
        self.container = container
    }

    @MainActor
    func streamCategoryGroups() -> AsyncStream<[CategoryGroupPlain]> {
        let (stream, continuation) = AsyncStream.makeStream(of: [CategoryGroupPlain].self)
        continuation.yield(mapper.mapDbToPlain(categoryGroupsDb: .mock))
        return stream
    }
    
    func findCategoryGroup(by id: String) -> CategoryGroupDb {
        return .obligations
    }
    
    func create(categoryGroup: CategoryGroupDb) {
        
    }
    
    func update(categoryGroup: CategoryGroupDb) {
        
    }
    
    func delete(categoryGroup: CategoryGroupDb) {
        
    }
}
