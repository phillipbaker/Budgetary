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
    private let container: ModelContainer
    let mapper: CategoryGroupsMapperPlain
    
    private let (stream, continuation) = AsyncStream.makeStream(of: [CategoryGroupPlain].self)
    
    init(container: ModelContainer, mapper: CategoryGroupsMapperPlain) {
        self.container = container
        self.mapper = mapper
        startStreaming()
    }
    
    func startStreaming() {
        continuation.yield(mapper.mapDbToPlain(categoryGroupsDb: mock))
    }

    func streamCategoryGroups() -> AsyncStream<[CategoryGroupPlain]> {
        return stream
    }
    
    func findCategoryGroup(by id: String) -> CategoryGroupDb {
        return mock.first(where: { $0.id == id }) ?? .obligations
    }
    
    func findCategory(by id: String) -> CategoryDb {
        return mock
            .first(where: { $0.categories.contains(where: { $0.id == id }) })?
            .categories.first(where: { $0.id == id })
        ?? .amazonPrime
    }
    
    func update(category: CategoryDb) {
        guard let group = mock.first(where: { $0.categories.contains(where: { $0.id == category.id }) }) else { return }
        let updatedCategories = group.categories.map { $0.id == category.id ? category : $0 }
        let updatedGroup = CategoryGroupDb(id: group.id, name: group.name, categories: updatedCategories)
        let newMock = mock.map { $0.id == group.id ? updatedGroup : $0 }
        mock = newMock
        continuation.yield(mapper.mapDbToPlain(categoryGroupsDb: mock))
    }
    
    func create(categoryGroup: CategoryGroupDb) {
        
    }
    
    func update(categoryGroup: CategoryGroupDb) {
        
    }
    
    func delete(categoryGroup: CategoryGroupDb) {
        
    }
    
    private var mock: [CategoryGroupDb] = [
        CategoryGroupDb(
        id: "1",
        name: "Immediate Obligations",
        categories: [
            CategoryDb(
                id: "1",
                name: "Rent",
                notes: "",
                isHidden: false,
                assigned: [
                    .aug2024: 0.00,
                    .sep2024: 0.00,
                    .oct2024: 0.00,
                    .apr2025: 100.00
                ]
            ),
            CategoryDb(
                id: "2",
                name: "Council Tax",
                notes: "",
                isHidden: false,
                assigned: [
                    .aug2024: 311.00,
                    .sep2024: 312.00,
                    .oct2024: 313.00,
                ]
            ),
            CategoryDb(
                id: "3",
                name: "Utilities",
                notes: "",
                isHidden: false,
                assigned: [
                    .aug2024: 0.00,
                    .sep2024: 0.00,
                    .oct2024: 50.00,
                ]
            )
        ]
    ),
        CategoryGroupDb(
            id: "2",
            name: "True Expenses",
            categories: [
                CategoryDb(
                    id: "8",
                    name: "YNAB",
                    notes: "",
                    isHidden: false,
                    assigned: [
                        .aug2024: 10.00,
                        .sep2024: 11.00,
                        .oct2024: 12.00,
                        .apr2025: 100.00
                    ]
                )
            ]
            ),
        CategoryGroupDb(
            id: "3",
            name: "Monthly Expenses",
            categories: [
                CategoryDb(
                    id: "16",
                    name: "Groceries",
                    notes: "",
                    isHidden: false,
                    assigned: [
                        .aug2024: 0.00,
                        .sep2024: 0.00,
                        .oct2024: 0.00,
                    ]
                )
            ]
        ),
        CategoryGroupDb(
            id: "4",
            name: "Fun",
            categories: [
                CategoryDb(
                    id: "29",
                    name: "Phil",
                    notes: "",
                    isHidden: false,
                    assigned: [
                        .aug2024: 0.00,
                        .sep2024: 0.00,
                        .oct2024: 0.00,
                        .apr2025: 100.00
                    ]
                )
            ]
        )
    ]
}
